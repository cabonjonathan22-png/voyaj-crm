import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  group('EntitySchema', () {
    final tags = SyncEntities.tags;

    test('deleted_at est toujours synchronisable', () {
      expect(tags.fields.keys, contains('deleted_at'));
    });

    test('checkFields détecte champs inconnus, techniques et mal typés', () {
      final issues = tags.checkFields({
        'name': 42,
        'version': 3,
        'hack; DROP TABLE': 'x',
        'color': '#FFFFFF',
      });
      expect(issues.map((i) => i.code), [
        ValidationCodes.invalidType,
        ValidationCodes.readOnly,
        ValidationCodes.unknownField,
      ]);
    });

    test('nullable', () {
      expect(tags.checkFields({'description': null}), isEmpty);
      expect(tags.checkFields({'name': null}), hasLength(1));
      expect(tags.checkFields({'deleted_at': 'pas une date'}), hasLength(1));
    });

    test('refuse un identifiant SQL invalide', () {
      expect(
        () => EntitySchema(
          name: 'Tags',
          fields: const {},
          readPermission: Permission.tagRead,
          writePermission: Permission.tagWrite,
          validate: (_) => const [],
        ),
        throwsArgumentError,
      );
    });

    test('registre', () {
      expect(SyncEntities.byName('tags'), same(tags));
      expect(SyncEntities.byName('inconnu'), isNull);
    });
  });

  group('Validation des tags', () {
    test('tag valide', () {
      expect(
        validateTagRecord({'name': 'Prioritaire', 'color': '#EF4444'}),
        isEmpty,
      );
    });

    test('tag invalide', () {
      final issues = validateTagRecord({
        'name': '   ',
        'color': 'rouge',
        'description': 'x' * (tagDescriptionMaxLength + 1),
      });
      expect(issues.map((i) => i.field), ['name', 'color', 'description']);
    });

    test('un tag supprimé n’est pas revalidé', () {
      expect(
        SyncEntities.tags.validate({
          'name': '',
          'deleted_at': DateTime.utc(2026).toIso8601String(),
        }),
        isEmpty,
      );
    });

    test('mots de passe', () {
      expect(validatePassword('p', 'court'), isNotNull);
      expect(validatePassword('p', 'une phrase de passe'), isNull);
    });
  });

  group('Protocole JSON', () {
    test('SyncOperation aller-retour en snake_case', () {
      const op = SyncOperation(
        opId: 'op',
        entity: 'tags',
        entityId: 'id',
        baseVersion: 0,
        hlc: '000000000000001:0000:n',
        fields: {'name': 'A', 'description': null},
      );
      final json = op.toJson();
      expect(json.keys, containsAll(['op_id', 'entity_id', 'base_version']));
      expect(SyncOperation.fromJson(json), op);
    });

    test('unions avec discriminant `type`', () {
      const msg = ServerMessage.changes(cursor: 12);
      final json = msg.toJson();
      expect(json['type'], 'changes');
      expect(ServerMessage.fromJson(json), msg);
      expect(
        ServerMessage.fromJson(const {'type': 'session_revoked'}),
        isA<ServerSessionRevoked>(),
      );
    });

    test('LoginResponse mfa_required', () {
      final json = const LoginResponse.mfaRequired(mfaToken: 't').toJson();
      expect(json['status'], 'mfa_required');
      expect(LoginResponse.fromJson(json), isA<LoginMfaRequired>());
    });

    test('SyncRecord avec field_meta', () {
      const record = SyncRecord(
        entity: 'tags',
        id: 'x',
        version: 2,
        seq: 10,
        data: {'name': 'A'},
        fieldMeta: {'name': FieldStamp(hlc: 'h', version: 2, userId: 'u')},
      );
      final json = record.toJson();
      expect((json['field_meta'] as Map)['name'], {'h': 'h', 'v': 2, 'u': 'u'});
      expect(SyncRecord.fromJson(json), record);
    });

    test('identifiants UUID v7', () {
      final a = newId();
      expect(a, isNot(newId()));
      expect(isValidId(a), isTrue);
      expect(a[14], '7');
    });
  });
}
