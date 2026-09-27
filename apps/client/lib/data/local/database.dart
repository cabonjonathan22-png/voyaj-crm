import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// ── Entités synchronisées ────────────────────────────────────────────────
// Colonnes communes : id, version (dernière version serveur connue, 0 si
// jamais synchronisé), field_meta (JSON), created_*, updated_*, deleted_at.

@DataClassName('TagRow')
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get color => text()();
  TextColumn get description => text().nullable()();
  IntColumn get version => integer().withDefault(const Constant(0))();
  TextColumn get fieldMeta => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

// ── Infrastructure de synchronisation ───────────────────────────────────

/// Opérations locales en attente d'envoi au serveur (dans l'ordre).
@DataClassName('OutboxRow')
class Outbox extends Table {
  IntColumn get seq => integer().autoIncrement()();
  TextColumn get opId => text().unique()();
  TextColumn get entity => text()();
  TextColumn get entityId => text()();
  IntColumn get baseVersion => integer()();
  TextColumn get hlc => text()();

  /// Champs modifiés (JSON).
  TextColumn get fields => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}

/// Opérations refusées par le serveur (visibles dans l'écran Synchronisation).
@DataClassName('SyncErrorRow')
class SyncErrors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get opId => text()();
  TextColumn get entity => text()();
  TextColumn get entityId => text()();
  TextColumn get fields => text()();
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Paramètres locaux (clé → valeur JSON).
@DataClassName('KeyValueRow')
class KeyValues extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(tables: [Tags, Outbox, SyncErrors, KeyValues])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// Ouvre la base chiffrée du poste ([encryptionKey] : 64 caractères hex).
  factory AppDatabase.open({required String encryptionKey}) {
    if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(encryptionKey)) {
      throw ArgumentError('Clé de chiffrement invalide');
    }
    return AppDatabase(
      driftDatabase(
        name: 'voyaj',
        native: DriftNativeOptions(
          databaseDirectory: getApplicationSupportDirectory,
          setup: (db) {
            // SQLite3 Multiple Ciphers : la clé doit être posée avant toute
            // lecture (256 bits aléatoires, conservés dans le coffre de l'OS).
            db.execute("PRAGMA key = '$encryptionKey';");
            db.execute('PRAGMA foreign_keys = ON;');
          },
        ),
      ),
    );
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    beforeOpen: (details) async {
      // Vérifie que la clé est correcte (lecture effective de la base).
      await customSelect('SELECT count(*) FROM sqlite_master').get();
    },
  );

  // ── Paramètres ────────────────────────────────────────────────────────

  Future<T?> readSetting<T>(String key) async {
    final row = await (select(
      keyValues,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row == null ? null : jsonDecode(row.value) as T?;
  }

  Future<void> writeSetting(String key, Object? value) =>
      into(keyValues).insertOnConflictUpdate(
        KeyValuesCompanion.insert(key: key, value: jsonEncode(value)),
      );

  Future<void> deleteSetting(String key) =>
      (delete(keyValues)..where((t) => t.key.equals(key))).go();

  Stream<T?> watchSetting<T>(String key) =>
      (select(keyValues)..where((t) => t.key.equals(key)))
          .watchSingleOrNull()
          .map((row) => row == null ? null : jsonDecode(row.value) as T?);

  // ── Outbox ────────────────────────────────────────────────────────────

  Stream<int> watchPendingCount() {
    final count = outbox.seq.count();
    return (selectOnly(
      outbox,
    )..addColumns([count])).map((row) => row.read(count) ?? 0).watchSingle();
  }

  /// Identifiants des enregistrements de [entity] modifiés localement et
  /// pas encore envoyés.
  Stream<Set<String>> watchPendingIds(String entity) =>
      (selectOnly(outbox, distinct: true)
            ..addColumns([outbox.entityId])
            ..where(outbox.entity.equals(entity)))
          .map((row) => row.read(outbox.entityId)!)
          .watch()
          .map((ids) => ids.toSet());

  Future<List<OutboxRow>> pendingOperations({int limit = 200}) =>
      (select(outbox)
            ..orderBy([(t) => OrderingTerm.asc(t.seq)])
            ..limit(limit))
          .get();

  /// Champs en attente d'envoi pour un enregistrement (fusionnés dans
  /// l'ordre des opérations).
  Future<Map<String, Object?>> pendingFieldsFor(
    String entity,
    String entityId,
  ) async {
    final rows =
        await (select(outbox)
              ..where(
                (t) => t.entity.equals(entity) & t.entityId.equals(entityId),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.seq)]))
            .get();
    return {
      for (final row in rows)
        ...(jsonDecode(row.fields) as Map<String, dynamic>),
    };
  }

  /// Efface toutes les données synchronisées (changement d'utilisateur).
  Future<void> wipeSyncedData() => transaction(() async {
    await delete(tags).go();
    await delete(outbox).go();
    await delete(syncErrors).go();
    await deleteSetting(SettingKeys.syncCursor);
  });
}

/// Clés des paramètres locaux.
abstract final class SettingKeys {
  static const serverUrl = 'server_url';
  static const deviceId = 'device_id';
  static const hlc = 'hlc';
  static const syncCursor = 'sync_cursor';
  static const lastSyncAt = 'last_sync_at';
  static const currentUser = 'current_user';
  static const lastUserId = 'last_user_id';
  static const themeMode = 'theme_mode';
  static const sidebarCollapsed = 'sidebar_collapsed';
  static String tableView(String table) => 'table_view.$table';
  static String savedViews(String table) => 'saved_views.$table';
}
