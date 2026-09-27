import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:voyaj_shared/voyaj_shared.dart';

import '../auth/auth_context.dart';
import '../config.dart';
import '../db/migrations.dart';
import '../errors.dart';

final _log = Logger('backup');

/// Sauvegardes : base PostgreSQL (`pg_dump -Fc`) et fichiers joints
/// (copie incrémentale : un fichier est copié une seule fois, son nom étant
/// son empreinte). Quotidiennes à [hour] ; conservées [keepDays] jours.
///
/// Restauration : `pg_restore --clean --if-exists -d <base> <nom>.dump`
/// puis recopie du dossier `files` dans `VOYAJ_DATA_DIR/files`.
final class BackupService {
  BackupService({
    required this.directory,
    required this._database,
    required this._dataDir,
    required this.hour,
    required this.keepDays,
    this.pgDump = 'pg_dump',
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final String directory;
  final DatabaseConfig _database;
  final String _dataDir;
  final int? hour;
  final int keepDays;
  final String pgDump;
  final DateTime Function() _clock;

  Future<BackupInfo>? _running;
  String? _lastError;

  Future<BackupStatus> status(AuthContext ctx) async {
    ctx.require(Permission.backupManage);
    return BackupStatus(
      directory: p.absolute(directory),
      hour: hour,
      keepDays: keepDays,
      backups: await list(),
      lastError: _lastError,
    );
  }

  /// Sauvegardes présentes (plus récentes d'abord).
  Future<List<BackupInfo>> list() async {
    final dir = Directory(directory);
    if (!dir.existsSync()) return const [];
    final result = <BackupInfo>[];
    await for (final entry in dir.list()) {
      if (entry is! File || !entry.path.endsWith('.json')) continue;
      try {
        result.add(
          BackupInfo.fromJson(
            jsonDecode(await entry.readAsString()) as Map<String, dynamic>,
          ),
        );
      } on Object {
        _log.warning('Manifeste de sauvegarde illisible : ${entry.path}');
      }
    }
    return result..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<BackupInfo> start(AuthContext ctx) {
    ctx.require(Permission.backupManage);
    return run('manual');
  }

  /// Lance une sauvegarde (une seule à la fois).
  Future<BackupInfo> run(String trigger) {
    if (_running != null) {
      throw const ApiException.conflict('Une sauvegarde est déjà en cours.');
    }
    return _running = _run(trigger).whenComplete(() => _running = null);
  }

  Future<BackupInfo> _run(String trigger) async {
    final now = _clock();
    String two(int n) => n.toString().padLeft(2, '0');
    final name =
        'voyaj-${now.year}${two(now.month)}${two(now.day)}-'
        '${two(now.hour)}${two(now.minute)}${two(now.second)}';
    final dir = Directory(directory)..createSync(recursive: true);
    final dump = File(p.join(dir.path, '$name.dump'));
    try {
      final result = await Process.run(
        pgDump,
        [
          '--format=custom',
          '--no-owner',
          '--no-privileges',
          '--host=${_database.host}',
          '--port=${_database.port}',
          '--username=${_database.username}',
          '--file=${dump.path}',
          _database.database,
        ],
        environment: {
          if (_database.password != null) 'PGPASSWORD': _database.password!,
          if (_database.requireSsl) 'PGSSLMODE': 'require',
        },
      );
      if (result.exitCode != 0) {
        throw ApiException(
          500,
          'backup_failed',
          'pg_dump a échoué : ${'${result.stderr}'.trim().split('\n').first}',
        );
      }
    } on ProcessException {
      _lastError = 'pg_dump introuvable ($pgDump).';
      throw ApiException(500, 'backup_failed', _lastError!);
    } on ApiException catch (e) {
      _lastError = e.message;
      if (dump.existsSync()) dump.deleteSync();
      rethrow;
    }

    // Fichiers joints : copie des nouveaux seulement.
    var newFiles = 0;
    var totalFiles = 0;
    final source = Directory(p.join(_dataDir, 'files'));
    if (source.existsSync()) {
      await for (final entry in source.list(recursive: true)) {
        if (entry is! File || entry.path.endsWith('.tmp')) continue;
        totalFiles++;
        final target = File(
          p.join(dir.path, 'files', p.relative(entry.path, from: source.path)),
        );
        if (target.existsSync()) continue;
        await target.parent.create(recursive: true);
        await entry.copy(target.path);
        newFiles++;
      }
    }

    final info = BackupInfo(
      name: name,
      createdAt: now.toUtc(),
      trigger: trigger,
      databaseBytes: dump.lengthSync(),
      newFiles: newFiles,
      totalFiles: totalFiles,
      schemaVersion: migrations.last.version,
    );
    await File(
      p.join(dir.path, '$name.json'),
    ).writeAsString(const JsonEncoder.withIndent('  ').convert(info.toJson()));
    _lastError = null;
    await _prune();
    _log.info('Sauvegarde $name terminée (${info.databaseBytes} octets).');
    return info;
  }

  /// Supprime les sauvegardes de base plus anciennes que [keepDays] (la
  /// plus récente est toujours conservée).
  Future<void> _prune() async {
    final limit = _clock().toUtc().subtract(Duration(days: keepDays));
    final backups = await list();
    for (final backup in backups.skip(1)) {
      if (backup.createdAt.isAfter(limit)) continue;
      for (final ext in ['dump', 'json']) {
        final file = File(p.join(directory, '${backup.name}.$ext'));
        if (file.existsSync()) await file.delete();
      }
    }
  }

  /// Sauvegarde quotidienne si l'heure est venue et qu'aucune n'a été faite
  /// aujourd'hui.
  Future<void> runScheduledIfDue() async {
    final h = hour;
    final now = _clock();
    if (h == null || now.hour < h || _running != null) return;
    final today = DateTime(now.year, now.month, now.day);
    final done = (await list()).any(
      (b) => !b.createdAt.toLocal().isBefore(today),
    );
    if (done) return;
    try {
      await run('schedule');
    } on ApiException catch (e) {
      _log.severe('Sauvegarde planifiée : ${e.message}');
    }
  }
}
