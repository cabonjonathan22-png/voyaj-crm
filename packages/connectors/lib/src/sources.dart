import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:mysql_client_plus/mysql_client_plus.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'mapping.dart';
import 'source.dart';

const _timeout = Duration(seconds: 60);

/// Ouvre la source d'un connecteur ([secret] : clé d'API, mot de passe ou
/// chaîne de connexion, selon le type).
RecordSource openSource(
  ConnectorKind kind,
  Map<String, Object?> config, {
  String? secret,
  http.Client? httpClient,
}) => switch (kind) {
  ConnectorKind.rest => RestSource(config, secret: secret, client: httpClient),
  ConnectorKind.supabase => SupabaseSource(
    config,
    secret: secret,
    client: httpClient,
  ),
  ConnectorKind.firebase => FirestoreSource(
    config,
    secret: secret,
    client: httpClient,
  ),
  ConnectorKind.mysql => MysqlSource(config, password: secret),
  ConnectorKind.mongodb => MongoSource(config, connectionString: secret),
  ConnectorKind.webhook => throw const ConnectorException(
    'Un webhook entrant reçoit les données : rien à lire.',
  ),
};

/// Base des sources HTTP (délai, erreurs, décodage JSON).
abstract base class _HttpSource implements RecordSource {
  _HttpSource(http.Client? client)
    : _client = client ?? http.Client(),
      _ownsClient = client == null;

  final http.Client _client;
  final bool _ownsClient;

  String get label;

  Future<Object?> getJson(Uri uri, Map<String, String> headers) async {
    final http.Response response;
    try {
      response = await _client
          .get(uri, headers: {'accept': 'application/json', ...headers})
          .timeout(_timeout);
    } on TimeoutException {
      throw ConnectorException('$label : délai dépassé.');
    } on Object {
      throw ConnectorException('$label : serveur injoignable (${uri.host}).');
    }
    if (response.statusCode == 401 || response.statusCode == 403) {
      throw ConnectorException(
        '$label : accès refusé (${response.statusCode}). Vérifiez la clé.',
      );
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ConnectorException(
        '$label : réponse ${response.statusCode} de ${uri.host}.',
      );
    }
    try {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw ConnectorException('$label : la réponse n’est pas du JSON.');
    }
  }

  @override
  Future<void> close() async {
    if (_ownsClient) _client.close();
  }
}

List<RawRecord> _records(Object? json, String? path, String label) {
  final list = path == null ? json : readPath(json, path);
  if (list is! List) {
    throw ConnectorException(
      path == null
          ? '$label : liste d’enregistrements attendue.'
          : '$label : pas de liste au chemin « $path ».',
    );
  }
  return [
    for (final item in list)
      if (item is Map) item.cast<String, Object?>(),
  ];
}

/// API REST renvoyant une liste JSON (éventuellement paginée).
///
/// Configuration : `url`, `records_path` (chemin de la liste dans la
/// réponse), `auth_header` (en-tête portant le secret, `Authorization`
/// par défaut), `page_param` / `page_start` (pagination par numéro) ou
/// `next_path` (chemin de l'URL de la page suivante).
final class RestSource extends _HttpSource {
  RestSource(this.config, {this.secret, http.Client? client}) : super(client);

  final Map<String, Object?> config;
  final String? secret;

  @override
  String get label => 'API REST';

  @override
  Future<List<RawRecord>> fetch({int limit = 10000}) async {
    final url = Uri.tryParse(requireConfig(config, 'url', 'URL'));
    if (url == null || !url.hasScheme || !url.scheme.startsWith('http')) {
      throw const ConnectorException('URL invalide.');
    }
    final headers = {
      if (config['headers'] case final Map<Object?, Object?> extra)
        for (final MapEntry(:key, :value) in extra.entries) '$key': '$value',
      if (secret != null && secret!.isNotEmpty)
        optionalConfig(config, 'auth_header') ?? 'authorization': secret!,
    };
    final path = optionalConfig(config, 'records_path');
    final pageParam = optionalConfig(config, 'page_param');
    final nextPath = optionalConfig(config, 'next_path');
    var page = switch (config['page_start']) {
      final int n => n,
      _ => 1,
    };
    final result = <RawRecord>[];
    Uri? next = pageParam == null
        ? url
        : url.replace(
            queryParameters: {...url.queryParameters, pageParam: '$page'},
          );
    for (var i = 0; next != null && i < 1000; i++) {
      final json = await getJson(next, headers);
      final records = _records(json, path, label);
      result.addAll(records);
      if (records.isEmpty || result.length >= limit) break;
      if (nextPath != null) {
        final link = readPath(json, nextPath);
        next = link is String && link.isNotEmpty ? url.resolve(link) : null;
      } else if (pageParam != null) {
        page++;
        next = url.replace(
          queryParameters: {...url.queryParameters, pageParam: '$page'},
        );
      } else {
        next = null;
      }
    }
    return result.take(limit).toList();
  }
}

/// Table Supabase (API PostgREST).
///
/// Configuration : `url` (projet), `table`, `select` (`*`), `filter`
/// (filtres PostgREST, ex. `statut=eq.actif`), `order` (`id`). Secret :
/// clé d'API (clé « anon » avec politiques RLS, ou « service_role »).
final class SupabaseSource extends _HttpSource {
  SupabaseSource(this.config, {this.secret, http.Client? client})
    : super(client);

  final Map<String, Object?> config;
  final String? secret;

  static const _pageSize = 1000;

  @override
  String get label => 'Supabase';

  @override
  Future<List<RawRecord>> fetch({int limit = 10000}) async {
    final base = Uri.tryParse(requireConfig(config, 'url', 'URL du projet'));
    final table = requireConfig(config, 'table', 'Table');
    final key = secret;
    if (base == null || !base.hasScheme) {
      throw const ConnectorException('URL du projet invalide.');
    }
    if (key == null || key.isEmpty) {
      throw const ConnectorException('Supabase : clé d’API requise.');
    }
    final filters = Uri.splitQueryString(
      optionalConfig(config, 'filter') ?? '',
    );
    final result = <RawRecord>[];
    for (var offset = 0; result.length < limit; offset += _pageSize) {
      final uri = base.replace(
        path: '/rest/v1/${Uri.encodeComponent(table)}',
        queryParameters: {
          ...filters,
          'select': optionalConfig(config, 'select') ?? '*',
          'order': optionalConfig(config, 'order') ?? 'id',
          'offset': '$offset',
          'limit': '$_pageSize',
        },
      );
      final page = _records(
        await getJson(uri, {'apikey': key, 'authorization': 'Bearer $key'}),
        null,
        label,
      );
      result.addAll(page);
      if (page.length < _pageSize) break;
    }
    return result.take(limit).toList();
  }
}

/// Collection Cloud Firestore (API REST).
///
/// Configuration : `project_id`, `collection`, `database` (`(default)`).
/// Secret : clé d'API web (les règles de sécurité doivent autoriser la
/// lecture) ou jeton d'accès OAuth (`Bearer …`).
final class FirestoreSource extends _HttpSource {
  FirestoreSource(this.config, {this.secret, http.Client? client})
    : super(client);

  final Map<String, Object?> config;
  final String? secret;

  @override
  String get label => 'Firebase';

  @override
  Future<List<RawRecord>> fetch({int limit = 10000}) async {
    final project = requireConfig(config, 'project_id', 'Projet');
    final collection = requireConfig(config, 'collection', 'Collection');
    final database = optionalConfig(config, 'database') ?? '(default)';
    final bearer = secret != null && secret!.startsWith('Bearer ');
    final result = <RawRecord>[];
    String? pageToken;
    do {
      final uri = Uri.https(
        'firestore.googleapis.com',
        '/v1/projects/$project/databases/$database/documents/$collection',
        {
          'pageSize': '300',
          'pageToken': ?pageToken,
          if (secret != null && secret!.isNotEmpty && !bearer) 'key': secret!,
        },
      );
      final json = await getJson(uri, {if (bearer) 'authorization': secret!});
      final documents = switch (json) {
        {'documents': final List<Object?> docs} => docs,
        _ => const <Object?>[],
      };
      for (final doc in documents.whereType<Map<Object?, Object?>>()) {
        final name = '${doc['name']}';
        result.add({
          'id': name.substring(name.lastIndexOf('/') + 1),
          ...firestoreFields(doc['fields']),
        });
      }
      pageToken = switch (json) {
        {'nextPageToken': final String token} => token,
        _ => null,
      };
    } while (pageToken != null && result.length < limit);
    return result.take(limit).toList();
  }
}

/// Champs d'un document Firestore (valeurs typées → JSON simple).
Map<String, Object?> firestoreFields(Object? fields) => {
  if (fields case final Map<Object?, Object?> map)
    for (final MapEntry(:key, :value) in map.entries)
      '$key': firestoreValue(value),
};

Object? firestoreValue(Object? value) => switch (value) {
  {'stringValue': final Object? v} => v,
  {'integerValue': final Object? v} => int.tryParse('$v'),
  {'doubleValue': final num v} => v,
  {'booleanValue': final Object? v} => v,
  {'timestampValue': final Object? v} => v,
  {'referenceValue': final String v} => v.substring(v.lastIndexOf('/') + 1),
  {'geoPointValue': final Map<Object?, Object?> v} => {
    'latitude': v['latitude'],
    'longitude': v['longitude'],
  },
  {'mapValue': final Map<Object?, Object?> v} => firestoreFields(v['fields']),
  {'arrayValue': final Map<Object?, Object?> v} => [
    if (v['values'] case final List<Object?> values)
      for (final item in values) firestoreValue(item),
  ],
  _ => null,
};

/// Conversion d'une valeur de base de données en JSON simple.
Object? _plain(Object? value) => switch (value) {
  null || String() || num() || bool() => value,
  final DateTime d => d.toUtc().toIso8601String(),
  final mongo.ObjectId id => id.oid,
  final Uint8List _ => null,
  final Map<Object?, Object?> map => {
    for (final MapEntry(:key, :value) in map.entries) '$key': _plain(value),
  },
  final List<Object?> list => [for (final v in list) _plain(v)],
  _ => '$value',
};

/// Requête SELECT sur une base MySQL ou MariaDB.
///
/// Configuration : `host`, `port` (3306), `database`, `user`, `secure`
/// (TLS, oui par défaut), `query` (SELECT). Secret : mot de passe.
final class MysqlSource implements RecordSource {
  MysqlSource(this.config, {this.password});

  final Map<String, Object?> config;
  final String? password;
  MySQLConnection? _connection;

  @override
  Future<List<RawRecord>> fetch({int limit = 10000}) async {
    final query = requireConfig(config, 'query', 'Requête');
    if (!RegExp(r'^\s*(select|with)\b', caseSensitive: false).hasMatch(query) ||
        query.contains(';')) {
      throw const ConnectorException(
        'MySQL : une seule requête SELECT est acceptée.',
      );
    }
    try {
      final connection = _connection = await MySQLConnection.createConnection(
        host: requireConfig(config, 'host', 'Serveur'),
        port: switch (config['port']) {
          final int p => p,
          _ => 3306,
        },
        userName: requireConfig(config, 'user', 'Utilisateur'),
        password: password ?? '',
        databaseName: optionalConfig(config, 'database'),
        secure: config['secure'] != false,
      ).timeout(_timeout);
      await connection.connect(timeoutMs: _timeout.inMilliseconds);
      final result = await connection
          .execute(query, null, true)
          .timeout(_timeout);
      final records = <RawRecord>[];
      await for (final row in result.rowsStream) {
        records.add({
          for (final MapEntry(:key, :value) in row.typedAssoc().entries)
            key: _plain(value),
        });
        if (records.length >= limit) break;
      }
      return records;
    } on ConnectorException {
      rethrow;
    } on TimeoutException {
      throw const ConnectorException('MySQL : délai dépassé.');
    } on Object catch (e) {
      throw ConnectorException('MySQL : ${_firstLine(e)}');
    }
  }

  @override
  Future<void> close() async {
    try {
      await _connection?.close();
    } on Object {
      // Connexion déjà fermée.
    }
  }
}

/// Collection MongoDB.
///
/// Configuration : `collection`, `filter` (objet JSON). Secret : chaîne
/// de connexion (`mongodb://…` ou `mongodb+srv://…`).
final class MongoSource implements RecordSource {
  MongoSource(this.config, {this.connectionString});

  final Map<String, Object?> config;
  final String? connectionString;
  mongo.Db? _db;

  @override
  Future<List<RawRecord>> fetch({int limit = 10000}) async {
    final uri = connectionString;
    if (uri == null || !uri.startsWith('mongodb')) {
      throw const ConnectorException(
        'MongoDB : chaîne de connexion requise (mongodb://…).',
      );
    }
    final collection = requireConfig(config, 'collection', 'Collection');
    final Map<String, Object?> filter;
    try {
      filter = switch (jsonDecode(optionalConfig(config, 'filter') ?? '{}')) {
        final Map<String, Object?> map => map,
        _ => throw const FormatException(),
      };
    } on FormatException {
      throw const ConnectorException('MongoDB : filtre JSON invalide.');
    }
    try {
      final db = _db = await mongo.Db.create(uri).timeout(_timeout);
      await db.open().timeout(_timeout);
      final documents = await db
          .collection(collection)
          .find(filter)
          .take(limit)
          .toList()
          .timeout(_timeout);
      return [
        for (final doc in documents)
          {
            for (final MapEntry(:key, :value) in doc.entries)
              key == '_id' ? 'id' : key: _plain(value),
          },
      ];
    } on TimeoutException {
      throw const ConnectorException('MongoDB : délai dépassé.');
    } on Object catch (e) {
      throw ConnectorException('MongoDB : ${_firstLine(e)}');
    }
  }

  @override
  Future<void> close() async {
    try {
      await _db?.close();
    } on Object {
      // Connexion déjà fermée.
    }
  }
}

/// Première ligne d'un message d'erreur, sans identifiants de connexion.
String _firstLine(Object error) =>
    '$error'.split('\n').first.replaceAll(RegExp(r'//[^@/\s]+@'), '//***@');
