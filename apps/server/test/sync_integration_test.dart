@Tags(['integration'])
library;

import 'dart:async';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:voyaj_server/voyaj_server.dart';
import 'package:voyaj_shared/voyaj_shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'support/test_server.dart';

void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  late TestServer server;

  setUpAll(() async => server = await TestServer.start());
  tearDownAll(() => server.close());

  group('Push', () {
    test('création puis renvoi idempotent', () async {
      final client = await server.admin();
      final id = newId();
      final op = client.op(id, {'name': 'Mairies', 'color': '#0EA5E9'});

      final first = (await client.push([op])).results.single;
      expect(first.status, OpStatus.applied);
      expect(first.record!.version, 1);
      expect(first.record!.data['name'], 'Mairies');
      expect(first.record!.data['created_by'], isNotNull);

      final replay = (await client.push([op])).results.single;
      expect(replay.status, OpStatus.duplicate);
      expect(replay.record!.version, 1);
    });

    test('données invalides refusées sans rien écrire', () async {
      final client = await server.admin();
      final id = newId();
      final results = (await client.push([
        client.op(id, {'name': '', 'color': '#0EA5E9'}),
        client.op(id, {'name': 'Ok', 'couleur': '#000000'}),
        client.op(id, {'name': 'Ok', 'color': '#000000', 'version': 9}),
      ])).results;
      expect(results.map((r) => r.status), everyElement(OpStatus.invalid));
      expect(results[0].issues.single.field, 'name');
      expect(results[1].issues.single.code, ValidationCodes.unknownField);
      expect(results[2].issues.single.code, ValidationCodes.readOnly);

      final pulled = await client.pull(0);
      expect(pulled.records.where((r) => r.id == id), isEmpty);
    });

    test('horloge du poste trop en avance refusée', () async {
      final client = await server.admin();
      final future = Hlc(
        DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch,
        0,
        client.deviceId,
      );
      final result = (await client.push([
        client.op(newId(), {'name': 'Futur', 'color': '#000000'}, hlc: future),
      ])).results.single;
      expect(result.status, OpStatus.invalid);
    });

    test('un lecteur ne peut pas écrire', () async {
      final reader = await server.userWithRoles('sync-lecteur@voyaj.test', [
        'lecture',
      ]);
      final result = (await reader.push([
        reader.op(newId(), {'name': 'Interdit', 'color': '#000000'}),
      ])).results.single;
      expect(result.status, OpStatus.forbidden);
    });

    test('le poste doit correspondre à la session', () async {
      final client = await server.admin();
      final response = await client.post(
        '/api/v1/sync/push',
        PushRequest(deviceId: newId(), operations: const []).toJson(),
      );
      expect(response.status, 400);
    });
  });

  group('Fusion et conflits', () {
    test(
      'champs différents modifiés hors ligne : fusion sans conflit',
      () async {
        final alice = await server.admin();
        final bob = await server.userWithRoles('bob@voyaj.test', [
          'commercial',
        ]);
        final id = newId();
        await alice.push([
          alice.op(id, {'name': 'Festivals', 'color': '#F59E0B'}),
        ]);

        // Les deux partent de la version 1, hors ligne.
        await alice.push([
          alice.op(id, {'name': 'Festivals 2026'}, baseVersion: 1),
        ]);
        final result = (await bob.push([
          bob.op(id, {'color': '#EF4444'}, baseVersion: 1),
        ])).results.single;

        expect(result.status, OpStatus.applied);
        expect(result.conflicts, 0);
        expect(result.record!.version, 3);
        expect(result.record!.data['name'], 'Festivals 2026');
        expect(result.record!.data['color'], '#EF4444');
      },
    );

    test(
      'même champ : la dernière écriture gagne, conflit journalisé',
      () async {
        final alice = await server.admin();
        final bob = await server.userWithRoles('bob2@voyaj.test', [
          'commercial',
        ]);
        final id = newId();
        await alice.push([
          alice.op(id, {'name': 'Base', 'color': '#000000'}),
        ]);

        final bobOp = bob.op(id, {'name': 'Version Bob'}, baseVersion: 1);
        // Alice écrit après Bob (HLC plus récent) mais synchronise avant.
        await Future<void>.delayed(const Duration(milliseconds: 5));
        await alice.push([
          alice.op(id, {'name': 'Version Alice'}, baseVersion: 1),
        ]);
        final result = (await bob.push([bobOp])).results.single;

        expect(result.status, OpStatus.superseded);
        expect(result.conflicts, 1);
        expect(result.record!.data['name'], 'Version Alice');

        final conflicts =
            (await alice.get('/api/v1/sync/conflicts?unreviewed=true')).list
                .map((c) => SyncConflict.fromJson(c as Map<String, dynamic>))
                .where((c) => c.entityId == id)
                .toList();
        expect(conflicts, hasLength(1));
        expect(conflicts.single.winningValue, 'Version Alice');
        expect(conflicts.single.losingValue, 'Version Bob');
        expect(conflicts.single.loserName, 'bob2');

        final review = await alice.post(
          '/api/v1/sync/conflicts/${conflicts.single.id}/review',
        );
        expect(review.status, 204);
        final remaining = (await alice.get(
          '/api/v1/sync/conflicts?unreviewed=true',
        )).list.where((c) => (c as Map)['entity_id'] == id);
        expect(remaining, isEmpty);
      },
    );

    test('suppression logique propagée', () async {
      final client = await server.admin();
      final id = newId();
      await client.push([
        client.op(id, {'name': 'À supprimer', 'color': '#000000'}),
      ]);
      final deletedAt = DateTime.now().toUtc().toIso8601String();
      final result = (await client.push([
        client.op(id, {'deleted_at': deletedAt}, baseVersion: 1),
      ])).results.single;
      expect(result.status, OpStatus.applied);
      expect(result.record!.data['deleted_at'], isNotNull);
    });
  });

  group('Pull', () {
    test('pagination par curseur, sans perte ni doublon', () async {
      final client = await server.admin();
      final start = (await client.pull(0)).cursor;
      final ids = [for (var i = 0; i < 7; i++) newId()];
      await client.push([
        for (final (i, id) in ids.indexed)
          client.op(id, {'name': 'Tag $i', 'color': '#000000'}),
      ]);

      final seen = <String>[];
      var cursor = start;
      var pages = 0;
      while (true) {
        final page = await client.pull(cursor, limit: 3);
        seen.addAll(page.records.map((r) => r.id));
        expect(page.cursor, greaterThanOrEqualTo(cursor));
        cursor = page.cursor;
        pages++;
        if (!page.hasMore) break;
      }
      expect(seen, ids);
      expect(pages, 3);
      expect((await client.pull(cursor)).records, isEmpty);
    });
  });

  group('Temps réel', () {
    test('notification des changements et révocation de session', () async {
      final client = await server.admin();
      final channel = WebSocketChannel.connect(server.wsUri());
      final messages = StreamController<ServerMessage>();
      channel.stream.listen(
        (data) => messages.add(
          ServerMessage.fromJson(
            jsonDecode(data as String) as Map<String, dynamic>,
          ),
        ),
        onDone: messages.close,
      );
      final queue = StreamIterator(messages.stream);

      channel.sink.add(
        jsonEncode(
          ClientMessage.auth(
            accessToken: client.tokens!.accessToken,
            protocolVersion: syncProtocolVersion,
          ).toJson(),
        ),
      );
      expect(await queue.moveNext(), isTrue);
      expect(queue.current, isA<ServerReady>());
      final readyCursor = (queue.current as ServerReady).cursor;

      await client.push([
        client.op(newId(), {'name': 'Temps réel', 'color': '#000000'}),
      ]);
      expect(await queue.moveNext(), isTrue);
      expect((queue.current as ServerChanges).cursor, greaterThan(readyCursor));

      await client.post('/api/v1/auth/logout');
      expect(await queue.moveNext(), isTrue);
      expect(queue.current, isA<ServerSessionRevoked>());
      expect(await queue.moveNext(), isFalse);
    });

    test('jeton invalide : erreur puis fermeture', () async {
      final channel = WebSocketChannel.connect(server.wsUri());
      channel.sink.add(
        jsonEncode(
          const ClientMessage.auth(
            accessToken: 'faux',
            protocolVersion: syncProtocolVersion,
          ).toJson(),
        ),
      );
      final messages = await channel.stream.toList();
      final error = ServerMessage.fromJson(
        jsonDecode(messages.single as String) as Map<String, dynamic>,
      );
      expect(error, isA<ServerError>());
    });
  });

  group('Audit', () {
    test('chaîne intègre et table en ajout seul', () async {
      final db = server.server.services.db;
      expect(await AuditLog.verifyChain(db), isNull);
      await expectLater(
        db.query("UPDATE audit_log SET action = 'falsifié'"),
        throwsA(anything),
      );
      await expectLater(db.query('DELETE FROM audit_log'), throwsA(anything));
    });

    test('consultation réservée', () async {
      final admin = await server.admin();
      final entries = (await admin.get('/api/v1/audit?limit=5')).list;
      expect(entries, hasLength(5));
      final reader = await server.userWithRoles('audit-lecteur@voyaj.test', [
        'lecture',
      ]);
      expect((await reader.get('/api/v1/audit')).status, 403);
    });
  });
}
