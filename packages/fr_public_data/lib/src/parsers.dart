/// Conversion des réponses des sources publiques en organisations.
library;

import 'package:voyaj_shared/voyaj_shared.dart';

import 'public_record.dart';

String? _text(Object? value) {
  if (value == null) return null;
  final text = '$value'.trim();
  return text.isEmpty ? null : text;
}

/// Première valeur non vide parmi [keys].
String? _first(Map<String, Object?> json, List<String> keys) {
  for (final key in keys) {
    final value = _text(json[key]);
    if (value != null) return value;
  }
  return null;
}

int? _int(Object? value) => switch (value) {
  final int i => i,
  final num n => n.round(),
  final String s => int.tryParse(s.replaceAll(RegExp(r'\s'), '')),
  _ => null,
};

/// Coordonnées d'un point GeoJSON (`[longitude, latitude]`).
(double, double)? _point(Object? geometry) {
  if (geometry is! Map) return null;
  final coordinates = geometry['coordinates'];
  if (coordinates is! List || coordinates.length < 2) return null;
  final lon = coordinates[0];
  final lat = coordinates[1];
  if (lon is! num || lat is! num) return null;
  return (lat.toDouble(), lon.toDouble());
}

/// Code du département d'un code postal ou INSEE (`12100` → `12`,
/// `97411` → `974`, `2A004` → `2A`).
String? departementOf(String? code) {
  if (code == null || code.length < 2) return null;
  if (code.startsWith('97') || code.startsWith('98')) {
    return code.length >= 3 ? code.substring(0, 3) : null;
  }
  final prefix = code.substring(0, 2).toUpperCase();
  return RegExp(r'^(\d{2}|2A|2B)$').hasMatch(prefix) ? prefix : null;
}

List<Map<String, Object?>> _objects(Object? json, String source) {
  if (json is! List) {
    throw PublicDataException(
      'Réponse inattendue de $source (liste attendue).',
    );
  }
  return [
    for (final item in json)
      if (item is Map) item.cast<String, Object?>(),
  ];
}

/// `GET /regions?fields=nom,code` (geo.api.gouv.fr).
List<PublicRecord> parseRegions(Object? json) => [
  for (final r in _objects(json, 'geo.api.gouv.fr'))
    if (_text(r['code']) case final code?)
      PublicRecord(
        ref: code,
        matchField: 'region_code',
        fields: {
          'name': _text(r['nom']) ?? frenchRegions[code] ?? code,
          'kind': OrganisationKind.region.key,
          'region_code': code,
        },
      ),
];

/// `GET /departements?fields=nom,code,codeRegion` (geo.api.gouv.fr).
List<PublicRecord> parseDepartements(Object? json, {Set<String>? scope}) => [
  for (final d in _objects(json, 'geo.api.gouv.fr'))
    if (_text(d['code']) case final code?)
      if (scope == null || scope.contains(code))
        PublicRecord(
          ref: code,
          matchField: 'departement_code',
          fields: {
            'name': _text(d['nom']) ?? code,
            'kind': OrganisationKind.departement.key,
            'departement_code': code,
            'region_code': _text(d['codeRegion']),
          },
          parent: _text(d['codeRegion']) == null
              ? null
              : ParentRef('region_code', _text(d['codeRegion'])!, {
                  OrganisationKind.region.key,
                }),
        ),
];

/// `GET /epcis?fields=nom,code,codesDepartements,codesRegions,population,centre`
/// (geo.api.gouv.fr). Le code d'un EPCI est son SIREN.
List<PublicRecord> parseEpcis(Object? json, {Set<String>? scope}) {
  final records = <PublicRecord>[];
  for (final e in _objects(json, 'geo.api.gouv.fr')) {
    final code = _text(e['code']);
    if (code == null) continue;
    final departements = [
      for (final d in (e['codesDepartements'] as List<Object?>?) ?? const [])
        '$d',
    ];
    if (scope != null && !departements.any(scope.contains)) continue;
    final regions = [
      for (final r in (e['codesRegions'] as List<Object?>?) ?? const []) '$r',
    ];
    final name = _text(e['nom']) ?? code;
    final point = _point(e['centre']);
    final departement = departements.firstOrNull;
    records.add(
      PublicRecord(
        ref: code,
        matchField: 'siren',
        fields: {
          'name': name,
          'kind': searchText(name).startsWith('metropole')
              ? OrganisationKind.metropole.key
              : OrganisationKind.epci.key,
          'siren': code,
          'departement_code': departement,
          'region_code': regions.firstOrNull,
          'population': _int(e['population']),
          'latitude': point?.$1,
          'longitude': point?.$2,
        },
        parent: departement == null
            ? null
            : ParentRef('departement_code', departement, {
                OrganisationKind.departement.key,
              }),
      ),
    );
  }
  return records;
}

/// `GET /communes?fields=nom,code,codesPostaux,siren,codeEpci,codeDepartement,codeRegion,population,centre`
/// (geo.api.gouv.fr). La commune est rattachée à son EPCI.
List<PublicRecord> parseCommunes(Object? json) => [
  for (final c in _objects(json, 'geo.api.gouv.fr'))
    if (_text(c['code']) case final code?)
      () {
        final point = _point(c['centre']);
        final epci = _text(c['codeEpci']);
        final postalCodes = (c['codesPostaux'] as List<Object?>?) ?? const [];
        return PublicRecord(
          ref: code,
          matchField: 'insee_code',
          fields: {
            'name': _text(c['nom']) ?? code,
            'kind': OrganisationKind.commune.key,
            'insee_code': code,
            'siren': _text(c['siren']),
            'postal_code': postalCodes.isEmpty ? null : '${postalCodes.first}',
            'city': _text(c['nom']),
            'departement_code': _text(c['codeDepartement']),
            'region_code': _text(c['codeRegion']),
            'population': _int(c['population']),
            'latitude': point?.$1,
            'longitude': point?.$2,
          },
          parent: epci == null
              ? null
              : ParentRef('siren', epci, {
                  OrganisationKind.epci.key,
                  OrganisationKind.metropole.key,
                }),
        );
      }(),
];

/// AOM (transport.data.gouv.fr, GeoJSON des ressorts territoriaux) :
/// propriétés `nom`, `siren`, `departement`, `region`, `forme_juridique`
/// (variantes de nommage tolérées).
List<PublicRecord> parseAoms(Object? json, {Set<String>? scope}) {
  final features = switch (json) {
    {'features': final List<Object?> list} => list,
    final List<Object?> list => list,
    _ => throw const PublicDataException(
      'Réponse inattendue de transport.data.gouv.fr.',
    ),
  };
  final records = <PublicRecord>[];
  for (final feature in features) {
    if (feature is! Map) continue;
    final p =
        (feature['properties'] is Map ? feature['properties'] as Map : feature)
            .cast<String, Object?>();
    final name = _first(p, const ['nom', 'nom_aom', 'name', 'libelle']);
    if (name == null) continue;
    final siren = _first(p, const ['siren', 'siren_aom', 'n_siren_aom']);
    final departement = _first(p, const [
      'departement',
      'code_departement',
      'insee_departement',
    ]);
    if (scope != null && departement != null && !scope.contains(departement)) {
      continue;
    }
    final legalForm = _first(p, const [
      'forme_juridique',
      'forme_juridique_2022',
      'type',
    ]);
    records.add(
      PublicRecord(
        ref: siren ?? searchText(name),
        matchField: siren == null ? null : 'siren',
        fields: {
          'name': name,
          'kind': OrganisationKind.aom.key,
          if (siren != null && RegExp(r'^\d{9}$').hasMatch(siren))
            'siren': siren,
          'departement_code': ?departement,
          if (_first(p, const ['region', 'code_region']) case final region?)
            if (frenchRegions.containsKey(region)) 'region_code': region,
          'description': ?legalForm,
        },
      ),
    );
  }
  return records;
}

/// Festivals (data.culture.gouv.fr, jeu « Panorama des festivals »,
/// export JSON). Coordonnées dans `geocodage_xy` (`lon`, `lat`).
List<PublicRecord> parseFestivals(Object? json, {Set<String>? scope}) {
  final records = <PublicRecord>[];
  for (final f in _objects(json, 'data.culture.gouv.fr')) {
    final name = _first(f, const ['nom_du_festival', 'nom', 'nom_festival']);
    if (name == null) continue;
    final postalCode = _first(f, const [
      'code_postal_de_la_commune_principale_de_deroulement',
      'code_postal',
    ]);
    final insee = _first(f, const ['code_insee_commune', 'code_insee']);
    final departement = departementOf(insee) ?? departementOf(postalCode);
    if (scope != null &&
        (departement == null || !scope.contains(departement))) {
      continue;
    }
    final geo = f['geocodage_xy'];
    final (lat, lon) = switch (geo) {
      {'lat': final num lat, 'lon': final num lon} => (
        lat.toDouble(),
        lon.toDouble(),
      ),
      _ => (null, null),
    };
    final website = _first(f, const ['site_internet_du_festival', 'site_web']);
    final email = _first(f, const ['adresse_e_mail', 'email']);
    final description = [
      _first(f, const ['discipline_dominante', 'discipline']),
      _first(f, const [
        'periode_principale_de_deroulement_du_festival',
        'periode',
      ]),
    ].whereType<String>().join(' · ');
    final city = _first(f, const [
      'commune_principale_de_deroulement',
      'commune',
    ]);
    records.add(
      PublicRecord(
        ref:
            _first(f, const ['identifiant', 'identifiant_agence_a']) ??
            searchText('$name|${insee ?? city ?? ''}'),
        fields: {
          'name': name.length > 200 ? name.substring(0, 200) : name,
          'kind': OrganisationKind.festival.key,
          'city': city,
          if (postalCode != null && RegExp(r'^\d{5}$').hasMatch(postalCode))
            'postal_code': postalCode,
          if (insee != null && RegExp(r'^(\d{5}|2[AB]\d{3})$').hasMatch(insee))
            'insee_code': insee,
          'departement_code': departement,
          'latitude': lat,
          'longitude': lon,
          if (website != null)
            'website': website.startsWith('http')
                ? website
                : 'https://$website',
          if (email != null && email.contains('@') && !email.contains(' '))
            'email': email,
          if (description.isNotEmpty) 'description': description,
        },
      ),
    );
  }
  return records;
}
