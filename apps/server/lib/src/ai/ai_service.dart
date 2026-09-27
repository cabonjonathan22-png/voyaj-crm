import 'dart:convert';

import 'package:voyaj_shared/voyaj_shared.dart';

import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import 'claude_client.dart';

/// Assistant IA : synthèse d'une organisation (historique, affaires,
/// prochaines étapes) et brouillon d'email pour un contact. Désactivé sans
/// clé d'API ; seules les données de la fiche concernée sont transmises.
final class AiService {
  AiService({required this._db, required this._client});

  final Database _db;
  final ClaudeClient? _client;

  bool get enabled => _client != null;

  ClaudeClient _require(AuthContext ctx) {
    ctx.require(Permission.aiUse);
    return _client ??
        (throw const ApiException.badRequest(
          'Assistant IA non configuré (clé ANTHROPIC_API_KEY absente).',
        ));
  }

  static const _system =
      'Tu es l’assistant commercial de Voyaj, un transporteur de voyageurs '
      'qui travaille avec les collectivités françaises (communes, EPCI, '
      'départements, régions), les festivals et les acteurs du tourisme. '
      'Tu réponds en français, de façon concise et factuelle, sans inventer '
      'd’information absente des données fournies.';

  static String _clip(Object? text, int max) {
    final value = '${text ?? ''}'.trim();
    return value.length <= max ? value : '${value.substring(0, max)}…';
  }

  static Object? _plain(Object? value) =>
      value is DateTime ? value.toUtc().toIso8601String() : value;

  static List<Map<String, Object?>> _rows(List<Map<String, dynamic>> rows) => [
    for (final r in rows)
      {
        for (final MapEntry(:key, :value) in r.entries)
          if (value != null) key: _plain(value),
      },
  ];

  /// Synthèse de l'organisation [id] : situation, historique, affaires,
  /// facturation et prochaines actions conseillées.
  Future<AiText> summarizeOrganisation(AuthContext ctx, String id) async {
    final client = _require(ctx);
    ctx.require(Permission.organisationRead);
    final data = await _db.run((s) async {
      final org = isValidId(id)
          ? await s.queryOne(
              'SELECT name, kind, status, city, departement_code, population, '
              'description FROM organisations WHERE id = @id AND '
              'deleted_at IS NULL',
              {'id': id},
            )
          : null;
      if (org == null) {
        throw const ApiException.notFound('Organisation introuvable.');
      }
      Future<List<Map<String, Object?>>> all(String sql) async =>
          _rows(await s.queryAll(sql, {'id': id}));
      return {
        'organisation': _rows([org]).single,
        'contacts': ctx.can(Permission.contactRead)
            ? await all(
                "SELECT concat_ws(' ', first_name, last_name) AS nom, "
                'job_title AS fonction, do_not_contact FROM contacts '
                'WHERE organisation_id = @id AND deleted_at IS NULL LIMIT 30',
              )
            : const <Map<String, Object?>>[],
        'affaires': ctx.can(Permission.dealRead)
            ? await all(
                'SELECT d.title AS titre, d.status AS statut, '
                'st.name AS etape, d.amount_cents / 100 AS montant_euros, '
                'd.expected_close_date AS cloture_prevue FROM deals d '
                'LEFT JOIN pipeline_stages st ON st.id = d.stage_id '
                'WHERE d.organisation_id = @id AND d.deleted_at IS NULL',
              )
            : const <Map<String, Object?>>[],
        'activites': ctx.can(Permission.activityRead)
            ? [
                for (final a in await all(
                  'SELECT kind AS type, COALESCE(starts_at, due_at, '
                  'created_at) AS date, subject AS objet, body AS contenu, '
                  'done_at IS NOT NULL AS faite FROM activities '
                  'WHERE organisation_id = @id AND deleted_at IS NULL '
                  'ORDER BY COALESCE(starts_at, due_at, created_at) DESC '
                  'LIMIT 40',
                ))
                  {...a, 'contenu': _clip(a['contenu'], 600)},
              ]
            : const <Map<String, Object?>>[],
        'factures': ctx.can(Permission.invoiceRead)
            ? await all(
                'SELECT kind AS type, number AS numero, status AS etat, '
                'issue_date AS date, total_ttc_cents / 100 AS ttc_euros '
                'FROM invoices WHERE organisation_id = @id AND '
                'number IS NOT NULL AND deleted_at IS NULL '
                'ORDER BY issue_date DESC LIMIT 20',
              )
            : const <Map<String, Object?>>[],
      };
    });
    final text = await _call(
      () => client.complete(
        system: _system,
        prompt:
            'Voici la fiche CRM d’un client ou prospect (JSON) :\n\n'
            '${jsonEncode(data)}\n\n'
            'Rédige une synthèse pour un commercial qui reprend le dossier : '
            'situation actuelle (3 à 5 phrases), points clés de l’historique, '
            'affaires et facturation en cours, puis 2 ou 3 prochaines actions '
            'concrètes. Format : paragraphes courts et listes à puces, sans '
            'titre de niveau 1.',
      ),
    );
    return AiText(text: text);
  }

  /// Brouillon d'email pour le contact [DraftEmailRequest.contactId].
  Future<EmailDraft> draftEmail(
    AuthContext ctx,
    DraftEmailRequest request,
  ) async {
    final client = _require(ctx);
    ctx.require(Permission.contactRead);
    final instructions = request.instructions.trim();
    if (instructions.isEmpty || instructions.length > 2000) {
      throw const ApiException.badRequest('Décrivez l’email souhaité.');
    }
    final data = await _db.run((s) async {
      final contact = isValidId(request.contactId)
          ? await s.queryOne(
              'SELECT c.civility AS civilite, c.first_name AS prenom, '
              'c.last_name AS nom, c.job_title AS fonction, '
              'o.name AS organisation, o.kind AS type_organisation '
              'FROM contacts c LEFT JOIN organisations o '
              'ON o.id = c.organisation_id WHERE c.id = @id AND '
              'c.deleted_at IS NULL',
              {'id': request.contactId},
            )
          : null;
      if (contact == null) {
        throw const ApiException.notFound('Contact introuvable.');
      }
      final activities = ctx.can(Permission.activityRead)
          ? await s.queryAll(
              'SELECT kind AS type, COALESCE(starts_at, created_at) AS date, '
              'subject AS objet, body AS contenu FROM activities '
              'WHERE contact_id = @id AND deleted_at IS NULL '
              'ORDER BY COALESCE(starts_at, created_at) DESC LIMIT 10',
              {'id': request.contactId},
            )
          : const <Map<String, dynamic>>[];
      return {
        'contact': _rows([contact]).single,
        'derniers_echanges': [
          for (final a in _rows(activities))
            {...a, 'contenu': _clip(a['contenu'], 400)},
        ],
      };
    });
    final json = await _call(
      () => client.complete(
        system: _system,
        prompt:
            'Destinataire et derniers échanges (JSON) :\n\n'
            '${jsonEncode(data)}\n\n'
            'Rédige un email professionnel en français, au vouvoiement, '
            'signé « ${ctx.displayName} ». Objectif : $instructions\n'
            'Corps en texte brut (pas de Markdown), 150 mots au plus.',
        schema: {
          'type': 'object',
          'properties': {
            'subject': {'type': 'string'},
            'body': {'type': 'string'},
          },
          'required': ['subject', 'body'],
          'additionalProperties': false,
        },
      ),
    );
    try {
      return EmailDraft.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } on Object {
      throw const ApiException(
        502,
        ApiErrorCodes.badRequest,
        'Réponse inattendue de l’assistant.',
      );
    }
  }

  Future<String> _call(Future<String> Function() call) async {
    try {
      return await call();
    } on AiException catch (e) {
      throw ApiException(502, ApiErrorCodes.badRequest, e.message);
    }
  }
}
