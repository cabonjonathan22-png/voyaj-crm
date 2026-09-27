/// Erreur d'une source externe (message en français, sans secret).
final class ConnectorException implements Exception {
  const ConnectorException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Enregistrement brut d'une source (JSON).
typedef RawRecord = Map<String, Object?>;

/// Source d'enregistrements externes.
abstract interface class RecordSource {
  /// Lit au plus [limit] enregistrements.
  Future<List<RawRecord>> fetch({int limit = 10000});

  /// Libère les connexions.
  Future<void> close();
}

/// Lit une option de configuration texte obligatoire.
String requireConfig(Map<String, Object?> config, String key, String label) {
  final value = config[key];
  if (value is String && value.trim().isNotEmpty) return value.trim();
  throw ConnectorException('$label : valeur requise.');
}

/// Lit une option de configuration texte facultative.
String? optionalConfig(Map<String, Object?> config, String key) {
  final value = config[key];
  return value is String && value.trim().isNotEmpty ? value.trim() : null;
}
