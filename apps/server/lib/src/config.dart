import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

/// Erreur de configuration : le serveur refuse de démarrer.
final class ConfigException implements Exception {
  const ConfigException(this.message);

  final String message;

  @override
  String toString() => 'Configuration invalide : $message';
}

/// Configuration du serveur.
///
/// Sources, par priorité décroissante :
/// 1. variables d'environnement ;
/// 2. fichier `.env` (répertoire courant ou `--env-file`) ;
/// 3. fichier YAML (`--config` ou `VOYAJ_CONFIG`), clés sans préfixe
///    (`port: 8080` équivaut à `VOYAJ_PORT=8080`) ;
/// 4. valeurs par défaut.
///
/// Aucun secret n'a de valeur par défaut.
@immutable
final class ServerConfig {
  const ServerConfig({
    required this.host,
    required this.port,
    required this.database,
    required this.masterKey,
    this.dbPoolSize = 10,
    this.trustProxy = false,
    this.tlsCertPath,
    this.tlsKeyPath,
    this.logLevel = 'INFO',
    this.accessTokenTtl = const Duration(minutes: 15),
    this.refreshTokenTtl = const Duration(days: 30),
    this.autoMigrate = true,
    this.argon2MemoryKib = 19456,
    this.argon2Iterations = 2,
    this.dataDir = 'data',
    this.publicDataHour = 3,
    this.publicUrl,
    this.googleClientId,
    this.googleClientSecret,
    this.microsoftClientId,
    this.microsoftClientSecret,
    this.microsoftTenant = 'common',
    this.backupDir,
    this.backupHour = 2,
    this.backupKeepDays = 14,
    this.pgDumpPath = 'pg_dump',
    this.yousignApiKey,
    this.yousignSandbox = true,
    this.yousignWebhookSecret,
    this.anthropicApiKey,
    this.aiModel = 'claude-opus-5',
  });

  /// Charge la configuration depuis l'environnement et les fichiers.
  factory ServerConfig.load({
    String? envFile,
    String? yamlFile,
    Map<String, String>? environment,
  }) {
    final env = environment ?? Platform.environment;
    final values = <String, String>{};

    final yamlPath = yamlFile ?? env['VOYAJ_CONFIG'];
    if (yamlPath != null) values.addAll(_readYaml(yamlPath));

    final dotEnv = File(envFile ?? '.env');
    if (dotEnv.existsSync()) {
      values.addAll(parseDotEnv(dotEnv.readAsStringSync()));
    } else if (envFile != null) {
      throw ConfigException('fichier introuvable : $envFile');
    }

    values.addAll(env);
    return ServerConfig.fromMap(values);
  }

  /// Construit la configuration à partir de variables `VOYAJ_*`.
  factory ServerConfig.fromMap(Map<String, String> values) {
    String? read(String key) {
      final value = values[key]?.trim();
      return value == null || value.isEmpty ? null : value;
    }

    int readInt(String key, int fallback) {
      final raw = read(key);
      if (raw == null) return fallback;
      return int.tryParse(raw) ??
          (throw ConfigException('$key doit être un entier'));
    }

    bool readBool(String key, {required bool fallback}) {
      final raw = read(key)?.toLowerCase();
      if (raw == null) return fallback;
      if (const {'1', 'true', 'yes', 'oui'}.contains(raw)) return true;
      if (const {'0', 'false', 'no', 'non'}.contains(raw)) return false;
      throw ConfigException('$key doit être true ou false');
    }

    final databaseUrl =
        read('DATABASE_URL') ??
        (throw const ConfigException('DATABASE_URL est obligatoire'));
    final masterKeyText =
        read('VOYAJ_MASTER_KEY') ??
        (throw const ConfigException(
          'VOYAJ_MASTER_KEY est obligatoire '
          '(générez-la avec `voyaj_server gen-key`)',
        ));

    final config = ServerConfig(
      host: read('VOYAJ_HOST') ?? '127.0.0.1',
      port: readInt('VOYAJ_PORT', 8080),
      database: DatabaseConfig.parse(databaseUrl),
      masterKey: _decodeMasterKey(masterKeyText),
      dbPoolSize: readInt('VOYAJ_DB_POOL_SIZE', 10),
      trustProxy: readBool('VOYAJ_TRUST_PROXY', fallback: false),
      tlsCertPath: read('VOYAJ_TLS_CERT'),
      tlsKeyPath: read('VOYAJ_TLS_KEY'),
      logLevel: (read('VOYAJ_LOG_LEVEL') ?? 'INFO').toUpperCase(),
      accessTokenTtl: Duration(
        minutes: readInt('VOYAJ_ACCESS_TOKEN_TTL_MINUTES', 15),
      ),
      refreshTokenTtl: Duration(
        days: readInt('VOYAJ_REFRESH_TOKEN_TTL_DAYS', 30),
      ),
      autoMigrate: readBool('VOYAJ_AUTO_MIGRATE', fallback: true),
      argon2MemoryKib: readInt('VOYAJ_ARGON2_MEMORY_KIB', 19456),
      argon2Iterations: readInt('VOYAJ_ARGON2_ITERATIONS', 2),
      dataDir: read('VOYAJ_DATA_DIR') ?? 'data',
      publicUrl: switch (read('VOYAJ_PUBLIC_URL')) {
        null => null,
        final url =>
          Uri.tryParse(url) ??
              (throw const ConfigException('VOYAJ_PUBLIC_URL invalide')),
      },
      googleClientId: read('VOYAJ_GOOGLE_CLIENT_ID'),
      googleClientSecret: read('VOYAJ_GOOGLE_CLIENT_SECRET'),
      microsoftClientId: read('VOYAJ_MICROSOFT_CLIENT_ID'),
      microsoftClientSecret: read('VOYAJ_MICROSOFT_CLIENT_SECRET'),
      microsoftTenant: read('VOYAJ_MICROSOFT_TENANT') ?? 'common',
      backupDir: read('VOYAJ_BACKUP_DIR'),
      backupHour: switch (read('VOYAJ_BACKUP_HOUR')?.toLowerCase()) {
        null => 2,
        'off' || 'non' || 'false' => null,
        final text => switch (int.tryParse(text)) {
          final h? when h >= 0 && h < 24 => h,
          _ => throw const ConfigException(
            'VOYAJ_BACKUP_HOUR doit être une heure (0-23) ou off',
          ),
        },
      },
      backupKeepDays: readInt('VOYAJ_BACKUP_KEEP_DAYS', 14),
      pgDumpPath: read('VOYAJ_PG_DUMP') ?? 'pg_dump',
      yousignApiKey: read('VOYAJ_YOUSIGN_API_KEY'),
      yousignSandbox: readBool('VOYAJ_YOUSIGN_SANDBOX', fallback: true),
      yousignWebhookSecret: read('VOYAJ_YOUSIGN_WEBHOOK_SECRET'),
      anthropicApiKey: read('ANTHROPIC_API_KEY'),
      aiModel: read('VOYAJ_AI_MODEL') ?? 'claude-opus-5',
      publicDataHour: switch (read('VOYAJ_PUBLIC_DATA_HOUR')?.toLowerCase()) {
        null => 3,
        'off' || 'non' || 'false' => null,
        final text =>
          int.tryParse(text) ??
              (throw const ConfigException(
                'VOYAJ_PUBLIC_DATA_HOUR doit être une heure (0-23) ou off',
              )),
      },
    );
    config.validate();
    return config;
  }

  final String host;
  final int port;
  final DatabaseConfig database;

  /// Clé AES-256 de chiffrement des secrets au repos (32 octets).
  final List<int> masterKey;
  final int dbPoolSize;

  /// Le serveur est derrière un reverse proxy TLS (Caddy) : on fait
  /// confiance à `X-Forwarded-For` et le TLS est assuré par le proxy.
  final bool trustProxy;
  final String? tlsCertPath;
  final String? tlsKeyPath;
  final String logLevel;
  final Duration accessTokenTtl;
  final Duration refreshTokenTtl;
  final bool autoMigrate;
  final int argon2MemoryKib;
  final int argon2Iterations;

  /// Dossier des données sur disque (fichiers joints), relatif au
  /// répertoire de travail s'il n'est pas absolu.
  final String dataDir;

  /// Heure locale de l'import quotidien des données publiques (`null` :
  /// désactivé).
  final int? publicDataHour;

  /// Adresse publique du serveur (ex. `https://crm.voyaj.fr`), nécessaire
  /// aux connexions OAuth (retour du navigateur).
  final Uri? publicUrl;

  /// Application OAuth Google (Gmail) et Microsoft (Outlook / 365).
  final String? googleClientId;
  final String? googleClientSecret;
  final String? microsoftClientId;
  final String? microsoftClientSecret;
  final String microsoftTenant;

  /// Dossier des sauvegardes (`null` : `<dataDir>/backups`) ; à placer
  /// de préférence sur un autre disque, recopié hors site.
  final String? backupDir;

  /// Heure locale de la sauvegarde quotidienne (`null` : désactivée).
  final int? backupHour;
  final int backupKeepDays;

  /// Exécutable `pg_dump` (même version majeure que le serveur PostgreSQL).
  final String pgDumpPath;

  /// Signature électronique (Yousign) : clé d'API, environnement de test,
  /// secret des notifications.
  final String? yousignApiKey;
  final bool yousignSandbox;
  final String? yousignWebhookSecret;

  /// Assistant IA (Claude) : clé d'API Anthropic (`null` : désactivé) et
  /// modèle.
  final String? anthropicApiKey;
  final String aiModel;

  bool get tlsEnabled => tlsCertPath != null && tlsKeyPath != null;

  bool get isLoopback => const {'127.0.0.1', 'localhost', '::1'}.contains(host);

  /// TLS obligatoire hors localhost (directement ou via un proxy).
  void validate() {
    if ((tlsCertPath == null) != (tlsKeyPath == null)) {
      throw const ConfigException(
        'VOYAJ_TLS_CERT et VOYAJ_TLS_KEY vont ensemble',
      );
    }
    if (!isLoopback && !tlsEnabled && !trustProxy) {
      throw ConfigException(
        'écoute sur $host sans TLS : configurez VOYAJ_TLS_CERT/VOYAJ_TLS_KEY '
        'ou placez le serveur derrière un reverse proxy HTTPS '
        '(VOYAJ_TRUST_PROXY=true)',
      );
    }
    if (port <= 0 || port > 65535) {
      throw ConfigException('port invalide : $port');
    }
    if (publicDataHour != null &&
        (publicDataHour! < 0 || publicDataHour! > 23)) {
      throw ConfigException('heure d’import invalide : $publicDataHour');
    }
    if (argon2MemoryKib < 1024 || argon2Iterations < 1) {
      throw const ConfigException('paramètres Argon2 trop faibles');
    }
  }

  static List<int> _decodeMasterKey(String text) {
    final List<int> bytes;
    try {
      bytes = base64.decode(text);
    } on FormatException {
      throw const ConfigException('VOYAJ_MASTER_KEY doit être en base64');
    }
    if (bytes.length != 32) {
      throw const ConfigException(
        'VOYAJ_MASTER_KEY doit faire 32 octets (256 bits)',
      );
    }
    return bytes;
  }

  static Map<String, String> _readYaml(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      throw ConfigException('fichier introuvable : $path');
    }
    final doc = loadYaml(file.readAsStringSync());
    if (doc is! YamlMap) {
      throw ConfigException('$path doit contenir un objet YAML');
    }
    return {
      for (final MapEntry(:key, :value) in doc.entries)
        if (value != null)
          key.toString().toUpperCase() == 'DATABASE_URL'
              ? 'DATABASE_URL'
              : 'VOYAJ_${key.toString().toUpperCase()}': value
              .toString(),
    };
  }
}

/// Paramètres de connexion PostgreSQL (depuis une URL `postgres://`).
@immutable
final class DatabaseConfig {
  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.password,
    required this.requireSsl,
  });

  factory DatabaseConfig.parse(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !const {'postgres', 'postgresql'}.contains(uri.scheme) ||
        uri.host.isEmpty ||
        uri.pathSegments.isEmpty) {
      throw const ConfigException(
        'DATABASE_URL doit être de la forme '
        'postgres://utilisateur:motdepasse@hote:5432/base',
      );
    }
    final userInfo = uri.userInfo.split(':');
    final sslMode = uri.queryParameters['sslmode'] ?? 'disable';
    return DatabaseConfig(
      host: uri.host,
      port: uri.hasPort ? uri.port : 5432,
      database: Uri.decodeComponent(uri.pathSegments.first),
      username: Uri.decodeComponent(userInfo.first),
      password: userInfo.length > 1
          ? Uri.decodeComponent(userInfo.sublist(1).join(':'))
          : null,
      requireSsl: sslMode != 'disable',
    );
  }

  final String host;
  final int port;
  final String database;
  final String username;
  final String? password;
  final bool requireSsl;
}

/// Analyse un fichier `.env` (`CLE=valeur`, commentaires `#`, guillemets).
Map<String, String> parseDotEnv(String content) {
  final values = <String, String>{};
  for (final rawLine in const LineSplitter().convert(content)) {
    final line = rawLine.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final separator = line.indexOf('=');
    if (separator <= 0) continue;
    final key = line
        .substring(0, separator)
        .replaceFirst(RegExp(r'^export\s+'), '')
        .trim();
    var value = line.substring(separator + 1).trim();
    if (value.length >= 2 &&
        ((value.startsWith('"') && value.endsWith('"')) ||
            (value.startsWith("'") && value.endsWith("'")))) {
      value = value.substring(1, value.length - 1);
    } else {
      final comment = value.indexOf(' #');
      if (comment >= 0) value = value.substring(0, comment).trim();
    }
    values[key] = value;
  }
  return values;
}
