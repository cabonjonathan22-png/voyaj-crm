@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postgres/postgres.dart';
import 'package:voyaj_client/core/api_client.dart';
import 'package:voyaj_client/data/local/database.dart' hide Tags;
import 'package:voyaj_client/data/sync/local_clock.dart';
import 'package:voyaj_client/data/sync/sync_engine.dart';
import 'package:voyaj_client/features/tags/tags_repository.dart';
import 'package:voyaj_server/voyaj_server.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

/// Synchronisation de bout en bout : deux postes (bases locales en mémoire)
/// face à un vrai serveur et une vraie base PostgreSQL (`TEST_DATABASE_URL`,
/// lue dans l'environnement ou dans apps/server/.env). La base de test est
/// entièrement vidée.
void main() {
  final databaseUrl = _testDatabaseUrl();
  if (databaseUrl == null) {
    test('intégration', () {}, skip: 'TEST_DATABASE_URL non défini');
    return;
  }

  late VoyajServer server;
  late Uri baseUri;
  const password = 'mot de passe de test';

  setUpAll(() async {
    // Deux postes simulés = deux bases en mémoire distinctes (voulu).
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final config = ServerConfig.fromMap({
      'DATABASE_URL': databaseUrl,
      'VOYAJ_MASTER_KEY': base64.encode(List.filled(32, 7)),
      'VOYAJ_ARGON2_MEMORY_KIB': '1024',
      'VOYAJ_ARGON2_ITERATIONS': '1',
    });
    await _resetDatabase(config.database);
    server = await VoyajServer.start(
      ServerConfig(
        host: '127.0.0.1',
        port: 0,
        database: config.database,
        masterKey: config.masterKey,
        dbPoolSize: 4,
        argon2MemoryKib: 1024,
        argon2Iterations: 1,
      ),
    );
    baseUri = Uri.parse('http://127.0.0.1:${server.port}');
    await server.services.users.createAdmin(
      email: 'alice@voyaj.test',
      displayName: 'Alice',
      password: password,
    );
    await server.services.users.createAdmin(
      email: 'bob@voyaj.test',
      displayName: 'Bob',
      password: password,
    );
  });

  tearDownAll(() => server.close());

  Future<_Device> device(String email) async {
    final d = await _Device.create(baseUri);
    await d.login(email, password);
    return d;
  }

  test('création hors ligne puis propagation à un autre poste', () async {
    final alice = await device('alice@voyaj.test');
    final bob = await device('bob@voyaj.test');
    addTearDown(alice.close);
    addTearDown(bob.close);

    // Hors ligne : écriture locale uniquement.
    final id = await alice.tags.create((
      name: 'Prioritaire',
      color: '#EF4444',
      description: 'À contacter',
    ));
    expect(await alice.pendingCount(), 1);
    expect(await bob.tag(id), isNull);

    await alice.sync();
    expect(await alice.pendingCount(), 0);
    expect((await alice.tag(id))!.version, 1);

    await bob.sync();
    final received = (await bob.tag(id))!;
    expect(received.name, 'Prioritaire');
    expect(received.description, 'À contacter');
    expect(received.version, 1);
  });

  test('champs différents modifiés sur deux postes : fusion', () async {
    final alice = await device('alice@voyaj.test');
    final bob = await device('bob@voyaj.test');
    addTearDown(alice.close);
    addTearDown(bob.close);

    final id = await alice.tags.create((
      name: 'Festivals',
      color: '#F59E0B',
      description: null,
    ));
    await alice.sync();
    await bob.sync();

    await alice.tags.update(id, (
      name: 'Festivals 2026',
      color: '#F59E0B',
      description: null,
    ));
    await bob.tags.update(id, (
      name: 'Festivals',
      color: '#10B981',
      description: 'Été',
    ));
    await alice.sync();
    await bob.sync();
    await alice.sync();

    for (final d in [alice, bob]) {
      final tag = (await d.tag(id))!;
      expect(tag.name, 'Festivals 2026');
      expect(tag.color, '#10B981');
      expect(tag.description, 'Été');
    }
  });

  test('même champ modifié sur deux postes : la dernière écriture gagne '
      'partout et le conflit est journalisé', () async {
    final alice = await device('alice@voyaj.test');
    final bob = await device('bob@voyaj.test');
    addTearDown(alice.close);
    addTearDown(bob.close);

    final id = await alice.tags.create((
      name: 'Base',
      color: '#000000',
      description: null,
    ));
    await alice.sync();
    await bob.sync();

    await alice.tags.update(id, (
      name: 'Version Alice',
      color: '#000000',
      description: null,
    ));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await bob.tags.update(id, (
      name: 'Version Bob',
      color: '#000000',
      description: null,
    ));
    // Bob synchronise en premier mais son écriture est la plus récente.
    await bob.sync();
    await alice.sync();
    await bob.sync();

    expect((await alice.tag(id))!.name, 'Version Bob');
    expect((await bob.tag(id))!.name, 'Version Bob');

    final conflicts = await alice.api.get('/api/v1/sync/conflicts');
    final forTag = [
      for (final c in conflicts! as List<dynamic>)
        if ((c as Map)['entity_id'] == id) SyncConflict.fromJson(c.cast()),
    ];
    expect(forTag, hasLength(1));
    expect(forTag.single.winningValue, 'Version Bob');
    expect(forTag.single.losingValue, 'Version Alice');
  });

  test('suppression propagée', () async {
    final alice = await device('alice@voyaj.test');
    final bob = await device('bob@voyaj.test');
    addTearDown(alice.close);
    addTearDown(bob.close);

    final id = await alice.tags.create((
      name: 'Éphémère',
      color: '#000000',
      description: null,
    ));
    await alice.sync();
    await bob.sync();
    expect((await bob.tags.watchAll().first).map((t) => t.id), contains(id));

    await bob.tags.delete([id]);
    await bob.sync();
    await alice.sync();
    expect(
      (await alice.tags.watchAll().first).map((t) => t.id),
      isNot(contains(id)),
    );
    expect((await alice.tag(id))!.deletedAt, isNotNull);
  });

  test('une saisie locale non envoyée survit à la réception des changements '
      'des autres', () async {
    final alice = await device('alice@voyaj.test');
    final bob = await device('bob@voyaj.test');
    addTearDown(alice.close);
    addTearDown(bob.close);

    final id = await alice.tags.create((
      name: 'Partagé',
      color: '#000000',
      description: null,
    ));
    await alice.sync();
    await bob.sync();

    // Bob modifie la couleur hors ligne ; Alice modifie le nom et envoie.
    await bob.tags.update(id, (
      name: 'Partagé',
      color: '#6366F1',
      description: null,
    ));
    await alice.tags.update(id, (
      name: 'Renommé',
      color: '#000000',
      description: null,
    ));
    await alice.sync();

    // Bob reçoit le nouveau nom sans perdre sa couleur (pas encore envoyée).
    await bob.pullOnly();
    final local = (await bob.tag(id))!;
    expect(local.name, 'Renommé');
    expect(local.color, '#6366F1');
    expect(await bob.pendingCount(), 1);
  });

  test(
    'opération refusée : erreur visible et création locale retirée',
    () async {
      final alice = await device('alice@voyaj.test');
      addTearDown(alice.close);

      // Opération invalide écrite directement (contournement de la
      // validation locale, ex. ancienne version de l'application).
      final id = newId();
      final now = DateTime.now().toUtc();
      await alice.db
          .into(alice.db.tags)
          .insert(
            TagsCompanion.insert(
              id: id,
              name: '',
              color: 'rouge',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await enqueueOperation(
        alice.db,
        entity: 'tags',
        entityId: id,
        baseVersion: 0,
        hlc: await alice.clock.tick(),
        fields: {'name': '', 'color': 'rouge'},
      );
      await alice.sync();

      expect(await alice.tag(id), isNull);
      expect(await alice.pendingCount(), 0);
      final errors = await alice.db.watchSyncErrors().first;
      expect(errors.single.entityId, id);
      expect(errors.single.message, contains('obligatoire'));
    },
  );

  test(
    'temps réel : un poste connecté reçoit les changements sans action',
    () async {
      final alice = await device('alice@voyaj.test');
      final bob = await device('bob@voyaj.test');
      addTearDown(alice.close);
      addTearDown(bob.close);

      bob.engine.start();
      await _waitFor(
        () async => bob.engine.status.connection == SyncConnection.online,
      );

      final id = await alice.tags.create((
        name: 'Instantané',
        color: '#000000',
        description: null,
      ));
      await alice.sync();

      await _waitFor(() async => await bob.tag(id) != null);
      expect((await bob.tag(id))!.name, 'Instantané');
    },
  );
}

/// Un poste client : base locale, horloge, API, moteur de synchro.
final class _Device {
  _Device._(this.db, this.clock, this.api, this.engine, this.tags);

  static Future<_Device> create(Uri baseUri) async {
    final db = AppDatabase(NativeDatabase.memory());
    final clock = await LocalClock.load(db);
    AuthTokens? tokens;
    final api = ApiClient(
      baseUri: baseUri,
      loadTokens: () async => tokens,
      saveTokens: (t) async => tokens = t,
      onSessionLost: (_) {},
    );
    final engine = SyncEngine(
      db: db,
      api: api,
      clock: clock,
      onSessionLost: () {},
    );
    final device = _Device._(
      db,
      clock,
      api,
      engine,
      TagsRepository(
        db: db,
        clock: clock,
        currentUserId: null,
        onChanged: () {},
      ),
    );
    device._setTokens = (t) => tokens = t;
    return device;
  }

  final AppDatabase db;
  final LocalClock clock;
  final ApiClient api;
  final SyncEngine engine;
  final TagsRepository tags;
  late void Function(AuthTokens) _setTokens;

  Future<void> login(String email, String password) async {
    final json = await api.sendAnonymous(
      'POST',
      '/api/v1/auth/login',
      body: LoginRequest(
        email: email,
        password: password,
        device: DeviceInfo(
          id: clock.deviceId,
          name: 'Poste de test',
          platform: 'test',
          appVersion: '0',
        ),
      ).toJson(),
    );
    final response = LoginResponse.fromJson(json! as Map<String, dynamic>);
    _setTokens((response as LoginAuthenticated).tokens);
  }

  /// Synchronisation complète (push puis pull), comme le fait l'application.
  Future<void> sync() async {
    engine.start();
    await engine.syncNow();
    await engine.stop();
  }

  Future<void> pullOnly() => engine.pull();

  Future<int> pendingCount() => db.watchPendingCount().first;

  Future<TagRow?> tag(String id) =>
      (db.select(db.tags)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> close() async {
    await engine.dispose();
    api.close();
    await db.close();
  }
}

Future<void> _waitFor(Future<bool> Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 15));
  while (!await condition()) {
    if (DateTime.now().isAfter(deadline)) fail('Délai dépassé');
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

String? _testDatabaseUrl() {
  final fromEnv = Platform.environment['TEST_DATABASE_URL'];
  if (fromEnv != null && fromEnv.isNotEmpty) return fromEnv;
  final file = File('../server/.env');
  if (!file.existsSync()) return null;
  return parseDotEnv(file.readAsStringSync())['TEST_DATABASE_URL'];
}

Future<void> _resetDatabase(DatabaseConfig db) async {
  final conn = await Connection.open(
    Endpoint(
      host: db.host,
      port: db.port,
      database: db.database,
      username: db.username,
      password: db.password,
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );
  try {
    await conn.execute(
      'DROP SCHEMA public CASCADE; CREATE SCHEMA public;',
      queryMode: QueryMode.simple,
    );
  } finally {
    await conn.close();
  }
}
