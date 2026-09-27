import 'dart:async';
import 'dart:io';

import 'package:fr_public_data/fr_public_data.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:voyaj_shared/voyaj_shared.dart';

import 'admin/backup_service.dart';
import 'admin/gdpr_service.dart';
import 'ai/ai_service.dart';
import 'ai/claude_client.dart';
import 'auth/auth_service.dart';
import 'auth/users_service.dart';
import 'billing/billing_service.dart';
import 'billing/chorus_pro.dart';
import 'calendar/calendar_service.dart';
import 'config.dart';
import 'connectors/connector_service.dart';
import 'connectors/webhook_service.dart';
import 'db/database.dart';
import 'db/migrations.dart';
import 'email/email_service.dart';
import 'email/mail_transport.dart';
import 'email/oauth.dart';
import 'files/file_store.dart';
import 'http/api.dart';
import 'public_data/public_data_service.dart';
import 'realtime/realtime_hub.dart';
import 'security/passwords.dart';
import 'security/secret_cipher.dart';
import 'signature/signature_service.dart';
import 'signature/yousign_client.dart';
import 'sync/sync_service.dart';
import 'tenders/tender_service.dart';

final _log = Logger('server');

/// Services du serveur, reliés entre eux.
final class Services {
  Services._(
    this.db,
    this.auth,
    this.users,
    this.sync,
    this.hub,
    this.files,
    this.publicData,
    this.email,
    this.billing,
    this.connectors,
    this.webhooks,
    this.calendar,
    this.gdpr,
    this.backups,
    this.tenders,
    this.signatures,
    this.ai,
  );

  factory Services.create(
    ServerConfig config,
    Database db, {
    PublicDataClient? publicDataClient,
    MailTransport? mailTransport,
    OAuthClient? oauthClient,
    ChorusProClient? chorusClient,
    SourceOpener? sourceOpener,
    http.Client? webhookClient,
    BoampClient? boampClient,
    http.Client? yousignHttp,
    http.Client? aiHttp,
  }) {
    final cipher = SecretCipher(config.masterKey);
    final hasher = PasswordHasher(
      memoryKib: config.argon2MemoryKib,
      iterations: config.argon2Iterations,
    );
    final auth = AuthService(
      db: db,
      hasher: hasher,
      cipher: cipher,
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
    final files = FileStore(db: db, dataDir: config.dataDir);
    return Services._(
      db,
      auth,
      users,
      sync,
      hub,
      files,
      PublicDataService(
        db: db,
        sync: sync,
        client: publicDataClient ?? PublicDataClient(),
        scheduleHour: config.publicDataHour,
      ),
      EmailService(
        db: db,
        sync: sync,
        cipher: cipher,
        transport: mailTransport ?? const ImapSmtpTransport(),
        oauth: oauthClient ?? OAuthClient(),
        publicUrl: config.publicUrl,
        oauthApps: {
          if (config.googleClientId != null &&
              config.googleClientSecret != null)
            EmailProvider.google: OAuthApp.google(
              clientId: config.googleClientId!,
              clientSecret: config.googleClientSecret!,
            ),
          if (config.microsoftClientId != null &&
              config.microsoftClientSecret != null)
            EmailProvider.microsoft: OAuthApp.microsoft(
              clientId: config.microsoftClientId!,
              clientSecret: config.microsoftClientSecret!,
              tenant: config.microsoftTenant,
            ),
        },
      ),
      BillingService(
        db: db,
        sync: sync,
        files: files,
        cipher: cipher,
        chorus: chorusClient ?? ChorusProClient(),
      ),
      ConnectorService(
        db: db,
        sync: sync,
        cipher: cipher,
        publicUrl: config.publicUrl,
        sourceOpener: sourceOpener,
      ),
      WebhookService(
        db: db,
        sync: sync,
        cipher: cipher,
        httpClient: webhookClient,
      ),
      CalendarService(db: db, publicUrl: config.publicUrl),
      GdprService(db: db, sync: sync),
      BackupService(
        directory: config.backupDir ?? p.join(config.dataDir, 'backups'),
        database: config.database,
        dataDir: config.dataDir,
        hour: config.backupHour,
        keepDays: config.backupKeepDays,
        pgDump: config.pgDumpPath,
      ),
      TenderService(db: db, boamp: boampClient ?? BoampClient()),
      SignatureService(
        db: db,
        sync: sync,
        files: files,
        client: config.yousignApiKey == null
            ? null
            : YousignClient(
                apiKey: config.yousignApiKey!,
                sandbox: config.yousignSandbox,
                httpClient: yousignHttp,
              ),
        webhookSecret: config.yousignWebhookSecret,
      ),
      AiService(
        db: db,
        client: config.anthropicApiKey == null
            ? null
            : ClaudeClient(
                apiKey: config.anthropicApiKey!,
                model: config.aiModel,
                httpClient: aiHttp,
              ),
      ),
    );
  }

  final Database db;
  final AuthService auth;
  final UsersService users;
  final SyncService sync;
  final RealtimeHub hub;
  final FileStore files;
  final PublicDataService publicData;
  final EmailService email;
  final BillingService billing;
  final ConnectorService connectors;
  final WebhookService webhooks;
  final CalendarService calendar;
  final GdprService gdpr;
  final BackupService backups;
  final TenderService tenders;
  final SignatureService signatures;
  final AiService ai;
}

/// Serveur HTTP en cours d'exécution.
final class VoyajServer {
  VoyajServer._(this._http, this.services, this._timers);

  final HttpServer _http;
  final Services services;
  final List<Timer> _timers;

  int get port => _http.port;

  /// Démarre le serveur : base, migrations, rôles système, HTTP.
  static Future<VoyajServer> start(
    ServerConfig config, {
    PublicDataClient? publicDataClient,
    MailTransport? mailTransport,
    OAuthClient? oauthClient,
    ChorusProClient? chorusClient,
    SourceOpener? sourceOpener,
    http.Client? webhookClient,
    BoampClient? boampClient,
    http.Client? yousignHttp,
    http.Client? aiHttp,
  }) async {
    final db = Database.open(config.database, poolSize: config.dbPoolSize);
    if (config.autoMigrate) {
      final applied = await migrate(db);
      if (applied.isNotEmpty) _log.info('Migrations appliquées : $applied');
    }
    final services = Services.create(
      config,
      db,
      publicDataClient: publicDataClient,
      mailTransport: mailTransport,
      oauthClient: oauthClient,
      chorusClient: chorusClient,
      sourceOpener: sourceOpener,
      webhookClient: webhookClient,
      boampClient: boampClient,
      yousignHttp: yousignHttp,
      aiHttp: aiHttp,
    );
    await services.users.syncSystemRoles();
    await services.publicData.recoverInterrupted();
    await services.connectors.recoverInterrupted();
    services.webhooks.start();

    final handler = buildHandler(
      db: db,
      auth: services.auth,
      users: services.users,
      sync: services.sync,
      hub: services.hub,
      files: services.files,
      publicData: services.publicData,
      email: services.email,
      billing: services.billing,
      connectors: services.connectors,
      webhooks: services.webhooks,
      calendar: services.calendar,
      gdpr: services.gdpr,
      backups: services.backups,
      tenders: services.tenders,
      signatures: services.signatures,
      ai: services.ai,
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
      unawaited(
        services.publicData.runScheduledIfDue().catchError(
          (Object e) =>
              _log.warning('Import planifié des données publiques', e),
        ),
      );
      unawaited(
        services.tenders.runScheduledIfDue().catchError(
          (Object e) => _log.warning('Veille des appels d’offres', e),
        ),
      );
      unawaited(
        services.backups.runScheduledIfDue().catchError(
          (Object e) => _log.warning('Sauvegarde planifiée', e),
        ),
      );
      unawaited(
        services.connectors.runScheduledIfDue().catchError(
          (Object e) => _log.warning('Imports planifiés des connecteurs', e),
        ),
      );
    });

    _log.info(
      'Voyaj CRM serveur $serverVersion à l’écoute sur '
      '${config.tlsEnabled ? 'https' : 'http'}://${config.host}:${http.port}',
    );
    // Messagerie : réception et envoi des séquences toutes les 5 minutes.
    final mail = Timer.periodic(const Duration(minutes: 5), (_) {
      unawaited(
        () async {
          await services.email.syncAll();
          await services.email.processSequences();
        }().catchError(
          (Object e) => _log.warning('Messagerie (tâche périodique)', e),
        ),
      );
    });
    return VoyajServer._(http, services, [housekeeping, mail]);
  }

  Future<void> close() async {
    for (final timer in _timers) {
      timer.cancel();
    }
    await _http.close(force: true);
    await services.webhooks.close();
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
