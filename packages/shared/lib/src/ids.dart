import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final _uuidPattern = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
);

/// Génère un identifiant UUID v7 (ordonné dans le temps).
///
/// Les identifiants sont créés côté client pour permettre la création
/// d'enregistrements hors ligne sans collision.
String newId() => _uuid.v7();

/// Indique si [value] est un UUID au format canonique minuscule.
bool isValidId(String value) => _uuidPattern.hasMatch(value);
