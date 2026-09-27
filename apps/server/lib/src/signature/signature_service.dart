import 'dart:convert';

import 'package:connectors/connectors.dart' show verifySignature;
import 'package:logging/logging.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import '../files/file_store.dart';
import '../sync/sync_service.dart';
import 'yousign_client.dart';

final _log = Logger('signature');

/// Signature électronique des devis : envoi au contact via Yousign ; à la
/// signature (webhook ou actualisation), le devis passe « accepté » et le
/// PDF signé est joint à la fiche de l'organisation.
final class SignatureService {
  SignatureService({
    required this._db,
    required this._sync,
    required this._files,
    required this._client,
    required this._webhookSecret,
  });

  final Database _db;
  final SyncService _sync;
  final FileStore _files;
  final YousignClient? _client;
  final String? _webhookSecret;

  bool get configured => _client != null;

  YousignClient get _yousign =>
      _client ??
      (throw const ApiException.badRequest(
        'Signature électronique non configurée (clé Yousign absente).',
      ));

  static SignatureInfo _info(Map<String, dynamic> r) => SignatureInfo(
    id: r['id'] as String,
    invoiceId: r['invoice_id'] as String,
    signerName: r['signer_name'] as String,
    signerEmail: r['signer_email'] as String,
    status: r['status'] as String,
    signedFileId: r['signed_file_id'] as String?,
    error: r['error'] as String?,
    createdAt: r['created_at'] as DateTime,
    updatedAt: r['updated_at'] as DateTime,
  );

  Future<List<SignatureInfo>> list(AuthContext ctx, String invoiceId) async {
    ctx.require(Permission.invoiceRead);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT * FROM signature_requests WHERE invoice_id = @id '
        'ORDER BY created_at DESC',
        {'id': invoiceId},
      ),
    );
    return [for (final r in rows) _info(r)];
  }

  /// Envoie le devis émis [invoiceId] pour signature au contact
  /// [contactId] (email requis).
  Future<SignatureInfo> send(
    AuthContext ctx,
    String invoiceId,
    SendSignatureRequest request,
  ) async {
    ctx.require(Permission.invoiceWrite);
    final client = _yousign;
    final (doc, contact) = await _db.run((s) async {
      final doc = isValidId(invoiceId)
          ? await s.queryOne(
              'SELECT * FROM invoices WHERE id = @id AND deleted_at IS NULL',
              {'id': invoiceId},
            )
          : null;
      final contact = isValidId(request.contactId)
          ? await s.queryOne(
              'SELECT * FROM contacts WHERE id = @id AND deleted_at IS NULL',
              {'id': request.contactId},
            )
          : null;
      return (doc, contact);
    });
    if (doc == null) throw const ApiException.notFound('Devis introuvable.');
    if (doc['kind'] != DocumentKind.quote.key ||
        doc['number'] == null ||
        doc['pdf_file_id'] == null) {
      throw const ApiException.badRequest(
        'Seul un devis émis peut être envoyé pour signature.',
      );
    }
    if (doc['status'] != DocumentStatus.sent.key) {
      throw const ApiException.badRequest('Ce devis n’attend plus de réponse.');
    }
    final email = contact?['email'] as String?;
    if (contact == null || email == null) {
      throw const ApiException.validation([
        ValidationIssue(
          field: 'contact_id',
          code: ValidationCodes.required,
          message: 'Le signataire doit avoir une adresse email.',
        ),
      ]);
    }
    final pdf = await _files.open(
      ctx,
      doc['pdf_file_id'] as String,
      permission: Permission.invoiceRead,
    );
    final lastName = contact['last_name'] as String;
    final firstName = contact['first_name'] as String? ?? lastName;
    final String providerId;
    try {
      providerId = await client.send(
        name: 'Devis ${doc['number']}',
        pdf: await pdf.file.readAsBytes(),
        fileName: '${doc['number']}.pdf',
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
    } on SignatureException catch (e) {
      throw ApiException(502, ApiErrorCodes.badRequest, e.message);
    }
    final row = await _db.tx((tx) async {
      final row = await tx.queryOne(
        'INSERT INTO signature_requests (id, provider, provider_id, '
        'invoice_id, contact_id, signer_name, signer_email, status, '
        "created_by) VALUES (@id, 'yousign', @p, @inv, @c, @n, @e, "
        "'ongoing', @u) RETURNING *",
        {
          'id': newId(),
          'p': providerId,
          'inv': invoiceId,
          'c': request.contactId,
          'n': '$firstName $lastName',
          'e': email,
          'u': ctx.userId,
        },
      );
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.signatureSent,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'invoices',
          entityId: invoiceId,
          payload: {'number': doc['number'], 'signer': email},
          ip: ctx.meta.ip,
        ),
      );
      return row!;
    });
    return _info(row);
  }

  /// Interroge Yousign (si le webhook n'est pas configuré).
  Future<SignatureInfo> refresh(AuthContext ctx, String id) async {
    ctx.require(Permission.invoiceRead);
    final row = isValidId(id)
        ? await _db.run(
            (s) => s.queryOne(
              'SELECT * FROM signature_requests WHERE id = @id',
              {'id': id},
            ),
          )
        : null;
    if (row == null) throw const ApiException.notFound('Demande introuvable.');
    if (row['status'] != 'ongoing') return _info(row);
    try {
      return _info(
        await _apply(row, await _yousign.status(row['provider_id'] as String)),
      );
    } on SignatureException catch (e) {
      throw ApiException(502, ApiErrorCodes.badRequest, e.message);
    }
  }

  /// Notification Yousign (`X-Yousign-Signature-256`, HMAC SHA-256 du
  /// corps par le secret du webhook).
  Future<void> webhook(List<int> body, String? signature) async {
    final secret = _webhookSecret;
    if (secret == null ||
        !verifySignature(secret, body, _normalize(signature))) {
      throw const ApiException.unauthenticated(
        'Signature du webhook invalide.',
      );
    }
    final Map<String, Object?> json;
    try {
      json = (jsonDecode(utf8.decode(body)) as Map).cast<String, Object?>();
    } on Object {
      throw const ApiException.badRequest('Corps JSON invalide.');
    }
    final event = '${json['event_name']}';
    final request = switch (json['data']) {
      {'signature_request': final Map<Object?, Object?> r} => r,
      _ => null,
    };
    final providerId = request?['id'];
    if (!event.startsWith('signature_request.') || providerId == null) return;
    final row = await _db.run(
      (s) => s.queryOne(
        'SELECT * FROM signature_requests WHERE provider_id = @p',
        {'p': '$providerId'},
      ),
    );
    if (row == null || row['status'] != 'ongoing') return;
    final status = switch (event) {
      'signature_request.done' => 'done',
      'signature_request.declined' => 'declined',
      'signature_request.expired' => 'expired',
      'signature_request.canceled' => 'canceled',
      _ => null,
    };
    if (status != null) await _apply(row, status);
  }

  /// Signature attendue `sha256=<hex>` ; Yousign envoie `sha256=<hex>`.
  static String? _normalize(String? header) => header == null
      ? null
      : header.startsWith('sha256=')
      ? header
      : 'sha256=$header';

  /// Enregistre le nouvel état ; si signé : PDF signé joint, devis accepté.
  Future<Map<String, dynamic>> _apply(
    Map<String, dynamic> row,
    String status,
  ) async {
    if (status == row['status'] || status == 'ongoing') return row;
    String? fileId;
    String? error;
    if (status == 'done') {
      try {
        final bytes = await _yousign.downloadSigned(
          row['provider_id'] as String,
        );
        fileId = await _files.storeBytes(bytes, mimeType: 'application/pdf');
        final doc = await _db.run(
          (s) => s.queryOne(
            'SELECT number, status, organisation_id FROM invoices WHERE id = @id',
            {'id': row['invoice_id']},
          ),
        );
        await _sync.writeSystem(SyncEntities.attachments, {
          'file_id': fileId,
          'file_name': '${doc?['number'] ?? 'devis'}-signé.pdf',
          'size': bytes.length,
          'mime_type': 'application/pdf',
          'organisation_id': doc?['organisation_id'],
          'contact_id': row['contact_id'],
        });
        if (doc?['status'] == DocumentStatus.sent.key) {
          await _sync.writeSystem(SyncEntities.invoices, {
            'status': DocumentStatus.accepted.key,
          }, id: row['invoice_id'] as String);
        }
      } on Object catch (e) {
        _log.warning('Finalisation de la signature', e);
        error = 'Signé, mais le document signé n’a pas pu être récupéré.';
      }
    }
    final updated = await _db.run(
      (s) => s.queryOne(
        'UPDATE signature_requests SET status = @s, signed_file_id = @f, '
        'error = @e, updated_at = now() WHERE id = @id RETURNING *',
        {'id': row['id'], 's': status, 'f': fileId, 'e': error},
      ),
    );
    return updated!;
  }
}
