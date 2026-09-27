import 'package:voyaj_shared/voyaj_shared.dart';

import 'source.dart';

/// Champs jamais alimentés par un connecteur (provenance et propriété).
const _protectedFields = {'source', 'source_ref', 'collected_at', 'owner_id'};

/// Champs Voyaj alimentables pour [schema].
List<String> mappableFields(EntitySchema schema) => [
  for (final field in schema.fields.keys)
    if (!_protectedFields.contains(field)) field,
];

/// Valeur au chemin [path] (`adresse.ville`, `contacts.0.email`).
Object? readPath(Object? record, String path) {
  Object? current = record;
  for (final segment in path.split('.')) {
    if (segment.isEmpty) return null;
    current = switch (current) {
      final Map<Object?, Object?> map => map[segment],
      final List<Object?> list => switch (int.tryParse(segment)) {
        final i? when i >= 0 && i < list.length => list[i],
        _ => null,
      },
      _ => null,
    };
    if (current == null) return null;
  }
  return current;
}

/// Chemins des valeurs présentes dans [records] (objets imbriqués aplatis,
/// premier élément des listes d'objets), triés.
List<String> recordPaths(Iterable<RawRecord> records, {int maxDepth = 4}) {
  final paths = <String>{};
  void visit(Object? value, String prefix, int depth) {
    if (value is Map<Object?, Object?> && depth < maxDepth) {
      for (final MapEntry(:key, value: child) in value.entries) {
        visit(child, prefix.isEmpty ? '$key' : '$prefix.$key', depth + 1);
      }
    } else if (value is List<Object?> &&
        value.isNotEmpty &&
        value.first is Map &&
        depth < maxDepth) {
      paths.add(prefix);
      visit(value.first, '$prefix.0', depth + 1);
    } else if (prefix.isNotEmpty) {
      paths.add(prefix);
    }
  }

  for (final record in records.take(50)) {
    visit(record, '', 0);
  }
  return paths.toList()..sort();
}

/// Applique [transform] (clé de [MappingTransform]) ; lève
/// [FormatException] si la valeur ne s'y prête pas.
Object? transformValue(Object? value, String transform) {
  if (value == null) return null;
  final text = value is String ? value.trim() : null;
  if (text != null && text.isEmpty) return null;
  num parseNumber() {
    if (value is num) return value;
    final clean = '$value'
        .replaceAll(RegExp(r'[\s  €]'), '')
        .replaceAll(',', '.');
    return num.tryParse(clean) ??
        (throw FormatException('nombre attendu (« $value »)'));
  }

  DateTime parseDate() {
    if (value is DateTime) return value;
    if (value is int) {
      // Horodatage Unix en secondes ou en millisecondes.
      return DateTime.fromMillisecondsSinceEpoch(
        value < 100000000000 ? value * 1000 : value,
        isUtc: true,
      );
    }
    final raw = '$value'.trim();
    final french = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$').firstMatch(raw);
    if (french != null) {
      return DateTime.utc(
        int.parse(french[3]!),
        int.parse(french[2]!),
        int.parse(french[1]!),
      );
    }
    return DateTime.tryParse(raw) ??
        (throw FormatException('date attendue (« $value »)'));
  }

  return switch (enumByKey(MappingTransform.values, transform)) {
    MappingTransform.trim => text ?? value,
    MappingTransform.lower => (text ?? '$value').toLowerCase(),
    MappingTransform.upper => (text ?? '$value').toUpperCase(),
    MappingTransform.digits => switch ('$value'.replaceAll(RegExp(r'\D'), '')) {
      '' => null,
      final digits => digits,
    },
    MappingTransform.number => parseNumber().toDouble(),
    MappingTransform.integer => parseNumber().round(),
    MappingTransform.cents => (parseNumber() * 100).round(),
    MappingTransform.boolean => switch (value) {
      final bool b => b,
      final num n => n != 0,
      _ => switch ('$value'.trim().toLowerCase()) {
        'true' || 'vrai' || 'oui' || 'yes' || 'o' || 'y' || '1' || 'x' => true,
        'false' || 'faux' || 'non' || 'no' || 'n' || '0' => false,
        _ => throw FormatException('oui / non attendu (« $value »)'),
      },
    },
    MappingTransform.date => formatDateOnly(parseDate()),
    MappingTransform.dateTime => parseDate().toUtc().toIso8601String(),
    MappingTransform.none || null => value,
  };
}

/// Adapte [value] au type du champ cible (texte, nombre, date…).
Object? coerce(Object? value, FieldSpec spec) {
  if (value == null) return null;
  return switch (spec.type) {
    FieldType.text => switch (value) {
      final String s => s.trim().isEmpty ? null : s.trim(),
      final num n => n == n.roundToDouble() ? '${n.round()}' : '$n',
      final bool b => b ? 'oui' : 'non',
      _ => '$value',
    },
    FieldType.integer =>
      value is int ? value : transformValue(value, 'integer'),
    FieldType.decimal => value is num ? value : transformValue(value, 'number'),
    FieldType.boolean =>
      value is bool ? value : transformValue(value, 'boolean'),
    FieldType.date => transformValue(value, 'date'),
    FieldType.dateTime => transformValue(value, 'date_time'),
    FieldType.json => value,
  };
}

/// Convertit un enregistrement source en champs de [schema] selon
/// [mapping]. Les problèmes (identifiant absent, valeur invalide) sont
/// listés ; l'enregistrement n'est alors pas importé.
MappedRecord mapRecord(
  RawRecord raw,
  ConnectorMapping mapping,
  EntitySchema schema,
) {
  final problems = <String>[];
  final ref = switch (readPath(raw, mapping.refPath)) {
    null => null,
    final Object id => '$id'.trim().isEmpty ? null : '$id'.trim(),
  };
  if (ref == null) {
    problems.add('Identifiant absent (${mapping.refPath}).');
  }
  final fields = <String, Object?>{};
  for (final field in mapping.fields) {
    final spec = schema.fields[field.target];
    if (spec == null || _protectedFields.contains(field.target)) {
      problems.add('Champ inconnu : ${field.target}.');
      continue;
    }
    final source = field.source;
    final value = source == null || source.isEmpty
        ? field.constant
        : readPath(raw, source);
    try {
      fields[field.target] = coerce(
        transformValue(value, field.transform),
        spec,
      );
    } on FormatException catch (e) {
      problems.add('${field.target} : ${e.message}.');
    }
  }
  for (final issue in schema.checkFields(fields)) {
    problems.add(
      issue.code == ValidationCodes.invalidType
          ? '${issue.field} : valeur « ${fields[issue.field]} » refusée.'
          : issue.message,
    );
  }
  return MappedRecord(ref: ref, fields: fields, problems: problems);
}
