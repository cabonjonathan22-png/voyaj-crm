/// Détection et fusion des doublons (organisations, contacts).
library;

import 'package:collection/collection.dart';

const _accents = {
  'à': 'a', 'â': 'a', 'ä': 'a', 'á': 'a', 'ã': 'a', //
  'ç': 'c',
  'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
  'î': 'i', 'ï': 'i', 'í': 'i', 'ì': 'i',
  'ô': 'o', 'ö': 'o', 'ó': 'o', 'ò': 'o', 'õ': 'o',
  'ù': 'u', 'û': 'u', 'ü': 'u', 'ú': 'u',
  'ÿ': 'y', 'ñ': 'n', 'œ': 'oe', 'æ': 'ae',
};

/// Retire les accents (texte en minuscules).
String removeAccents(String text) {
  final buffer = StringBuffer();
  for (final rune in text.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(_accents[char] ?? char);
  }
  return buffer.toString();
}

/// Texte de recherche : minuscules sans accents.
String searchText(String? text) => removeAccents((text ?? '').toLowerCase());

const _stopWords = {
  'de', 'du', 'des', 'la', 'le', 'les', 'l', 'd', 'et', 'en', 'sur', //
  'mairie', 'commune', 'ville',
};

/// Nom normalisé pour comparer : sans accents, ponctuation, mots vides ni
/// « mairie / commune / ville » (« Mairie de Saint-Affrique » =
/// « Commune de St Affrique »).
String normalizeName(String? name) {
  final words = searchText(name)
      .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
      .split(' ')
      .where((w) => w.isNotEmpty && !_stopWords.contains(w))
      .map((w) => w == 'st' ? 'saint' : (w == 'ste' ? 'sainte' : w));
  return words.join(' ');
}

String? _digits(Object? value) {
  if (value is! String) return null;
  final digits = value.replaceAll(RegExp(r'\D'), '');
  return digits.length >= 9 ? digits.substring(digits.length - 9) : null;
}

String? _text(Object? value) =>
    value is String && value.trim().isNotEmpty ? value.trim() : null;

/// Clés de rapprochement d'une organisation (format réseau) : deux
/// organisations partageant une clé sont des doublons probables.
Set<String> organisationDuplicateKeys(Map<String, Object?> r) {
  final name = normalizeName(r['name'] as String?);
  final place = _text(r['postal_code']) ?? searchText(_text(r['city']));
  return {
    if (_text(r['siret']) case final siret?) 'siret:$siret',
    if (_text(r['siren']) case final siren? when _text(r['siret']) == null)
      'siren:$siren:${r['kind']}',
    if (_text(r['insee_code']) case final insee?) 'insee:$insee:${r['kind']}',
    if (name.isNotEmpty && place.isNotEmpty) 'name:$name:$place',
  };
}

/// Clés de rapprochement d'un contact (format réseau).
Set<String> contactDuplicateKeys(Map<String, Object?> r) {
  final last = normalizeName(r['last_name'] as String?);
  final first = normalizeName(r['first_name'] as String?);
  return {
    if (_text(r['email']) case final email?) 'email:${email.toLowerCase()}',
    if (_digits(r['mobile']) case final mobile?) 'phone:$mobile',
    if (last.isNotEmpty && first.isNotEmpty)
      'name:$first $last:${r['organisation_id'] ?? ''}',
  };
}

/// Regroupe les éléments partageant au moins une clé (transitivement).
/// Seuls les groupes de deux éléments ou plus sont retournés.
List<List<T>> groupDuplicates<T>(
  List<T> items,
  Set<String> Function(T item) keys,
) {
  final parent = List<int>.generate(items.length, (i) => i);
  int find(int i) {
    while (parent[i] != i) {
      parent[i] = parent[parent[i]];
      i = parent[i];
    }
    return i;
  }

  final firstByKey = <String, int>{};
  for (final (i, item) in items.indexed) {
    for (final key in keys(item)) {
      final other = firstByKey.putIfAbsent(key, () => i);
      if (other != i) parent[find(i)] = find(other);
    }
  }
  final groups = <int, List<T>>{};
  for (final (i, item) in items.indexed) {
    groups.putIfAbsent(find(i), () => []).add(item);
  }
  return [
    for (final group in groups.values)
      if (group.length > 1) group,
  ];
}

bool _isEmpty(Object? value) =>
    value == null ||
    (value is String && value.trim().isEmpty) ||
    (value is Map && value.isEmpty);

/// Fusion : champs de [master] à compléter avec les valeurs des [others]
/// (dans l'ordre) là où le master est vide. Les champs personnalisés
/// (`custom_fields`) sont fusionnés clé par clé. Retourne uniquement les
/// champs à modifier sur le master.
Map<String, Object?> mergeDuplicateFields(
  Map<String, Object?> master,
  List<Map<String, Object?>> others,
  Iterable<String> fields,
) {
  final changes = <String, Object?>{};
  for (final field in fields) {
    if (field == 'custom_fields') {
      final merged = <String, Object?>{};
      for (final record in others.reversed) {
        if (record[field] case final Map<String, Object?> values) {
          merged.addAll(values);
        }
      }
      if (master[field] case final Map<String, Object?> values) {
        for (final MapEntry(:key, :value) in values.entries) {
          if (!_isEmpty(value)) merged[key] = value;
        }
      }
      if (merged.isNotEmpty &&
          !const DeepCollectionEquality().equals(merged, master[field])) {
        changes[field] = merged;
      }
      continue;
    }
    if (!_isEmpty(master[field])) continue;
    for (final record in others) {
      if (!_isEmpty(record[field])) {
        changes[field] = record[field];
        break;
      }
    }
  }
  return changes;
}
