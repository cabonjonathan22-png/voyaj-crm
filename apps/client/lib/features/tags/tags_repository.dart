import 'package:drift/drift.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../data/local/database.dart';
import '../../data/sync/local_clock.dart';
import '../../data/sync/sync_engine.dart';

/// Données saisies pour un tag.
typedef TagDraft = ({String name, String color, String? description});

/// Accès aux tags : lectures locales réactives, écritures locales + outbox.
final class TagsRepository {
  TagsRepository({
    required this.db,
    required this.clock,
    required this.currentUserId,
    required this.onChanged,
  });

  final AppDatabase db;
  final LocalClock clock;
  final String? currentUserId;

  /// Appelé après chaque écriture (déclenche la synchronisation).
  final void Function() onChanged;

  static final _entity = SyncEntities.tags;

  Stream<List<Tag>> watchAll() =>
      (db.select(db.tags)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.name.lower())]))
          .watch()
          .map((rows) => rows.map(_toTag).toList());

  /// Valide un brouillon avec les règles partagées client/serveur.
  List<ValidationIssue> validate(TagDraft draft) => validateTagRecord({
    'name': draft.name.trim(),
    'color': draft.color,
    'description': _clean(draft.description),
  });

  Future<String> create(TagDraft draft) async {
    _ensureValid(draft);
    final id = newId();
    final now = DateTime.now().toUtc();
    final fields = {
      'name': draft.name.trim(),
      'color': draft.color,
      'description': _clean(draft.description),
    };
    await db.transaction(() async {
      await db
          .into(db.tags)
          .insert(
            TagsCompanion.insert(
              id: id,
              name: fields['name']!,
              color: draft.color,
              description: Value(fields['description']),
              createdAt: now,
              createdBy: Value(currentUserId),
              updatedAt: now,
              updatedBy: Value(currentUserId),
            ),
          );
      await enqueueOperation(
        db,
        entity: _entity.name,
        entityId: id,
        baseVersion: 0,
        hlc: await clock.tick(),
        fields: fields,
      );
    });
    onChanged();
    return id;
  }

  /// Enregistre uniquement les champs réellement modifiés.
  Future<void> update(String id, TagDraft draft) async {
    _ensureValid(draft);
    await db.transaction(() async {
      final row = await _get(id);
      final changes = <String, Object?>{
        if (row.name != draft.name.trim()) 'name': draft.name.trim(),
        if (row.color != draft.color) 'color': draft.color,
        if (row.description != _clean(draft.description))
          'description': _clean(draft.description),
      };
      if (changes.isEmpty) return;
      await (db.update(db.tags)..where((t) => t.id.equals(id))).write(
        TagsCompanion(
          name: Value(draft.name.trim()),
          color: Value(draft.color),
          description: Value(_clean(draft.description)),
          updatedAt: Value(DateTime.now().toUtc()),
          updatedBy: Value(currentUserId),
        ),
      );
      await enqueueOperation(
        db,
        entity: _entity.name,
        entityId: id,
        baseVersion: row.version,
        hlc: await clock.tick(),
        fields: changes,
      );
    });
    onChanged();
  }

  /// Suppression logique (synchronisée).
  Future<void> delete(Iterable<String> ids) async {
    final now = DateTime.now().toUtc();
    await db.transaction(() async {
      for (final id in ids) {
        final row = await _get(id);
        await (db.update(db.tags)..where((t) => t.id.equals(id))).write(
          TagsCompanion(
            deletedAt: Value(now),
            updatedAt: Value(now),
            updatedBy: Value(currentUserId),
          ),
        );
        await enqueueOperation(
          db,
          entity: _entity.name,
          entityId: id,
          baseVersion: row.version,
          hlc: await clock.tick(),
          fields: {'deleted_at': now.toIso8601String()},
        );
      }
    });
    onChanged();
  }

  Future<TagRow> _get(String id) =>
      (db.select(db.tags)..where((t) => t.id.equals(id))).getSingle();

  void _ensureValid(TagDraft draft) {
    final issues = validate(draft);
    if (issues.isNotEmpty) throw TagValidationException(issues);
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  static Tag _toTag(TagRow row) => Tag(
    id: row.id,
    name: row.name,
    color: row.color,
    description: row.description,
    version: row.version,
    createdAt: row.createdAt,
    createdBy: row.createdBy,
    updatedAt: row.updatedAt,
    updatedBy: row.updatedBy,
    deletedAt: row.deletedAt,
  );
}

final class TagValidationException implements Exception {
  const TagValidationException(this.issues);

  final List<ValidationIssue> issues;

  @override
  String toString() => issues.map((i) => i.message).join(' ');
}
