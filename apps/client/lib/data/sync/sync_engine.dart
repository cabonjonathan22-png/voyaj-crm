import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:voyaj_shared/voyaj_shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/api_client.dart';
import '../local/database.dart';
import 'local_clock.dart';
import 'local_entities.dart';

enum SyncConnection { offline, connecting, online }

/// État de la synchronisation (affiché dans la barre d'état).
@immutable
final class SyncStatus {
  const SyncStatus({
    this.connection = SyncConnection.offline,
    this.syncing = false,
    this.lastSyncAt,
    this.lastError,
  });

  final SyncConnection connection;
  final bool syncing;
  final DateTime? lastSyncAt;
  final String? lastError;

  SyncStatus copyWith({
    SyncConnection? connection,
    bool? syncing,
    DateTime? lastSyncAt,
    String? Function()? lastError,
  }) => SyncStatus(
    connection: connection ?? this.connection,
    syncing: syncing ?? this.syncing,
    lastSyncAt: lastSyncAt ?? this.lastSyncAt,
    lastError: lastError != null ? lastError() : this.lastError,
  );
}

/// Moteur de synchronisation client.
///
/// - Les écritures locales vont dans la base + l'outbox (même transaction) :
///   l'application fonctionne entièrement hors ligne.
/// - [syncNow] envoie l'outbox (push) puis récupère les changements (pull).
/// - Le WebSocket signale les changements des autres postes en temps réel ;
///   reconnexion automatique avec délai croissant.
final class SyncEngine {
  SyncEngine({
    required this.db,
    required this.api,
    required this.clock,
    required this.onSessionLost,
  });

  final AppDatabase db;
  final ApiClient api;
  final LocalClock clock;
  final void Function() onSessionLost;

  final _status = StreamController<SyncStatus>.broadcast();
  SyncStatus _current = const SyncStatus();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _channelSub;
  Timer? _reconnectTimer;
  Timer? _debounce;
  Timer? _periodic;
  int _reconnectAttempt = 0;
  bool _running = false;
  Future<void>? _syncing;
  bool _syncAgain = false;

  SyncStatus get status => _current;
  Stream<SyncStatus> get statusStream => _status.stream;

  void _emit(SyncStatus status) {
    _current = status;
    if (!_status.isClosed) _status.add(status);
  }

  /// Démarre la synchronisation (après connexion).
  void start() {
    if (_running) return;
    _running = true;
    unawaited(_connect());
    _periodic = Timer.periodic(
      const Duration(minutes: 1),
      (_) => unawaited(syncNow()),
    );
  }

  /// Arrête la synchronisation (déconnexion, changement de serveur).
  Future<void> stop() async {
    _running = false;
    _periodic?.cancel();
    _reconnectTimer?.cancel();
    _debounce?.cancel();
    await _channelSub?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _emit(_current.copyWith(connection: SyncConnection.offline));
  }

  Future<void> dispose() async {
    await stop();
    await _status.close();
  }

  /// Signale une écriture locale : synchronisation groupée peu après.
  void notifyLocalChange() {
    if (!_running) return;
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 400),
      () => unawaited(syncNow()),
    );
  }

  /// Synchronise maintenant (une seule synchronisation à la fois ; une
  /// demande pendant une synchronisation en relance une à la fin).
  Future<void> syncNow() {
    if (!_running) return Future.value();
    if (_syncing != null) {
      _syncAgain = true;
      return _syncing!;
    }
    return _syncing = _runSync().whenComplete(() {
      _syncing = null;
      if (_syncAgain && _running) {
        _syncAgain = false;
        unawaited(syncNow());
      }
    });
  }

  Future<void> _runSync() async {
    _emit(_current.copyWith(syncing: true));
    try {
      await _push();
      await _pull();
      final now = DateTime.now().toUtc();
      await db.writeSetting(SettingKeys.lastSyncAt, now.toIso8601String());
      _emit(
        _current.copyWith(
          syncing: false,
          lastSyncAt: now,
          lastError: () => null,
        ),
      );
    } on ApiFailure catch (e) {
      if (e.isSessionLost) onSessionLost();
      _emit(_current.copyWith(syncing: false, lastError: () => e.message));
    }
  }

  // ── Push ─────────────────────────────────────────────────────────────

  Future<void> _push() async {
    while (true) {
      final ops = await db.pendingOperations(limit: maxPushBatchSize);
      if (ops.isEmpty) return;
      final request = PushRequest(
        deviceId: clock.deviceId,
        operations: [
          for (final op in ops)
            SyncOperation(
              opId: op.opId,
              entity: op.entity,
              entityId: op.entityId,
              baseVersion: op.baseVersion,
              hlc: op.hlc,
              fields: (jsonDecode(op.fields) as Map<String, dynamic>)
                  .cast<String, Object?>(),
            ),
        ],
      );

      final PushResponse response;
      try {
        response = PushResponse.fromJson(
          (await api.post('/api/v1/sync/push', request.toJson()))!
              as Map<String, dynamic>,
        );
      } on ApiFailure catch (e) {
        await db.customStatement(
          'UPDATE outbox SET attempts = attempts + 1, last_error = ? '
          'WHERE seq <= ?',
          [e.message, ops.last.seq],
        );
        rethrow;
      }

      final byId = {for (final op in ops) op.opId: op};
      await db.transaction(() async {
        for (final result in response.results) {
          final op = byId[result.opId];
          if (op == null) continue;
          await _applyPushResult(op, result);
        }
      });
    }
  }

  Future<void> _applyPushResult(OutboxRow op, OpResult result) async {
    await (db.delete(db.outbox)..where((t) => t.opId.equals(op.opId))).go();
    final entity = localEntityFor(op.entity);
    if (entity == null) return;

    if (result.status == OpStatus.invalid ||
        result.status == OpStatus.forbidden) {
      await db
          .into(db.syncErrors)
          .insert(
            SyncErrorsCompanion.insert(
              opId: op.opId,
              entity: op.entity,
              entityId: op.entityId,
              fields: op.fields,
              message: result.status == OpStatus.forbidden
                  ? 'Modification refusée : droits insuffisants.'
                  : result.issues.map((i) => i.message).join(' '),
              createdAt: DateTime.now().toUtc(),
            ),
          );
    }

    final pending = await db.pendingFieldsFor(op.entity, op.entityId);
    if (result.record != null) {
      clock.observe(result.record!.fieldMeta.values.map((s) => s.hlc));
      await entity.applyServerRecord(db, result.record!, pending);
    } else if (pending.isEmpty &&
        await entity.localVersion(db, op.entityId) == 0) {
      // Création refusée et jamais connue du serveur : on la retire.
      await entity.deleteLocal(db, op.entityId);
    }
  }

  // ── Pull ─────────────────────────────────────────────────────────────

  Future<void> _pull() async {
    var cursor = await db.readSetting<int>(SettingKeys.syncCursor) ?? 0;
    while (true) {
      final response = PullResponse.fromJson(
        (await api.get('/api/v1/sync/pull?cursor=$cursor'))!
            as Map<String, dynamic>,
      );
      await db.transaction(() async {
        for (final record in response.records) {
          final entity = localEntityFor(record.entity);
          if (entity == null) continue;
          clock.observe(record.fieldMeta.values.map((s) => s.hlc));
          await entity.applyServerRecord(
            db,
            record,
            await db.pendingFieldsFor(record.entity, record.id),
          );
        }
        await db.writeSetting(SettingKeys.syncCursor, response.cursor);
      });
      cursor = response.cursor;
      if (!response.hasMore) return;
    }
  }

  // ── Temps réel ───────────────────────────────────────────────────────

  Future<void> _connect() async {
    if (!_running) return;
    _emit(_current.copyWith(connection: SyncConnection.connecting));
    try {
      final tokens = await api.loadTokens();
      if (tokens == null) {
        onSessionLost();
        return;
      }
      // Jeton frais : il doit être valable au moment de l'authentification.
      final fresh =
          tokens.accessExpiresAt.isBefore(
            DateTime.now().toUtc().add(const Duration(minutes: 1)),
          )
          ? await api.refreshTokens(tokens)
          : tokens;

      final channel = WebSocketChannel.connect(api.webSocketUri);
      await channel.ready.timeout(const Duration(seconds: 10));
      _channel = channel;
      channel.sink.add(
        jsonEncode(
          ClientMessage.auth(
            accessToken: fresh.accessToken,
            protocolVersion: syncProtocolVersion,
          ).toJson(),
        ),
      );
      _channelSub = channel.stream.listen(
        _onMessage,
        onDone: _onDisconnected,
        onError: (Object _) => _onDisconnected(),
        cancelOnError: true,
      );
    } on ApiFailure catch (e) {
      if (e.isSessionLost) {
        onSessionLost();
        return;
      }
      _onDisconnected();
    } on Object {
      _onDisconnected();
    }
  }

  void _onMessage(dynamic data) {
    final ServerMessage message;
    try {
      message = ServerMessage.fromJson(
        jsonDecode(data as String) as Map<String, dynamic>,
      );
    } on Object {
      return;
    }
    switch (message) {
      case ServerReady():
        _reconnectAttempt = 0;
        _emit(_current.copyWith(connection: SyncConnection.online));
        unawaited(syncNow());
      case ServerChanges():
        unawaited(syncNow());
      case ServerSessionRevoked():
        onSessionLost();
      case ServerError(:final code):
        if (code == ApiErrorCodes.unauthenticated ||
            code == ApiErrorCodes.sessionRevoked) {
          // Jeton refusé : la reconnexion suivante le renouvellera.
          _reconnectAttempt = max(_reconnectAttempt, 1);
        }
    }
  }

  void _onDisconnected() {
    unawaited(_channelSub?.cancel());
    _channelSub = null;
    _channel = null;
    _emit(_current.copyWith(connection: SyncConnection.offline));
    if (!_running) return;
    // 1 s, 2 s, 4 s… jusqu'à 30 s, avec une part d'aléatoire.
    final seconds = min(30, pow(2, _reconnectAttempt).toInt());
    _reconnectAttempt++;
    final jitter = Random().nextInt(500);
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      Duration(milliseconds: seconds * 1000 + jitter),
      () => unawaited(_connect()),
    );
  }
}

/// Écrit une opération dans l'outbox (à appeler dans une transaction avec
/// l'écriture locale correspondante).
Future<void> enqueueOperation(
  AppDatabase db, {
  required String entity,
  required String entityId,
  required int baseVersion,
  required Hlc hlc,
  required Map<String, Object?> fields,
}) => db
    .into(db.outbox)
    .insert(
      OutboxCompanion.insert(
        opId: newId(),
        entity: entity,
        entityId: entityId,
        baseVersion: baseVersion,
        hlc: hlc.toString(),
        fields: jsonEncode(fields),
        createdAt: DateTime.now().toUtc(),
      ),
    );

/// Liste des opérations refusées (écran Synchronisation).
extension SyncErrorQueries on AppDatabase {
  Stream<List<SyncErrorRow>> watchSyncErrors() =>
      (select(syncErrors)..orderBy([(t) => OrderingTerm.desc(t.id)])).watch();

  Future<void> clearSyncErrors() => delete(syncErrors).go();
}
