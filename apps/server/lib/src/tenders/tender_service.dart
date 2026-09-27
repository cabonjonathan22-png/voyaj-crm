import 'package:fr_public_data/fr_public_data.dart';
import 'package:logging/logging.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';

final _log = Logger('tenders');

/// Veille des appels d'offres : recherche quotidienne au BOAMP selon les
/// mots-clés et départements configurés ; les avis repérés sont suivis
/// (affaire créée) ou ignorés par l'équipe.
final class TenderService {
  TenderService({
    required this._db,
    required this._boamp,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Database _db;
  final BoampClient _boamp;
  final DateTime Function() _clock;
  bool _running = false;

  Future<TenderWatch> watch(AuthContext ctx) async {
    ctx.require(Permission.dealRead);
    return _loadWatch();
  }

  Future<TenderWatch> _loadWatch() async {
    final row = await _db.run(
      (s) => s.queryOne('SELECT * FROM tender_watch WHERE id = 1'),
    );
    if (row == null) return const TenderWatch();
    return TenderWatch(
      enabled: row['enabled'] as bool,
      keywords: [for (final k in row['keywords'] as List) '$k'],
      departements: [for (final d in row['departements'] as List) '$d'],
      lastRunAt: row['last_run_at'] as DateTime?,
      lastError: row['last_error'] as String?,
    );
  }

  Future<TenderWatch> configure(AuthContext ctx, TenderWatch input) async {
    ctx.require(Permission.publicDataManage);
    final keywords = {
      for (final k in input.keywords)
        if (k.trim().isNotEmpty) k.trim(),
    }.toList();
    final departements = {
      for (final d in input.departements)
        if (RegExp(r'^(\d{2,3}|2[AB])$').hasMatch(d.trim())) d.trim(),
    }.toList();
    if (input.enabled && keywords.isEmpty) {
      throw const ApiException.validation([
        ValidationIssue(
          field: 'keywords',
          code: ValidationCodes.required,
          message: 'Indiquez au moins un mot-clé.',
        ),
      ]);
    }
    await _db.query(
      'INSERT INTO tender_watch (id, enabled, keywords, departements) '
      'VALUES (1, @e, @k:_text, @d:_text) ON CONFLICT (id) DO UPDATE SET '
      'enabled = EXCLUDED.enabled, keywords = EXCLUDED.keywords, '
      'departements = EXCLUDED.departements',
      {'e': input.enabled, 'k': keywords, 'd': departements},
    );
    return _loadWatch();
  }

  static TenderInfo _info(Map<String, dynamic> r) => TenderInfo(
    id: r['id'] as String,
    ref: r['ref'] as String,
    title: r['title'] as String,
    buyer: r['buyer'] as String?,
    publishedOn: formatDateOnly(r['published_on'] as DateTime),
    deadline: r['deadline'] as DateTime?,
    departements: [for (final d in r['departements'] as List) '$d'],
    nature: r['nature'] as String?,
    procedure: r['procedure'] as String?,
    url: r['url'] as String?,
    descriptors: [for (final d in r['descriptors'] as List) '$d'],
    status: r['status'] as String,
    dealId: r['deal_id'] as String?,
  );

  /// Avis repérés (plus récents d'abord), filtrés par état.
  Future<List<TenderInfo>> list(AuthContext ctx, {String? status}) async {
    ctx.require(Permission.dealRead);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT * FROM tenders ${status == null ? '' : 'WHERE status = @s '}'
        'ORDER BY published_on DESC, created_at DESC LIMIT 500',
        {'s': ?status},
      ),
    );
    return [for (final r in rows) _info(r)];
  }

  Future<TenderInfo> update(
    AuthContext ctx,
    String id,
    UpdateTenderRequest request,
  ) async {
    ctx.require(Permission.dealWrite);
    if (enumByKey(TenderStatus.values, request.status) == null ||
        (request.dealId != null && !isValidId(request.dealId!))) {
      throw const ApiException.badRequest('État invalide.');
    }
    final row = isValidId(id)
        ? await _db.run(
            (s) => s.queryOne(
              'UPDATE tenders SET status = @s, deal_id = COALESCE(@d, deal_id), '
              'status_by = @u WHERE id = @id RETURNING *',
              {
                'id': id,
                's': request.status,
                'd': request.dealId,
                'u': ctx.userId,
              },
            ),
          )
        : null;
    if (row == null) throw const ApiException.notFound('Avis introuvable.');
    return _info(row);
  }

  /// Recherche immédiate ; retourne le nombre de nouveaux avis.
  Future<int> run(AuthContext ctx) {
    ctx.require(Permission.dealWrite);
    return _search(force: true);
  }

  /// Recherche quotidienne (si activée et pas encore faite aujourd'hui).
  Future<void> runScheduledIfDue() async {
    final watch = await _loadWatch();
    final last = watch.lastRunAt?.toLocal();
    final now = _clock();
    if (!watch.enabled ||
        (last != null &&
            last.year == now.year &&
            last.month == now.month &&
            last.day == now.day)) {
      return;
    }
    await _search(force: false);
  }

  Future<int> _search({required bool force}) async {
    if (_running) {
      throw const ApiException.conflict('Une recherche est déjà en cours.');
    }
    _running = true;
    try {
      final watch = await _loadWatch();
      if (watch.keywords.isEmpty) {
        throw const ApiException.badRequest(
          'Configurez d’abord les mots-clés de la veille.',
        );
      }
      final since = watch.lastRunAt == null || force
          ? _clock().subtract(const Duration(days: 30))
          : watch.lastRunAt!.subtract(const Duration(days: 2));
      final List<BoampNotice> notices;
      try {
        notices = await _boamp.search(
          keywords: watch.keywords,
          departements: watch.departements,
          since: since,
        );
      } on PublicDataException catch (e) {
        await _db.query(
          'UPDATE tender_watch SET last_run_at = now(), last_error = @e '
          'WHERE id = 1',
          {'e': e.message},
        );
        throw ApiException(502, ApiErrorCodes.badRequest, e.message);
      }
      var added = 0;
      for (final n in notices) {
        final inserted = await _db.run(
          (s) => s.queryOne(
            'INSERT INTO tenders (id, ref, title, buyer, published_on, '
            'deadline, departements, nature, procedure, url, descriptors) '
            'VALUES (@id, @ref, @t, @b, @p, @dl, @dep:_text, @n, @pr, @url, '
            '@desc:_text) ON CONFLICT (ref) DO NOTHING RETURNING id',
            {
              'id': newId(),
              'ref': n.ref,
              't': n.title,
              'b': n.buyer,
              'p': DateTime.parse(n.publishedOn),
              'dl': n.deadline,
              'dep': n.departements,
              'n': n.nature,
              'pr': n.procedure,
              'url': n.url,
              'desc': n.descriptors,
            },
          ),
        );
        if (inserted != null) added++;
      }
      await _db.query(
        'UPDATE tender_watch SET last_run_at = now(), last_error = NULL '
        'WHERE id = 1',
      );
      _log.info('BOAMP : ${notices.length} avis, $added nouveaux.');
      return added;
    } finally {
      _running = false;
    }
  }
}
