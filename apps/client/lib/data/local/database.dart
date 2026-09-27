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

/// Colonnes techniques des entités synchronisées (hors `id`).
mixin SyncedColumns on Table {
  IntColumn get version => integer().withDefault(const Constant(0))();
  TextColumn get fieldMeta => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

/// Traçabilité des données importées (RGPD).
mixin ProvenanceColumns on Table {
  TextColumn get source => text().nullable()();
  TextColumn get sourceRef => text().nullable()();
  DateTimeColumn get collectedAt => dateTime().nullable()();
}

// Les dates calendaires (`AAAA-MM-JJ`) sont stockées en texte et les
// champs JSON en texte JSON.

@DataClassName('OrganisationRow')
@TableIndex(name: 'organisations_parent', columns: {#parentId})
class Organisations extends Table with SyncedColumns, ProvenanceColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get kind => text()();
  TextColumn get status => text()();
  TextColumn get siren => text().nullable()();
  TextColumn get siret => text().nullable()();
  TextColumn get inseeCode => text().nullable()();
  IntColumn get population => integer().nullable()();
  TextColumn get parentId => text().nullable()();
  TextColumn get departementCode => text().nullable()();
  TextColumn get regionCode => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get city => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get ownerId => text().nullable()();
  TextColumn get customFields => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ContactRow')
@TableIndex(name: 'contacts_organisation', columns: {#organisationId})
class Contacts extends Table with SyncedColumns, ProvenanceColumns {
  TextColumn get id => text()();
  TextColumn get civility => text().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get mobile => text().nullable()();
  TextColumn get organisationId => text().nullable()();
  TextColumn get jobTitle => text().nullable()();
  TextColumn get service => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get doNotContact => boolean().nullable()();
  TextColumn get ownerId => text().nullable()();
  TextColumn get customFields => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PositionRow')
@TableIndex(name: 'positions_contact', columns: {#contactId})
@TableIndex(name: 'positions_organisation', columns: {#organisationId})
class Positions extends Table with SyncedColumns, ProvenanceColumns {
  TextColumn get id => text()();
  TextColumn get contactId => text()();
  TextColumn get organisationId => text()();
  TextColumn get jobTitle => text().nullable()();
  TextColumn get service => text().nullable()();
  BoolColumn get isElected => boolean()();
  TextColumn get mandateRole => text().nullable()();
  TextColumn get delegation => text().nullable()();
  TextColumn get startDate => text().nullable()();
  TextColumn get endDate => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PipelineRow')
class Pipelines extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get kind => text()();
  RealColumn get sortOrder => real().nullable()();
  BoolColumn get archived => boolean().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('StageRow')
class PipelineStages extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get pipelineId => text()();
  TextColumn get name => text()();
  RealColumn get sortOrder => real().nullable()();
  IntColumn get probability => integer().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get outcome => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DealRow')
@TableIndex(name: 'deals_organisation', columns: {#organisationId})
class Deals extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get pipelineId => text()();
  TextColumn get stageId => text()();
  TextColumn get organisationId => text().nullable()();
  TextColumn get contactId => text().nullable()();
  IntColumn get amountCents => integer().nullable()();
  IntColumn get probability => integer().nullable()();
  TextColumn get expectedCloseDate => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  RealColumn get sortOrder => real().nullable()();
  TextColumn get ownerId => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get customFields => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ActivityRow')
@TableIndex(name: 'activities_organisation', columns: {#organisationId})
@TableIndex(name: 'activities_contact', columns: {#contactId})
class Activities extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get kind => text()();
  TextColumn get subject => text()();
  TextColumn get body => text().nullable()();
  TextColumn get organisationId => text().nullable()();
  TextColumn get contactId => text().nullable()();
  TextColumn get dealId => text().nullable()();
  DateTimeColumn get startsAt => dateTime().nullable()();
  DateTimeColumn get endsAt => dateTime().nullable()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  DateTimeColumn get remindAt => dateTime().nullable()();
  DateTimeColumn get doneAt => dateTime().nullable()();
  TextColumn get assigneeId => text().nullable()();
  TextColumn get ownerId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('AttachmentRow')
class Attachments extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get fileId => text()();
  TextColumn get fileName => text()();
  IntColumn get size => integer()();
  TextColumn get mimeType => text().nullable()();
  TextColumn get organisationId => text().nullable()();
  TextColumn get contactId => text().nullable()();
  TextColumn get dealId => text().nullable()();
  TextColumn get activityId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('TaggingRow')
@TableIndex(name: 'taggings_record', columns: {#recordId})
class Taggings extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get tagId => text()();
  TextColumn get entity => text()();
  TextColumn get recordId => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CustomFieldRow')
class CustomFields extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get entity => text()();
  TextColumn get key => text()();
  TextColumn get label => text()();
  TextColumn get type => text()();
  TextColumn get options => text().nullable()();
  RealColumn get sortOrder => real().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SegmentRow')
class Segments extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get entity => text()();
  TextColumn get description => text().nullable()();
  TextColumn get config => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('EmailTemplateRow')
class EmailTemplates extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get subject => text()();
  TextColumn get body => text()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('EmailSequenceRow')
class EmailSequences extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get steps => text()();
  BoolColumn get active => boolean().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('EnrollmentRow')
class SequenceEnrollments extends Table with SyncedColumns {
  TextColumn get id => text()();
  TextColumn get sequenceId => text()();
  TextColumn get contactId => text()();
  TextColumn get ownerId => text()();
  IntColumn get step => integer()();
  DateTimeColumn get nextSendAt => dateTime().nullable()();
  TextColumn get status => text()();
  TextColumn get lastError => text().nullable()();

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

@DriftDatabase(
  tables: [
    Tags,
    Organisations,
    Contacts,
    Positions,
    Pipelines,
    PipelineStages,
    Deals,
    Activities,
    Attachments,
    Taggings,
    CustomFields,
    Segments,
    EmailTemplates,
    EmailSequences,
    SequenceEnrollments,
    Outbox,
    SyncErrors,
    KeyValues,
  ],
)
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
  int get schemaVersion => 3;

  /// Tables des entités synchronisées (même nom que l'entité).
  List<TableInfo<Table, Object?>> get syncedTables => [
    tags,
    organisations,
    contacts,
    positions,
    pipelines,
    pipelineStages,
    deals,
    activities,
    attachments,
    taggings,
    customFields,
    segments,
    emailTemplates,
    emailSequences,
    sequenceEnrollments,
  ];

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Chaque version ajoute des entités synchronisées : le curseur est
      // remis à zéro pour recevoir celles déjà présentes sur le serveur
      // (ignorées par l'ancienne version).
      if (from < 2) {
        for (final table in <TableInfo<Table, Object?>>[
          organisations,
          contacts,
          positions,
          pipelines,
          pipelineStages,
          deals,
          activities,
          attachments,
          taggings,
          customFields,
          segments,
        ]) {
          await m.createTable(table);
        }
        for (final index in allSchemaEntities.whereType<Index>()) {
          await m.createIndex(index);
        }
      }
      if (from < 3) {
        await m.createTable(emailTemplates);
        await m.createTable(emailSequences);
        await m.createTable(sequenceEnrollments);
      }
      await deleteSetting(SettingKeys.syncCursor);
    },
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
    for (final table in syncedTables) {
      await delete(table).go();
    }
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

  /// Serveur d'origine des données locales.
  static const dataServerUrl = 'data_server_url';
  static const themeMode = 'theme_mode';
  static const sidebarCollapsed = 'sidebar_collapsed';
  static const workTabs = 'work_tabs';
  static const lastPipeline = 'last_pipeline';
  static const ignoredDuplicates = 'ignored_duplicates';
  static const notifiedReminders = 'notified_reminders';
  static String tableView(String table) => 'table_view.$table';
  static String savedViews(String table) => 'saved_views.$table';
}
