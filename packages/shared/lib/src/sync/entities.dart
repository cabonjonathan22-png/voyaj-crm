import '../auth/permission.dart';
import '../models/tag.dart';
import 'entity_schema.dart';

/// Registre des entités synchronisées entre clients et serveur.
///
/// Ajouter une entité : définir son schéma ici, créer sa table (migration
/// serveur + table Drift client) avec les colonnes de [SyncColumns].
abstract final class SyncEntities {
  static final tags = EntitySchema(
    name: 'tags',
    fields: const {
      'name': FieldSpec(FieldType.text, nullable: false),
      'color': FieldSpec(FieldType.text, nullable: false),
      'description': FieldSpec(FieldType.text),
    },
    readPermission: Permission.tagRead,
    writePermission: Permission.tagWrite,
    validate: validateTagRecord,
  );

  static final List<EntitySchema> all = [tags];

  static final Map<String, EntitySchema> _byName = {
    for (final e in all) e.name: e,
  };

  static EntitySchema? byName(String name) => _byName[name];
}
