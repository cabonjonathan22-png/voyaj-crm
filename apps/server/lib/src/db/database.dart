import 'package:postgres/postgres.dart';

import '../config.dart';

/// Accès PostgreSQL (pool de connexions).
final class Database {
  Database._(this._pool);

  /// Ouvre un pool vers la base configurée.
  factory Database.open(DatabaseConfig config, {int poolSize = 10}) {
    final pool = Pool<void>.withEndpoints(
      [
        Endpoint(
          host: config.host,
          port: config.port,
          database: config.database,
          username: config.username,
          password: config.password,
        ),
      ],
      settings: PoolSettings(
        maxConnectionCount: poolSize,
        sslMode: config.requireSsl ? SslMode.require : SslMode.disable,
        applicationName: 'voyaj_server',
      ),
    );
    return Database._(pool);
  }

  final Pool<void> _pool;

  /// Exécute [action] avec une connexion hors transaction.
  Future<T> run<T>(Future<T> Function(Session session) action) =>
      _pool.run(action);

  /// Réserve une connexion dédiée (verrous de session, transactions
  /// multiples).
  Future<T> withConnection<T>(Future<T> Function(Connection conn) action) =>
      _pool.withConnection(action);

  /// Exécute [action] dans une transaction (annulée en cas d'exception).
  Future<T> tx<T>(Future<T> Function(TxSession tx) action) =>
      _pool.runTx(action);

  /// Requête paramétrée (`@nom` ou `@nom:type`) hors transaction.
  Future<Result> query(String sql, [Map<String, Object?>? params]) =>
      _pool.execute(Sql.named(sql), parameters: params);

  Future<void> close() => _pool.close();
}

/// Raccourcis pour les requêtes nommées sur une session.
extension SessionQueries on Session {
  Future<Result> query(String sql, [Map<String, Object?>? params]) =>
      execute(Sql.named(sql), parameters: params);

  /// Première ligne sous forme de map, ou `null`.
  Future<Map<String, dynamic>?> queryOne(
    String sql, [
    Map<String, Object?>? params,
  ]) async {
    final result = await query(sql, params);
    return result.isEmpty ? null : result.first.toColumnMap();
  }

  Future<List<Map<String, dynamic>>> queryAll(
    String sql, [
    Map<String, Object?>? params,
  ]) async {
    final result = await query(sql, params);
    return [for (final row in result) row.toColumnMap()];
  }
}

/// Code SQLSTATE d'une violation de contrainte d'unicité.
const uniqueViolation = '23505';
