import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:voyaj_server/voyaj_server.dart';

Future<void> main(List<String> args) async {
  final runner =
      CommandRunner<int>(
          'voyaj_server',
          'Serveur Voyaj CRM (API REST + synchronisation).',
        )
        ..argParser.addOption(
          'env-file',
          help: 'Fichier .env à charger (défaut : ./.env s’il existe).',
        )
        ..argParser.addOption(
          'config',
          help: 'Fichier de configuration YAML (ou VOYAJ_CONFIG).',
        )
        ..addCommand(_ServeCommand())
        ..addCommand(_MigrateCommand())
        ..addCommand(_CreateAdminCommand())
        ..addCommand(_GenKeyCommand())
        ..addCommand(_AuditVerifyCommand());
  try {
    exitCode = await runner.run(args) ?? 0;
  } on UsageException catch (e) {
    stderr.writeln(e);
    exitCode = 64;
  } on ConfigException catch (e) {
    stderr.writeln(e);
    exitCode = 78;
  } on ApiException catch (e) {
    stderr.writeln(e.message);
    for (final issue in e.issues) {
      stderr.writeln('  - ${issue.message}');
    }
    exitCode = 1;
  }
}

ServerConfig _loadConfig(Command<int> command) => ServerConfig.load(
  envFile: command.globalResults?['env-file'] as String?,
  yamlFile: command.globalResults?['config'] as String?,
);

final class _ServeCommand extends Command<int> {
  @override
  String get name => 'serve';

  @override
  String get description => 'Démarre le serveur.';

  @override
  Future<int> run() async {
    final config = _loadConfig(this);
    configureLogging(config.logLevel);
    final server = await VoyajServer.start(config);

    final done = Completer<void>();
    void stop(ProcessSignal signal) {
      if (!done.isCompleted) done.complete();
    }

    final subscriptions = [
      ProcessSignal.sigint.watch().listen(stop),
      if (!Platform.isWindows) ProcessSignal.sigterm.watch().listen(stop),
    ];
    await done.future;
    for (final sub in subscriptions) {
      await sub.cancel();
    }
    await server.close();
    return 0;
  }
}

final class _MigrateCommand extends Command<int> {
  @override
  String get name => 'migrate';

  @override
  String get description => 'Applique les migrations PostgreSQL.';

  @override
  Future<int> run() async {
    final config = _loadConfig(this);
    configureLogging(config.logLevel);
    final db = Database.open(config.database, poolSize: 1);
    try {
      final applied = await migrate(db);
      stdout.writeln(
        applied.isEmpty
            ? 'Base à jour.'
            : 'Migrations appliquées : ${applied.join(', ')}',
      );
      return 0;
    } finally {
      await db.close();
    }
  }
}

final class _CreateAdminCommand extends Command<int> {
  _CreateAdminCommand() {
    argParser
      ..addOption('email', mandatory: true)
      ..addOption('name', mandatory: true, help: 'Nom affiché.')
      ..addOption(
        'password',
        help:
            'Mot de passe (sinon lu sur l’entrée standard ou la variable '
            'VOYAJ_ADMIN_PASSWORD).',
      );
  }

  @override
  String get name => 'create-admin';

  @override
  String get description => 'Crée un compte administrateur.';

  @override
  Future<int> run() async {
    final config = _loadConfig(this);
    final password =
        argResults!['password'] as String? ??
        Platform.environment['VOYAJ_ADMIN_PASSWORD'] ??
        _promptPassword();
    final db = Database.open(config.database, poolSize: 1);
    try {
      await migrate(db);
      final users = UsersService(
        db: db,
        hasher: PasswordHasher(
          memoryKib: config.argon2MemoryKib,
          iterations: config.argon2Iterations,
        ),
      );
      final id = await users.createAdmin(
        email: argResults!['email'] as String,
        displayName: argResults!['name'] as String,
        password: password,
      );
      stdout.writeln('Administrateur créé ($id).');
      return 0;
    } finally {
      await db.close();
    }
  }

  String _promptPassword() {
    stdout.write('Mot de passe (12 caractères minimum) : ');
    stdin.echoMode = false;
    try {
      return stdin.readLineSync() ?? '';
    } finally {
      stdin.echoMode = true;
      stdout.writeln();
    }
  }
}

final class _GenKeyCommand extends Command<int> {
  @override
  String get name => 'gen-key';

  @override
  String get description =>
      'Génère une clé maître aléatoire (VOYAJ_MASTER_KEY).';

  @override
  int run() {
    final random = Random.secure();
    stdout.writeln(
      base64.encode(List<int>.generate(32, (_) => random.nextInt(256))),
    );
    return 0;
  }
}

final class _AuditVerifyCommand extends Command<int> {
  @override
  String get name => 'audit-verify';

  @override
  String get description => "Vérifie l'intégrité du journal d'audit.";

  @override
  Future<int> run() async {
    final db = Database.open(_loadConfig(this).database, poolSize: 1);
    try {
      final broken = await AuditLog.verifyChain(db);
      if (broken == null) {
        stdout.writeln("Journal d'audit intègre.");
        return 0;
      }
      stderr.writeln("Journal d'audit altéré à partir de l'entrée $broken.");
      return 2;
    } finally {
      await db.close();
    }
  }
}
