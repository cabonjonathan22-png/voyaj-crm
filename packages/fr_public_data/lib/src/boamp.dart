import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'client.dart';
import 'public_record.dart';

/// Avis de marché public publié au BOAMP.
@immutable
final class BoampNotice {
  const BoampNotice({
    required this.ref,
    required this.title,
    required this.publishedOn,
    this.buyer,
    this.deadline,
    this.departements = const [],
    this.nature,
    this.procedure,
    this.url,
    this.descriptors = const [],
  });

  /// Identifiant BOAMP (`idweb`).
  final String ref;
  final String title;

  /// Date de parution (`AAAA-MM-JJ`).
  final String publishedOn;
  final String? buyer;

  /// Date limite de réponse.
  final DateTime? deadline;
  final List<String> departements;

  /// Type de marché (travaux, services, fournitures) ou nature de l'avis.
  final String? nature;
  final String? procedure;
  final String? url;

  /// Descripteurs (mots-clés) de l'avis.
  final List<String> descriptors;
}

String? _text(Map<Object?, Object?> r, List<String> keys) {
  for (final key in keys) {
    final value = r[key];
    if (value is String && value.trim().isNotEmpty) return value.trim();
    if (value is List && value.isNotEmpty && value.first is String) {
      return (value.first as String).trim();
    }
  }
  return null;
}

List<String> _list(Map<Object?, Object?> r, List<String> keys) {
  for (final key in keys) {
    final value = r[key];
    if (value is List) {
      return [
        for (final v in value)
          if (v != null && '$v'.trim().isNotEmpty) '$v'.trim(),
      ];
    }
    if (value is String && value.trim().isNotEmpty) {
      return value.split(RegExp(r'[,;|]')).map((v) => v.trim()).toList();
    }
  }
  return const [];
}

/// Avis de la réponse de l'API Opendatasoft du BOAMP (`results`), tolérant
/// aux variantes de noms de champs.
List<BoampNotice> parseBoamp(Object? json) {
  final results = switch (json) {
    {'results': final List<Object?> list} => list,
    final List<Object?> list => list,
    _ => throw const PublicDataException('Réponse BOAMP inattendue.'),
  };
  final notices = <BoampNotice>[];
  for (final item in results.whereType<Map<Object?, Object?>>()) {
    final ref = _text(item, ['idweb', 'id', 'reference']);
    final title = _text(item, ['objet', 'titre', 'intitule']);
    final published = _text(item, ['dateparution', 'date_parution']);
    if (ref == null || title == null || published == null) continue;
    final deadline = _text(item, [
      'datelimitereponse',
      'date_limite_reponse',
      'datefindiffusion',
    ]);
    final url =
        _text(item, ['url_avis', 'urlgravure', 'url']) ??
        'https://www.boamp.fr/pages/avis/?q=idweb:$ref';
    notices.add(
      BoampNotice(
        ref: ref,
        title: title,
        publishedOn: published.length >= 10
            ? published.substring(0, 10)
            : published,
        buyer: _text(item, ['nomacheteur', 'nom_acheteur', 'acheteur']),
        deadline: deadline == null ? null : DateTime.tryParse(deadline),
        departements: _list(item, [
          'code_departement',
          'code_departement_prestation',
          'departement',
        ]),
        nature: _text(item, ['type_marche', 'nature_libelle', 'nature']),
        procedure: _text(item, ['procedure_libelle', 'procedure']),
        url: url,
        descriptors: _list(item, ['descripteur_libelle', 'descripteurs']),
      ),
    );
  }
  return notices;
}

/// Recherche d'avis au BOAMP (API Opendatasoft de la DILA).
final class BoampClient {
  BoampClient({
    http.Client? httpClient,
    this.endpoint =
        'https://boamp-datadila.opendatasoft.com/api/explore/v2.1/catalog/'
        'datasets/boamp/records',
  }) : _client = PublicDataClient(httpClient: httpClient);

  final PublicDataClient _client;
  final String endpoint;

  /// Condition ODSQL : un des [keywords] dans le texte, un des
  /// [departements], parus depuis [since].
  static String whereClause({
    required List<String> keywords,
    required List<String> departements,
    required DateTime since,
  }) {
    String quote(String v) => '"${v.replaceAll(r'\', '').replaceAll('"', '')}"';
    final day =
        '${since.year.toString().padLeft(4, '0')}-'
        '${since.month.toString().padLeft(2, '0')}-'
        '${since.day.toString().padLeft(2, '0')}';
    return [
      "dateparution >= date'$day'",
      if (keywords.isNotEmpty)
        '(${keywords.map((k) => 'search(${quote(k)})').join(' OR ')})',
      if (departements.isNotEmpty)
        'code_departement IN (${departements.map(quote).join(', ')})',
    ].join(' AND ');
  }

  /// Avis correspondants (au plus [limit], les plus récents d'abord).
  Future<List<BoampNotice>> search({
    required List<String> keywords,
    required List<String> departements,
    required DateTime since,
    int limit = 300,
  }) async {
    final notices = <BoampNotice>[];
    for (var offset = 0; offset < limit; offset += 100) {
      final uri = Uri.parse(endpoint).replace(
        queryParameters: {
          'where': whereClause(
            keywords: keywords,
            departements: departements,
            since: since,
          ),
          'order_by': 'dateparution DESC',
          'limit': '100',
          'offset': '$offset',
        },
      );
      final page = parseBoamp(await _client.getJson(uri.toString()));
      notices.addAll(page);
      if (page.length < 100) break;
    }
    return notices;
  }

  void close() => _client.close();
}
