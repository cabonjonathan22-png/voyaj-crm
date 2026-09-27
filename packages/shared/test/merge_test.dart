import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  const alice = 'alice';
  const bob = 'bob';

  FieldStamp stamp(Hlc hlc, int version, String user) =>
      FieldStamp(hlc: hlc.toString(), version: version, userId: user);

  group('mergeFields', () {
    test('création : tous les champs sont appliqués', () {
      final result = mergeFields(
        current: const {},
        stamps: const {},
        incoming: const {'name': 'Mairie', 'color': '#000000'},
        hlc: const Hlc(10, 0, 'a'),
        baseVersion: 0,
        nextVersion: 1,
        userId: alice,
      );
      expect(result.applied, {'name': 'Mairie', 'color': '#000000'});
      expect(result.stamps['name']!.version, 1);
      expect(result.stamps['name']!.userId, alice);
      expect(result.conflicts, isEmpty);
    });

    test('mise à jour séquentielle : pas de conflit', () {
      final result = mergeFields(
        current: const {'name': 'A'},
        stamps: {'name': stamp(const Hlc(10, 0, 'a'), 1, alice)},
        incoming: const {'name': 'B'},
        hlc: const Hlc(20, 0, 'b'),
        baseVersion: 1,
        nextVersion: 2,
        userId: bob,
      );
      expect(result.applied, {'name': 'B'});
      expect(result.conflicts, isEmpty);
    });

    test('écritures concurrentes sur des champs différents : fusion', () {
      // Alice a modifié `name` (v2) ; Bob, basé sur v1, modifie `color`.
      final result = mergeFields(
        current: const {'name': 'A2', 'color': '#111111'},
        stamps: {
          'name': stamp(const Hlc(20, 0, 'a'), 2, alice),
          'color': stamp(const Hlc(10, 0, 'a'), 1, alice),
        },
        incoming: const {'color': '#222222'},
        hlc: const Hlc(15, 0, 'b'),
        baseVersion: 1,
        nextVersion: 3,
        userId: bob,
      );
      expect(result.applied, {'color': '#222222'});
      expect(result.conflicts, isEmpty);
      expect(result.stamps['name']!.version, 2);
    });

    test('même champ, entrant plus récent : appliqué + conflit journalisé', () {
      final result = mergeFields(
        current: const {'name': 'Alice'},
        stamps: {'name': stamp(const Hlc(20, 0, 'a'), 2, alice)},
        incoming: const {'name': 'Bob'},
        hlc: const Hlc(30, 0, 'b'),
        baseVersion: 1,
        nextVersion: 3,
        userId: bob,
      );
      expect(result.applied, {'name': 'Bob'});
      expect(result.conflicts, hasLength(1));
      final c = result.conflicts.single;
      expect(c.incomingWon, isTrue);
      expect(c.winningValue, 'Bob');
      expect(c.losingValue, 'Alice');
      expect(c.loserUserId, alice);
    });

    test('même champ, entrant plus ancien : rejeté + conflit journalisé', () {
      final result = mergeFields(
        current: const {'name': 'Alice'},
        stamps: {'name': stamp(const Hlc(30, 0, 'a'), 2, alice)},
        incoming: const {'name': 'Bob'},
        hlc: const Hlc(20, 0, 'b'),
        baseVersion: 1,
        nextVersion: 3,
        userId: bob,
      );
      expect(result.applied, isEmpty);
      expect(result.changed, isFalse);
      expect(result.rejectedFields, ['name']);
      expect(result.conflicts.single.incomingWon, isFalse);
      expect(result.conflicts.single.winningValue, 'Alice');
    });

    test('valeur identique : ni modification ni conflit', () {
      final result = mergeFields(
        current: const {'name': 'Même'},
        stamps: {'name': stamp(const Hlc(30, 0, 'a'), 2, alice)},
        incoming: const {'name': 'Même'},
        hlc: const Hlc(20, 0, 'b'),
        baseVersion: 1,
        nextVersion: 3,
        userId: bob,
      );
      expect(result.applied, isEmpty);
      expect(result.conflicts, isEmpty);
    });

    test('suppression contre modification : la plus récente gagne', () {
      final deletedAt = DateTime.utc(2026).toIso8601String();
      final result = mergeFields(
        current: const {'name': 'A', 'deleted_at': null},
        stamps: {'name': stamp(const Hlc(40, 0, 'a'), 2, alice)},
        incoming: {'deleted_at': deletedAt},
        hlc: const Hlc(30, 0, 'b'),
        baseVersion: 1,
        nextVersion: 3,
        userId: bob,
      );
      // `deleted_at` n'avait jamais été écrit : la suppression s'applique.
      expect(result.applied, {'deleted_at': deletedAt});
    });

    test('les valeurs JSON sont comparées en profondeur', () {
      final result = mergeFields(
        current: const {
          'meta': {
            'a': [1, 2],
          },
        },
        stamps: {'meta': stamp(const Hlc(10, 0, 'a'), 1, alice)},
        incoming: const {
          'meta': {
            'a': [1, 2],
          },
        },
        hlc: const Hlc(20, 0, 'b'),
        baseVersion: 0,
        nextVersion: 2,
        userId: bob,
      );
      expect(result.applied, isEmpty);
      expect(result.conflicts, isEmpty);
    });
  });
}
