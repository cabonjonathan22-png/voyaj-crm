import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voyaj_shared/voyaj_shared.dart';

import 'parsers.dart';
import 'public_record.dart';

/// Lecture des sources publiques (adresses modifiables pour les tests ou
/// un miroir).
final class PublicDataClient {
  PublicDataClient({
    http.Client? httpClient,
    this.geoApi = 'https://geo.api.gouv.fr',
    this.aomUrl = 'https://transport.data.gouv.fr/api/aoms/geojson',
    this.festivalsUrl =
        'https://data.culture.gouv.fr/api/explore/v2.1/catalog/datasets/'
        'festivals-global-festivals-_-pl/exports/json',
  }) : _http = httpClient ?? http.Client();

  final http.Client _http;
  final String geoApi;
  final String aomUrl;
  final String festivalsUrl;

  static const _timeout = Duration(minutes: 3);
  static const _communeFields =
      'nom,code,codesPostaux,siren,codeEpci,codeDepartement,codeRegion,'
      'population,centre';

  /// Organisations de [source]. [departements] limite l'import (vide =
  /// toute la France ; régions : toujours toutes).
  Future<List<PublicRecord>> fetch(
    PublicSource source, {
    List<String> departements = const [],
  }) async {
    final scope = departements.isEmpty ? null : departements.toSet();
    return switch (source) {
      PublicSource.regions => parseRegions(
        await _get('$geoApi/regions?fields=nom,code'),
      ),
      PublicSource.departements => parseDepartements(
        await _get('$geoApi/departements?fields=nom,code,codeRegion'),
        scope: scope,
      ),
      PublicSource.epcis => parseEpcis(
        await _get(
          '$geoApi/epcis?fields=nom,code,codesDepartements,codesRegions,'
          'population,centre',
        ),
        scope: scope,
      ),
      PublicSource.communes =>
        scope == null
            ? parseCommunes(
                await _get('$geoApi/communes?fields=$_communeFields'),
              )
            : [
                for (final d in scope)
                  ...parseCommunes(
                    await _get(
                      '$geoApi/departements/${Uri.encodeComponent(d)}/'
                      'communes?fields=$_communeFields',
                    ),
                  ),
              ],
      PublicSource.aoms => parseAoms(await _get(aomUrl), scope: scope),
      PublicSource.festivals => parseFestivals(
        await _get(festivalsUrl),
        scope: scope,
      ),
    };
  }

  /// Document JSON à [url] (erreurs en [PublicDataException]).
  Future<Object?> getJson(String url) => _get(url);

  Future<Object?> _get(String url) async {
    final uri = Uri.parse(url);
    final http.Response response;
    try {
      response = await _http
          .get(uri, headers: {'accept': 'application/json'})
          .timeout(_timeout);
    } on Object catch (e) {
      throw PublicDataException('${uri.host} injoignable ($e).');
    }
    if (response.statusCode != 200) {
      throw PublicDataException(
        '${uri.host} a répondu ${response.statusCode}.',
      );
    }
    try {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw PublicDataException('Réponse illisible de ${uri.host}.');
    }
  }

  void close() => _http.close();
}
