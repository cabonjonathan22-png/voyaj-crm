import 'dart:io';

import 'package:invoicing/invoicing.dart';
import 'package:invoicing/invoicing_pdf.dart';
import 'package:postgres/postgres.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import '../files/file_store.dart';
import '../security/secret_cipher.dart';
import '../sync/sync_service.dart';
import 'chorus_pro.dart';

/// Facturation : paramètres, émission des documents (numérotation
/// continue, instantanés vendeur / acheteur, PDF Factur-X), exports
/// comptables (FEC, TVA) et dépôt sur Chorus Pro.
final class BillingService {
  BillingService({
    required this._db,
    required this._sync,
    required this._files,
    required this._cipher,
    required this._chorus,
  });

  final Database _db;
  final SyncService _sync;
  final FileStore _files;
  final SecretCipher _cipher;
  final ChorusProClient _chorus;

  /// Sérialise les émissions (numérotation sans trou).
  static const _issueLockKey = 7428120005;

  // ── Paramètres ────────────────────────────────────────────────────────

  Future<BillingSettings> _loadSettings(Session s) async {
    final row = await s.queryOne('SELECT * FROM billing_settings WHERE id = 1');
    if (row == null) return const BillingSettings();
    final settings = BillingSettings.fromJson(
      (row['settings'] as Map).cast<String, dynamic>(),
    );
    return settings.copyWith(
      chorusConfigured:
          settings.chorusLogin != null &&
          settings.pisteClientId != null &&
          row['chorus_password_enc'] != null &&
          row['piste_client_secret_enc'] != null,
    );
  }

  /// Paramètres (secrets exclus).
  Future<BillingSettings> settings(AuthContext ctx) {
    ctx.require(Permission.invoiceRead);
    return _db.run(_loadSettings);
  }

  Future<BillingSettings> updateSettings(
    AuthContext ctx,
    BillingSettings input,
  ) async {
    ctx.require(Permission.billingSettings);
    final issues = collectIssues([
      if (input.siren != null && !RegExp(r'^\d{9}$').hasMatch(input.siren!))
        const ValidationIssue(
          field: 'siren',
          code: ValidationCodes.invalidFormat,
          message: 'SIREN invalide.',
        ),
      if (input.paymentDays < 0 || input.paymentDays > 60)
        const ValidationIssue(
          field: 'paymentDays',
          code: ValidationCodes.invalidFormat,
          message: 'Le délai de paiement est de 0 à 60 jours.',
        ),
      if (input.quoteValidityDays < 1 || input.quoteValidityDays > 365)
        const ValidationIssue(
          field: 'quoteValidityDays',
          code: ValidationCodes.invalidFormat,
          message: 'La validité d’un devis est de 1 à 365 jours.',
        ),
    ]);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    final stored = input
        .copyWith(
          chorusPassword: null,
          pisteClientSecret: null,
          chorusConfigured: false,
        )
        .toJson();
    final password = _blankToNull(input.chorusPassword);
    final secret = _blankToNull(input.pisteClientSecret);
    await _db.tx((tx) async {
      await tx.query(
        'INSERT INTO billing_settings (id, settings, chorus_password_enc, '
        'piste_client_secret_enc, updated_at, updated_by) VALUES (1, '
        '@s:jsonb, @p, @c, now(), @u) ON CONFLICT (id) DO UPDATE SET '
        'settings = EXCLUDED.settings, '
        'chorus_password_enc = COALESCE(EXCLUDED.chorus_password_enc, '
        'billing_settings.chorus_password_enc), '
        'piste_client_secret_enc = COALESCE(EXCLUDED.piste_client_secret_enc, '
        'billing_settings.piste_client_secret_enc), '
        'updated_at = now(), updated_by = EXCLUDED.updated_by',
        {
          's': stored,
          'p': password == null ? null : await _cipher.encrypt(password),
          'c': secret == null ? null : await _cipher.encrypt(secret),
          'u': ctx.userId,
        },
      );
      await AuditLog.append(
        tx,
        _event(
          ctx,
          AuditActions.billingSettingsUpdated,
          payload: {
            'chorus_password_changed': password != null,
            'piste_secret_changed': secret != null,
          },
        ),
      );
    });
    return _db.run(_loadSettings);
  }

  // ── Émission ──────────────────────────────────────────────────────────

  /// Émet le brouillon [id] : numéro définitif, dates, totaux, instantanés
  /// vendeur / acheteur et PDF Factur-X, en une transaction. Retourne le
  /// numéro attribué.
  Future<String> issue(AuthContext ctx, String id) async {
    ctx.require(Permission.invoiceIssue);
    final (number, seq) = await _db.tx((tx) async {
      await tx.query('SELECT pg_advisory_xact_lock(@k)', {'k': _issueLockKey});
      await _sync.lockWrites(tx);
      final doc = await _document(tx, id, forUpdate: true);
      final kind = _kindOf(doc);
      if (doc['number'] != null) {
        throw const ApiException.conflict('Ce document est déjà émis.');
      }
      final lines = linesFromJson(doc['lines']);
      final settings = await _loadSettings(tx);
      final orgId = doc['organisation_id'] as String?;
      final problems = [
        if (lines.isEmpty) _problem('lines', 'Ajoutez au moins une ligne.'),
        if (orgId == null) _problem('organisation_id', 'Choisissez le client.'),
        if (settings.legalName.trim().isEmpty || settings.siren == null)
          _problem(
            'seller',
            'Renseignez la raison sociale et le SIREN dans les paramètres '
                'de facturation.',
          ),
      ];
      if (problems.isNotEmpty) throw ApiException.validation(problems);

      String? originalNumber;
      if (kind == DocumentKind.creditNote) {
        final originalId = doc['original_invoice_id'] as String?;
        final original = originalId == null
            ? null
            : await tx.queryOne(
                'SELECT kind, number FROM invoices WHERE id = @id '
                'AND deleted_at IS NULL',
                {'id': originalId},
              );
        if (original == null ||
            original['kind'] != DocumentKind.invoice.key ||
            original['number'] == null) {
          throw ApiException.validation([
            _problem(
              'original_invoice_id',
              'Un avoir se rapporte à une facture émise.',
            ),
          ]);
        }
        originalNumber = original['number'] as String;
      }

      final org = await tx.queryOne(
        'SELECT * FROM organisations WHERE id = @id AND deleted_at IS NULL',
        {'id': orgId},
      );
      if (org == null) {
        throw ApiException.validation([
          _problem('organisation_id', 'Client introuvable.'),
        ]);
      }
      final buyer = Party(
        name: org['name'] as String,
        address: org['address'] as String?,
        postalCode: org['postal_code'] as String?,
        city: org['city'] as String?,
        siren: org['siren'] as String?,
        siret: org['siret'] as String?,
        email: org['email'] as String?,
        phone: org['phone'] as String?,
      );
      final seller = Party(
        name: settings.legalName.trim(),
        address: settings.address,
        postalCode: settings.postalCode,
        city: settings.city,
        siren: settings.siren,
        siret: settings.siret,
        vatNumber: settings.vatNumber,
        email: settings.email,
        phone: settings.phone,
        legalForm: settings.legalForm,
        capital: settings.capital,
        rcs: settings.rcs,
      );

      final now = DateTime.now();
      final issueDate = DateTime.utc(now.year, now.month, now.day);
      final counter = await tx.queryOne(
        'INSERT INTO document_counters (kind, year, last) '
        'VALUES (@k, @y, 1) ON CONFLICT (kind, year) '
        'DO UPDATE SET last = document_counters.last + 1 RETURNING last',
        {'k': kind.key, 'y': issueDate.year},
      );
      final number = formatDocumentNumber(
        kind.prefix,
        issueDate.year,
        counter!['last'] as int,
      );

      final existingDue = _date(doc['due_date']);
      final dueDate = switch (kind) {
        DocumentKind.invoice =>
          existingDue != null && !existingDue.isBefore(issueDate)
              ? existingDue
              : issueDate.add(Duration(days: settings.paymentDays)),
        _ => null,
      };
      final existingValidity = _date(doc['valid_until']);
      final validUntil = kind == DocumentKind.quote
          ? (existingValidity != null && !existingValidity.isBefore(issueDate)
                ? existingValidity
                : issueDate.add(Duration(days: settings.quoteValidityDays)))
          : null;
      final paymentTerms = kind == DocumentKind.invoice
          ? (doc['payment_terms'] as String? ?? settings.paymentTerms)
          : doc['payment_terms'] as String?;

      final issued = IssuedDocument(
        kind: kind,
        number: number,
        issueDate: issueDate,
        serviceDate: _date(doc['service_date']),
        dueDate: dueDate,
        validUntil: validUntil,
        seller: seller,
        buyer: buyer,
        lines: lines,
        subject: doc['subject'] as String?,
        notes: doc['notes'] as String?,
        paymentTerms: paymentTerms,
        latePenalties: kind == DocumentKind.quote
            ? null
            : settings.latePenalties,
        buyerReference: doc['buyer_reference'] as String?,
        serviceCode: doc['service_code'] as String?,
        originalNumber: originalNumber,
        iban: kind == DocumentKind.creditNote ? null : settings.iban,
        bic: kind == DocumentKind.creditNote ? null : settings.bic,
        vatExemptionReason: lines.any((l) => l.vatRate == 0)
            ? settings.vatExemptionReason
            : null,
        footer: settings.footer,
      );
      final totals = issued.totals;
      final pdf = await renderDocumentPdf(issued);
      final pdfId = await _files.storeBytes(
        pdf,
        mimeType: 'application/pdf',
        userId: ctx.userId,
      );

      final (_, seq) = await _writeSystem(tx, ctx, id, {
        'number': number,
        'status': kind == DocumentKind.quote
            ? DocumentStatus.sent.key
            : DocumentStatus.issued.key,
        'issue_date': _wireDate(issueDate),
        'due_date': dueDate == null ? null : _wireDate(dueDate),
        'valid_until': validUntil == null ? null : _wireDate(validUntil),
        'payment_terms': paymentTerms,
        'total_ht_cents': totals.htCents,
        'total_vat_cents': totals.vatCents,
        'total_ttc_cents': totals.ttcCents,
        'vat_breakdown': [
          for (final MapEntry(key: rate, value: line)
              in totals.breakdown.entries)
            {
              'rate': rate,
              'base_cents': line.baseCents,
              'vat_cents': line.vatCents,
            },
        ],
        'buyer': buyer.toJson(),
        'seller': seller.toJson(),
        'pdf_file_id': pdfId,
      });
      await AuditLog.append(
        tx,
        _event(
          ctx,
          AuditActions.documentIssued,
          entityId: id,
          payload: {
            'kind': kind.key,
            'number': number,
            'total_ttc_cents': totals.ttcCents,
          },
        ),
      );
      return (number, seq);
    });
    _sync.notifyChange(seq);
    return number;
  }

  /// PDF d'un document émis.
  Future<({File file, String fileName})> pdf(AuthContext ctx, String id) async {
    ctx.require(Permission.invoiceRead);
    final doc = await _db.run((s) => _document(s, id));
    final fileId = doc['pdf_file_id'] as String?;
    if (fileId == null) {
      throw const ApiException.notFound('Ce document n’est pas encore émis.');
    }
    final found = await _files.open(
      ctx,
      fileId,
      permission: Permission.invoiceRead,
    );
    return (file: found.file, fileName: '${doc['number']}.pdf');
  }

  // ── Comptabilité ──────────────────────────────────────────────────────

  Future<List<LedgerDocument>> _ledgerDocuments(
    Session s,
    DateTime from,
    DateTime to,
  ) async {
    final rows = await s.queryAll(
      'SELECT id, kind, number, issue_date, organisation_id, buyer, lines '
      'FROM invoices WHERE number IS NOT NULL AND deleted_at IS NULL '
      'AND kind IN (@invoice, @credit) AND issue_date BETWEEN @from AND @to '
      'ORDER BY issue_date, number',
      {
        'invoice': DocumentKind.invoice.key,
        'credit': DocumentKind.creditNote.key,
        'from': from,
        'to': to,
      },
    );
    return [for (final row in rows) _ledgerDocument(row)];
  }

  LedgerDocument _ledgerDocument(Map<String, dynamic> row) => LedgerDocument(
    kind: _kindOf(row),
    number: row['number'] as String,
    date: _date(row['issue_date'])!,
    customerCode: _customerCode(row['organisation_id'] as String?),
    customerName: _buyerName(row),
    lines: linesFromJson(row['lines']),
  );

  static String _customerCode(String? organisationId) =>
      'C${(organisationId ?? '00000000').substring(0, 8).toUpperCase()}';

  static String _buyerName(Map<String, dynamic> row) =>
      ((row['buyer'] as Map?)?['name'] as String?) ?? '';

  Future<List<Map<String, dynamic>>> _receipts(
    Session s,
    DateTime from,
    DateTime to,
  ) => s.queryAll(
    'SELECT p.amount_cents, p.paid_on, p.reference, i.id, i.kind, i.number, '
    'i.issue_date, i.organisation_id, i.buyer, i.lines FROM payments p '
    'JOIN invoices i ON i.id = p.invoice_id WHERE p.deleted_at IS NULL '
    'AND i.deleted_at IS NULL AND i.number IS NOT NULL '
    'AND i.kind IN (@invoice, @credit) AND p.paid_on BETWEEN @from AND @to '
    'ORDER BY p.paid_on',
    {
      'invoice': DocumentKind.invoice.key,
      'credit': DocumentKind.creditNote.key,
      'from': from,
      'to': to,
    },
  );

  /// Fichier des écritures comptables de l'exercice civil [year].
  Future<({String fileName, String content})> fec(
    AuthContext ctx,
    int year,
  ) async {
    ctx.require(Permission.billingSettings);
    final from = DateTime.utc(year);
    final to = DateTime.utc(year, 12, 31);
    final (settings, documents, receipts) = await _db.run(
      (s) async => (
        await _loadSettings(s),
        await _ledgerDocuments(s, from, to),
        await _receipts(s, from, to),
      ),
    );
    final siren = settings.siren;
    if (siren == null) {
      throw ApiException.validation([
        _problem('siren', 'Renseignez le SIREN dans les paramètres.'),
      ]);
    }
    final content = buildFec(
      documents: documents,
      payments: [
        for (final row in receipts)
          LedgerPayment(
            date: _date(row['paid_on'])!,
            amountCents: row['amount_cents'] as int,
            documentNumber: row['number'] as String,
            customerCode: _customerCode(row['organisation_id'] as String?),
            customerName: _buyerName(row),
            refund: row['kind'] == DocumentKind.creditNote.key,
            reference: row['reference'] as String?,
          ),
      ],
      accounts: AccountingAccounts.fromJson(settings.accounts),
    );
    await _db.tx(
      (tx) => AuditLog.append(
        tx,
        _event(ctx, AuditActions.fecExported, payload: {'year': year}),
      ),
    );
    return (fileName: fecFileName(siren, to), content: content);
  }

  /// TVA collectée entre [from] et [to] (inclus).
  Future<VatReport> vatReport(
    AuthContext ctx,
    DateTime from,
    DateTime to,
  ) async {
    ctx.require(Permission.invoiceRead);
    if (to.isBefore(from)) {
      throw const ApiException.badRequest('Période invalide.');
    }
    final (documents, receipts) = await _db.run(
      (s) async =>
          (await _ledgerDocuments(s, from, to), await _receipts(s, from, to)),
    );
    List<VatReportRow> rows(List<VatReportLine> lines) => [
      for (final l in lines)
        VatReportRow(
          rate: l.rate,
          baseCents: l.baseCents,
          vatCents: l.vatCents,
        ),
    ];
    return VatReport(
      from: from,
      to: to,
      debits: rows(vatOnDebits(documents)),
      receipts: rows(
        vatOnReceipts([
          for (final row in receipts)
            (
              document: _ledgerDocument(row),
              amountCents: row['amount_cents'] as int,
            ),
        ]),
      ),
    );
  }

  // ── Chorus Pro ────────────────────────────────────────────────────────

  /// Dépose la facture ou l'avoir émis [id] sur Chorus Pro ; retourne le
  /// numéro de flux.
  Future<String> depositToChorus(AuthContext ctx, String id) async {
    ctx.require(Permission.invoiceIssue);
    final (doc, settings, row) = await _db.run(
      (s) async => (
        await _document(s, id),
        await _loadSettings(s),
        await s.queryOne('SELECT * FROM billing_settings WHERE id = 1'),
      ),
    );
    if (!settings.chorusEnabled || !settings.chorusConfigured) {
      throw const ApiException.badRequest(
        'Chorus Pro n’est pas configuré (paramètres de facturation).',
      );
    }
    if (doc['number'] == null || _kindOf(doc) == DocumentKind.quote) {
      throw const ApiException.badRequest(
        'Seules les factures et avoirs émis sont déposés sur Chorus Pro.',
      );
    }
    if (doc['chorus_flux'] != null) {
      throw const ApiException.conflict('Document déjà déposé.');
    }
    final buyer = (doc['buyer'] as Map?)?.cast<String, Object?>() ?? {};
    if (buyer['siret'] == null) {
      throw ApiException.validation([
        _problem(
          'organisation_id',
          'Le SIRET du client est requis par Chorus Pro (réémettre après '
              'correction : faire un avoir puis une nouvelle facture).',
        ),
      ]);
    }
    final found = await _files.open(
      ctx,
      doc['pdf_file_id'] as String,
      permission: Permission.invoiceRead,
    );
    final credentials = ChorusCredentials(
      clientId: settings.pisteClientId!,
      clientSecret: await _cipher.decrypt(
        row!['piste_client_secret_enc'] as String,
      ),
      login: settings.chorusLogin!,
      password: await _cipher.decrypt(row['chorus_password_enc'] as String),
      sandbox: settings.chorusSandbox,
    );
    final String flux;
    try {
      flux = await _chorus.depositFacturx(
        credentials,
        pdf: await found.file.readAsBytes(),
        fileName: '${doc['number']}.pdf',
      );
    } on ChorusException catch (e) {
      throw ApiException(502, ApiErrorCodes.badRequest, e.message);
    }
    final seq = await _db.tx((tx) async {
      await _sync.lockWrites(tx);
      final (_, seq) = await _writeSystem(tx, ctx, id, {
        'chorus_flux': flux,
        'chorus_status': 'deposited',
      });
      await AuditLog.append(
        tx,
        _event(
          ctx,
          AuditActions.chorusDeposited,
          entityId: id,
          payload: {'number': doc['number'], 'flux': flux},
        ),
      );
      return seq;
    });
    _sync.notifyChange(seq);
    return flux;
  }

  // ── Outils ────────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> _document(
    Session s,
    String id, {
    bool forUpdate = false,
  }) async {
    if (!isValidId(id)) {
      throw const ApiException.notFound('Document introuvable.');
    }
    final row = await s.queryOne(
      'SELECT * FROM invoices WHERE id = @id AND deleted_at IS NULL'
      '${forUpdate ? ' FOR UPDATE' : ''}',
      {'id': id},
    );
    if (row == null) throw const ApiException.notFound('Document introuvable.');
    return row;
  }

  Future<(String, int)> _writeSystem(
    TxSession tx,
    AuthContext ctx,
    String id,
    Map<String, Object?> fields,
  ) async {
    try {
      return await _sync.writeSystemInTx(
        tx,
        SyncEntities.invoices,
        fields,
        id: id,
        userId: ctx.userId,
      );
    } on SystemWriteException catch (e) {
      throw ApiException.validation(e.issues);
    }
  }

  static DocumentKind _kindOf(Map<String, dynamic> row) =>
      DocumentKind.values.firstWhere((k) => k.key == row['kind']);

  static DateTime? _date(Object? value) => switch (value) {
    final DateTime d => DateTime.utc(d.year, d.month, d.day),
    final String s => DateTime.parse(s),
    _ => null,
  };

  static String _wireDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  static String? _blankToNull(String? value) =>
      value == null || value.trim().isEmpty ? null : value;

  static ValidationIssue _problem(String field, String message) =>
      ValidationIssue(
        field: field,
        code: ValidationCodes.invalidFormat,
        message: message,
      );

  static AuditEvent _event(
    AuthContext ctx,
    String action, {
    String? entityId,
    Map<String, Object?> payload = const {},
  }) => AuditEvent(
    action: action,
    actorUserId: ctx.userId,
    sessionId: ctx.sessionId,
    entity: entityId == null ? 'billing_settings' : 'invoices',
    entityId: entityId,
    payload: payload,
    ip: ctx.meta.ip,
  );
}
