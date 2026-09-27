@Tags(['integration'])
library;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Entités du CRM (Phase 2) : synchronisation des types de champs
/// (dates, décimaux, JSON, énumérations), règles de validation et fichiers
/// joints.
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  late TestServer server;

  setUpAll(() async => server = await TestServer.start());
  tearDownAll(() => server.close());

  group('Organisations et contacts', () {
    test('tous les types de champs font l’aller-retour', () async {
      final client = await server.admin();
      final orgId = newId();
      final result = (await client.push([
        client.op(orgId, {
          'name': 'Mairie de Rodez',
          'kind': OrganisationKind.commune.key,
          'status': OrganisationStatus.aProspecter.key,
          'siren': '211202023',
          'insee_code': '12202',
          'population': 24000,
          'latitude': 44.35,
          'longitude': 2.575,
          'website': 'https://www.rodez.fr',
          'custom_fields': {'budget_transport': 120000},
          'collected_at': '2026-09-01T10:00:00.000Z',
        }, entity: 'organisations'),
      ])).results.single;
      expect(result.status, OpStatus.applied, reason: '${result.issues}');
      final data = result.record!.data;
      expect(data['population'], 24000);
      expect(data['latitude'], 44.35);
      expect(data['custom_fields'], {'budget_transport': 120000});
      expect(data['collected_at'], '2026-09-01T10:00:00.000Z');

      final contactId = newId();
      final position = (await client.push([
        client.op(contactId, {
          'last_name': 'Durand',
          'first_name': 'Anne',
          'organisation_id': orgId,
        }, entity: 'contacts'),
        client.op(newId(), {
          'contact_id': contactId,
          'organisation_id': orgId,
          'is_elected': true,
          'mandate_role': MandateRole.maire.key,
          'start_date': '2020-07-03',
        }, entity: 'positions'),
      ])).results;
      expect(position.map((r) => r.status), everyElement(OpStatus.applied));
      expect(position.last.record!.data['start_date'], '2020-07-03');

      final pulled = await client.pull(0);
      final entities = pulled.records.map((r) => r.entity).toSet();
      expect(entities, containsAll(['organisations', 'contacts', 'positions']));
    });

    test('règles métier appliquées après fusion', () async {
      final client = await server.admin();
      final results = (await client.push([
        client.op(newId(), {
          'name': 'SIREN faux',
          'kind': 'commune',
          'status': 'a_prospecter',
          'siren': '123',
        }, entity: 'organisations'),
        client.op(newId(), {
          'name': 'Type inconnu',
          'kind': 'planete',
          'status': 'a_prospecter',
        }, entity: 'organisations'),
        client.op(newId(), {
          'contact_id': newId(),
          'organisation_id': newId(),
          'is_elected': true,
        }, entity: 'positions'),
        client.op(newId(), {
          'contact_id': newId(),
          'organisation_id': newId(),
          'is_elected': false,
          'start_date': '2026-02-30',
        }, entity: 'positions'),
      ])).results;
      expect(results.map((r) => r.status), everyElement(OpStatus.invalid));
      expect(results[0].issues.single.field, 'siren');
      expect(results[1].issues.single.code, ValidationCodes.invalidType);
      expect(results[2].issues.single.field, 'mandate_role');
    });

    test('un lecteur voit les organisations mais ne peut pas écrire', () async {
      final reader = await server.userWithRoles('crm-lecteur@voyaj.test', [
        'lecture',
      ]);
      final result = (await reader.push([
        reader.op(newId(), {
          'name': 'Interdit',
          'kind': 'commune',
          'status': 'a_prospecter',
        }, entity: 'organisations'),
      ])).results.single;
      expect(result.status, OpStatus.forbidden);
      final pulled = await reader.pull(0);
      expect(pulled.records.map((r) => r.entity), contains('organisations'));
    });
  });

  group('Pipelines et affaires', () {
    test('déplacement d’une affaire entre étapes', () async {
      final client = await server.admin();
      final pipeline = newId();
      final stage1 = newId();
      final stage2 = newId();
      final deal = newId();
      final created = (await client.push([
        client.op(pipeline, {
          'name': 'Collectivités',
          'kind': 'collectivites',
        }, entity: 'pipelines'),
        for (final (i, id) in [stage1, stage2].indexed)
          client.op(id, {
            'pipeline_id': pipeline,
            'name': 'Étape $i',
            'sort_order': i.toDouble(),
            'outcome': 'open',
          }, entity: 'pipeline_stages'),
        client.op(deal, {
          'title': 'Navettes estivales',
          'pipeline_id': pipeline,
          'stage_id': stage1,
          'status': 'open',
          'amount_cents': 1250000,
          'expected_close_date': '2026-12-15',
        }, entity: 'deals'),
      ])).results;
      expect(created.map((r) => r.status), everyElement(OpStatus.applied));

      final moved = (await client.push([
        client.op(deal, {'stage_id': stage2}, baseVersion: 1, entity: 'deals'),
      ])).results.single;
      expect(moved.status, OpStatus.applied);
      expect(moved.record!.data['stage_id'], stage2);
      expect(moved.record!.data['amount_cents'], 1250000);
    });

    test('la configuration des pipelines demande pipeline.manage', () async {
      final sales = await server.userWithRoles('crm-commercial@voyaj.test', [
        'commercial',
      ]);
      final result = (await sales.push([
        sales.op(newId(), {
          'name': 'Pipeline perso',
          'kind': 'autre',
        }, entity: 'pipelines'),
      ])).results.single;
      expect(result.status, OpStatus.forbidden);
    });
  });

  group('Fichiers joints', () {
    test('envoi, déduplication et téléchargement', () async {
      final client = await server.admin();
      final bytes = utf8.encode('Compte rendu de réunion');
      final first = await client.upload(bytes, mimeType: 'text/plain');
      expect(first.status, 201);
      expect(first.json['id'], sha256.convert(bytes).toString());
      expect(first.json['size'], bytes.length);

      final again = await client.upload(bytes, mimeType: 'text/plain');
      expect(again.json['id'], first.json['id']);

      final downloaded = await client.download(first.json['id'] as String);
      expect(downloaded.statusCode, 200);
      expect(downloaded.bodyBytes, bytes);
      expect(downloaded.headers['content-type'], startsWith('text/plain'));
    });

    test('identifiant inconnu ou invalide : 404', () async {
      final client = await server.admin();
      expect((await client.download('0' * 64)).statusCode, 404);
      expect((await client.download('../../etc/passwd')).statusCode, 404);
    });

    test('authentification obligatoire', () async {
      final anonymous = ApiClient(server.baseUri);
      final response = await anonymous.upload([1, 2, 3]);
      expect(response.status, 401);
    });
  });
}
