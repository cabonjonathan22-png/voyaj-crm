import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:voyaj_shared/voyaj_shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../auth/auth_context.dart';
import '../errors.dart';

final _log = Logger('realtime');

/// Authentifie le jeton reçu dans le premier message du WebSocket.
typedef Authenticator = Future<AuthContext> Function(String accessToken);

/// Connexions WebSocket des clients : notifie les nouveaux changements et
/// ferme les connexions des sessions révoquées.
///
/// Le jeton d'accès est transmis dans le premier message (jamais dans l'URL,
/// qui peut être journalisée par un proxy).
final class RealtimeHub {
  RealtimeHub({
    required this._authenticate,
    required this._currentCursor,
    required Stream<int> changes,
    this.authTimeout = const Duration(seconds: 10),
  }) {
    _changesSub = changes.listen(_broadcast);
  }

  final Authenticator _authenticate;
  final Future<int> Function() _currentCursor;
  final Duration authTimeout;
  late final StreamSubscription<int> _changesSub;
  final _clients = <_Client>{};

  int get connectionCount => _clients.length;

  /// Prend en charge une nouvelle connexion.
  void handle(WebSocketChannel channel) {
    final client = _Client(channel);
    final authTimer = Timer(authTimeout, () {
      if (client.context == null) {
        _fail(client, ApiErrorCodes.unauthenticated, 'Délai dépassé.');
      }
    });

    client.subscription = channel.stream.listen(
      (data) async {
        if (client.context != null) return; // Aucun autre message attendu.
        authTimer.cancel();
        await _onAuth(client, data);
      },
      onDone: () {
        authTimer.cancel();
        _clients.remove(client);
      },
      onError: (Object error) {
        authTimer.cancel();
        _clients.remove(client);
      },
      cancelOnError: true,
    );
  }

  Future<void> _onAuth(_Client client, Object? data) async {
    final ClientMessage message;
    try {
      message = ClientMessage.fromJson(
        jsonDecode(data as String) as Map<String, dynamic>,
      );
    } on Object {
      _fail(client, ApiErrorCodes.badRequest, 'Message invalide.');
      return;
    }
    switch (message) {
      case ClientAuth(:final accessToken, :final protocolVersion):
        if (protocolVersion != syncProtocolVersion) {
          _fail(
            client,
            ApiErrorCodes.unsupportedProtocol,
            'Version de protocole non prise en charge : mettez à jour '
            "l'application.",
          );
          return;
        }
        try {
          client.context = await _authenticate(accessToken);
        } on ApiException catch (e) {
          _fail(client, e.code, e.message);
          return;
        }
        _clients.add(client);
        _send(client, ServerMessage.ready(cursor: await _currentCursor()));
        _log.fine('Client connecté (session ${client.context!.sessionId})');
    }
  }

  void _broadcast(int cursor) {
    final message = ServerMessage.changes(cursor: cursor);
    for (final client in _clients) {
      _send(client, message);
    }
  }

  /// Ferme les connexions des sessions révoquées.
  void revokeSessions(Iterable<String> sessionIds) {
    final ids = sessionIds.toSet();
    for (final client in _clients.toList()) {
      if (ids.contains(client.context?.sessionId)) {
        _send(client, const ServerMessage.sessionRevoked());
        _close(client);
      }
    }
  }

  void _fail(_Client client, String code, String message) {
    _send(client, ServerMessage.error(code: code, message: message));
    _close(client);
  }

  void _send(_Client client, ServerMessage message) {
    try {
      client.channel.sink.add(jsonEncode(message.toJson()));
    } on StateError {
      _clients.remove(client);
    }
  }

  void _close(_Client client) {
    _clients.remove(client);
    unawaited(client.close());
  }

  Future<void> close() async {
    await _changesSub.cancel();
    for (final client in _clients.toList()) {
      _close(client);
    }
  }
}

final class _Client {
  _Client(this.channel);

  final WebSocketChannel channel;
  StreamSubscription<dynamic>? subscription;
  AuthContext? context;

  Future<void> close() async {
    await subscription?.cancel();
    await channel.sink.close();
  }
}
