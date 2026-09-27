import 'dart:collection';

/// Limiteur de tentatives en mémoire (fenêtre glissante).
///
/// Protège la connexion et la saisie des codes 2FA contre la force brute.
/// En mémoire : suffisant pour une instance unique de serveur.
final class RateLimiter {
  RateLimiter({
    required this.maxAttempts,
    required this.window,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final int maxAttempts;
  final Duration window;
  final DateTime Function() _clock;
  final _attempts = HashMap<String, List<DateTime>>();

  /// Indique si une nouvelle tentative est autorisée pour [key].
  bool allow(String key) {
    _prune(key);
    return (_attempts[key]?.length ?? 0) < maxAttempts;
  }

  /// Enregistre un échec pour [key].
  void recordFailure(String key) {
    _prune(key);
    (_attempts[key] ??= []).add(_clock());
    if (_attempts.length > 10000) _pruneAll();
  }

  /// Réinitialise [key] après un succès.
  void reset(String key) => _attempts.remove(key);

  void _prune(String key) {
    final list = _attempts[key];
    if (list == null) return;
    final limit = _clock().subtract(window);
    list.removeWhere((t) => t.isBefore(limit));
    if (list.isEmpty) _attempts.remove(key);
  }

  void _pruneAll() => _attempts.keys.toList().forEach(_prune);
}
