import 'dart:convert';

import 'package:voyaj_shared/voyaj_shared.dart';

/// Champ cible d'une colonne importée.
final class ImportTarget {
  const ImportTarget(this.key, {this.aliases = const []});

  /// Champ du schéma, `custom.<clé>`, `tags` ou `organisation`.
  final String key;

  /// En-têtes reconnus automatiquement (normalisés).
  final List<String> aliases;
}

/// Cible spéciale : noms de tags séparés par des virgules.
const importTags = 'tags';

/// Cible spéciale (contacts) : nom de l'organisation.
const importOrganisation = 'organisation';

/// Champs importables des organisations.
const organisationTargets = [
  ImportTarget(
    'name',
    aliases: [
      'nom',
      'raison sociale',
      'organisation',
      'collectivite',
      'libelle',
      'denomination',
      'structure',
    ],
  ),
  ImportTarget('kind', aliases: ['type', 'categorie', 'nature']),
  ImportTarget('status', aliases: ['statut', 'etat']),
  ImportTarget('siren', aliases: ['siren']),
  ImportTarget('siret', aliases: ['siret']),
  ImportTarget('insee_code', aliases: ['insee', 'code insee', 'code commune']),
  ImportTarget(
    'population',
    aliases: ['population', 'habitants', 'nombre habitants'],
  ),
  ImportTarget('address', aliases: ['adresse', 'rue', 'adresse postale']),
  ImportTarget('postal_code', aliases: ['code postal', 'cp']),
  ImportTarget(
    'city',
    aliases: ['ville', 'commune nom', 'localite', 'nom commune'],
  ),
  ImportTarget(
    'departement_code',
    aliases: ['departement', 'code departement', 'dept'],
  ),
  ImportTarget('region_code', aliases: ['region', 'code region']),
  ImportTarget('phone', aliases: ['telephone', 'tel', 'phone']),
  ImportTarget(
    'email',
    aliases: ['email', 'mail', 'courriel', 'adresse email'],
  ),
  ImportTarget(
    'website',
    aliases: ['site', 'site web', 'site internet', 'url', 'website'],
  ),
  ImportTarget(
    'description',
    aliases: ['description', 'notes', 'commentaire', 'commentaires'],
  ),
  ImportTarget('latitude', aliases: ['latitude', 'lat']),
  ImportTarget('longitude', aliases: ['longitude', 'lon', 'lng', 'long']),
  ImportTarget(importTags, aliases: ['tags', 'etiquettes']),
];

/// Champs importables des contacts.
const contactTargets = [
  ImportTarget('civility', aliases: ['civilite', 'titre']),
  ImportTarget('first_name', aliases: ['prenom', 'first name']),
  ImportTarget('last_name', aliases: ['nom', 'nom famille', 'last name']),
  ImportTarget(
    importOrganisation,
    aliases: [
      'organisation',
      'structure',
      'collectivite',
      'entreprise',
      'societe',
      'mairie',
    ],
  ),
  ImportTarget(
    'job_title',
    aliases: ['fonction', 'poste', 'titre poste', 'job'],
  ),
  ImportTarget('service', aliases: ['service', 'direction']),
  ImportTarget(
    'email',
    aliases: ['email', 'mail', 'courriel', 'adresse email'],
  ),
  ImportTarget(
    'phone',
    aliases: ['telephone', 'tel', 'telephone fixe', 'phone'],
  ),
  ImportTarget(
    'mobile',
    aliases: ['mobile', 'portable', 'telephone portable', 'gsm'],
  ),
  ImportTarget('notes', aliases: ['notes', 'commentaire', 'commentaires']),
  ImportTarget(
    'do_not_contact',
    aliases: ['ne pas contacter', 'opposition', 'desabonne'],
  ),
  ImportTarget(importTags, aliases: ['tags', 'etiquettes']),
];

String _normalizeHeader(String header) => searchText(
  header,
).replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim().replaceAll(RegExp(r'\s+'), ' ');

/// Cible reconnue pour un en-tête de colonne (ou `null`).
String? guessTarget(String header, List<ImportTarget> targets) {
  final normalized = _normalizeHeader(header);
  for (final target in targets) {
    if (target.aliases.contains(normalized) ||
        target.key == normalized.replaceAll(' ', '_')) {
      return target.key;
    }
  }
  return null;
}

/// Valeur énumérée reconnue par sa clé ou son libellé (sans accents ni
/// casse), ou `null`.
String? matchEnum(
  String value,
  List<KeyedEnum> values, {
  Map<String, String> aliases = const {},
}) {
  final needle = _normalizeHeader(value);
  if (needle.isEmpty) return null;
  for (final v in values) {
    if (_normalizeHeader(v.key) == needle ||
        _normalizeHeader(v.label) == needle ||
        _normalizeHeader(v.label).startsWith('$needle ')) {
      return v.key;
    }
  }
  return aliases[needle];
}

const _kindAliases = {
  'mairie': 'commune',
  'ville': 'commune',
  'communaute de communes': 'epci',
  'communaute d agglomeration': 'epci',
  'communaute urbaine': 'epci',
  'cc': 'epci',
  'ca': 'epci',
  'conseil departemental': 'departement',
  'conseil regional': 'region',
  'ot': 'office_tourisme',
  'office de tourisme': 'office_tourisme',
  'evenement': 'festival',
  'societe': 'entreprise',
  'asso': 'association',
};

bool? _parseBool(String value) {
  final v = _normalizeHeader(value);
  if (const {'oui', 'o', 'yes', 'y', 'true', 'vrai', '1', 'x'}.contains(v)) {
    return true;
  }
  if (const {'non', 'n', 'no', 'false', 'faux', '0', ''}.contains(v)) {
    return false;
  }
  return null;
}

num? _parseNumber(String value) =>
    num.tryParse(value.replaceAll(RegExp(r'[\s  ]'), '').replaceAll(',', '.'));

String? _regionCode(String value) {
  if (frenchRegions.containsKey(value.padLeft(2, '0'))) {
    return value.padLeft(2, '0');
  }
  final needle = _normalizeHeader(value);
  for (final MapEntry(:key, value: name) in frenchRegions.entries) {
    if (_normalizeHeader(name) == needle) return key;
  }
  return null;
}

/// Problème de conversion d'une cellule.
enum ImportProblem { kind, status, population, coordinate }

/// Ligne convertie : champs au format réseau, tags et organisation (par
/// nom) à rattacher, problèmes de conversion.
final class ImportedRow {
  ImportedRow(this.line);

  /// Numéro de ligne dans le fichier (en-tête = 1).
  final int line;
  final Map<String, Object?> fields = {};
  final Map<String, Object?> custom = {};
  final List<String> tags = [];
  String? organisationName;
  final List<(ImportProblem, String)> problems = [];
}

/// Convertit une ligne CSV selon [mapping] (index de colonne → cible).
/// Les champs personnalisés sont typés d'après [customTypes] (clé → type).
ImportedRow convertRow(
  CrmEntity entity,
  List<String> cells,
  Map<int, String> mapping, {
  required int line,
  Map<String, String> customTypes = const {},
}) {
  final row = ImportedRow(line);
  for (final MapEntry(key: column, value: target) in mapping.entries) {
    if (column >= cells.length) continue;
    final raw = cells[column].trim();
    if (raw.isEmpty) continue;
    if (target == importTags) {
      row.tags.addAll(
        raw
            .split(RegExp('[,;|]'))
            .map((t) => t.trim())
            .where((t) => t.isNotEmpty),
      );
      continue;
    }
    if (target == importOrganisation) {
      row.organisationName = raw;
      continue;
    }
    if (target.startsWith('custom.')) {
      final key = target.substring(7);
      row.custom[key] = switch (customTypes[key]) {
        'number' => _parseNumber(raw) ?? raw,
        'boolean' => _parseBool(raw) ?? raw,
        _ => raw,
      };
      continue;
    }
    switch (target) {
      case 'kind':
        final kind = matchEnum(
          raw,
          OrganisationKind.values,
          aliases: _kindAliases,
        );
        if (kind == null) {
          row.problems.add((ImportProblem.kind, raw));
        } else {
          row.fields['kind'] = kind;
        }
      case 'status':
        final status = matchEnum(raw, OrganisationStatus.values);
        if (status == null) {
          row.problems.add((ImportProblem.status, raw));
        } else {
          row.fields['status'] = status;
        }
      case 'service':
        row.fields['service'] = matchEnum(raw, ContactService.values);
      case 'region_code':
        row.fields['region_code'] = _regionCode(raw);
      case 'population':
        final n = _parseNumber(raw);
        if (n == null) {
          row.problems.add((ImportProblem.population, raw));
        } else {
          row.fields['population'] = n.round();
        }
      case 'latitude' || 'longitude':
        final n = _parseNumber(raw);
        if (n == null) {
          row.problems.add((ImportProblem.coordinate, raw));
        } else {
          row.fields[target] = n.toDouble();
        }
      case 'do_not_contact':
        row.fields['do_not_contact'] = _parseBool(raw) ?? true;
      case 'siren' || 'siret':
        row.fields[target] = raw.replaceAll(RegExp(r'\s'), '');
      case 'postal_code' || 'departement_code' || 'insee_code':
        row.fields[target] =
            RegExp(r'^\d{4}$').hasMatch(raw) && target != 'departement_code'
            ? '0$raw'
            : raw;
      case 'website':
        row.fields['website'] = raw.startsWith('http') ? raw : 'https://$raw';
      default:
        row.fields[target] = raw;
    }
  }
  if (row.custom.isNotEmpty) row.fields['custom_fields'] = {...row.custom};
  return row;
}

/// Décode le contenu d'un fichier texte : UTF-8, sinon Windows-1252 /
/// Latin-1 (exports Excel).
String decodeText(List<int> bytes) {
  try {
    return utf8.decode(bytes);
  } on FormatException {
    return latin1.decode(bytes);
  }
}
