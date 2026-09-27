import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'auth/auth_service.dart';
import 'auth/users_service.dart';
import 'config.dart';
import 'db/database.dart';
import 'db/migrations.dart';
import 'files/file_store.dart';
import 'http/api.dart';
import 'realtime/realtime_hub.dart';
import 'security/passwords.dart';
import 'security/secret_cipher.dart';
import 'sync/sync_service.dart';

final _log = Logger('server');

/// Services du serveur, reliés entre eux.
final class Services {
  Services._(this.db, this.auth, this.users, this.sync, this.hub, this.files);

  factory Services.create(ServerConfig config, Database db) {
    final hasher = PasswordHasher(
      memoryKib: config.argon2MemoryKib,
      iterations: config.argon2Iterations,
    );
    final auth = AuthService(
      db: db,
      hasher: hasher,
      cipher: SecretCipher(config.masterKey),
      accessTtl: config.accessTokenTtl,
      refreshTtl: config.refreshTokenTtl,
    );
    final users = UsersService(db: db, hasher: hasher);
    final sync = SyncService(db: db);
    final hub = RealtimeHub(
      authenticate: auth.authenticate,
      currentCursor: sync.currentCursor,
      changes: sync.changes,
    );
    auth.onSessionsRevoked = hub.revokeSessions;
    users.onSessionsRevoked = hub.revokeSessions;
    return Services._(
      db,
      auth,
      users,
      sync,
      hub,
      FileStore(db: db, dataDir: config.dataDir),
    );
  }

  final Database db;
  final AuthService auth;
  final UsersService users;
  final SyncService sync;
  final RealtimeHub hub;
  final FileStore files;
}

/// Serveur HTTP en cours d'exécution.
final class VoyajServer {
  VoyajServer._(this._http, this.services, this._housekeeping);

  final HttpServer _http;
  final Services services;
  final Timer _housekeeping;

  int get port => _http.port;

  /// Démarre le serveur : base, migrations, rôles système, HTTP.
  static Future<VoyajServer> start(ServerConfig config) async {
    final db = Database.open(config.database, poolSize: config.dbPoolSize);
    if (config.autoMigrate) {
      final applied = await migrate(db);
      if (applied.isNotEmpty) _log.info('Migrations appliquées : $applied');
    }
    final services = Services.create(config, db);
    await services.users.syncSystemRoles();

    final handler = buildHandler(
      db: db,
      auth: services.auth,
      users: services.users,
      sync: services.sync,
      hub: services.hub,
      files: services.files,
      trustProxy: config.trustProxy,
      hsts: config.tlsEnabled || config.trustProxy,
    );

    SecurityContext? security;
    if (config.tlsEnabled) {
      security = SecurityContext()
        ..useCertificateChain(config.tlsCertPath!)
        ..usePrivateKey(config.tlsKeyPath!);
    }
    final http = await shelf_io.serve(
      handler,
      config.host,
      config.port,
      securityContext: security,
    );
    http.autoCompress = true;

    final housekeeping = Timer.periodic(const Duration(minutes: 10), (_) {
      unawaited(
        services.auth.purgeExpiredChallenges().catchError(
          (Object e) => _log.warning('Nettoyage des vérifications 2FA', e),
        ),
      );
    });

    _log.info(
      'Voyaj CRM serveur $serverVersion à l’écoute sur '
      '${config.tlsEnabled ? 'https' : 'http'}://${config.host}:${http.port}',
    );
    return VoyajServer._(http, services, housekeeping);
  }

  Future<void> close() async {
    _housekeeping.cancel();
    await _http.close(force: true);
    await services.hub.close();
    await services.sync.close();
    await services.db.close();
  }
}

/// Configure la journalisation sur la sortie standard.
void configureLogging(String level) {
  Logger.root.level = Level.LEVELS.firstWhere(
    (l) => l.name == level,
    orElse: () => Level.INFO,
  );
  Logger.root.onRecord.listen((record) {
    final line = StringBuffer(
      '${record.time.toUtc().toIso8601String()} ${record.level.name} '
      '[${record.loggerName}] ${record.message}',
    );
    if (record.error != null) line.write(' — ${record.error}');
    if (record.stackTrace != null && record.level >= Level.SEVERE) {
      line.write('\n${record.stackTrace}');
    }
    stdout.writeln(line);
  });
}
