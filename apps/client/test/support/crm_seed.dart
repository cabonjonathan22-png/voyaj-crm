import 'package:voyaj_client/data/local/database.dart';
import 'package:voyaj_client/data/sync/local_entities.dart';

/// Données CRM de démonstration (tests d'écrans et captures).
Future<void> seedCrm(AppDatabase db) async {
  final now = DateTime.now().toUtc();
  String ago(Duration d) => now.subtract(d).toIso8601String();

  Future<void> put(
    String entity,
    String id,
    Map<String, Object?> fields, {
    int version = 2,
  }) => localEntityFor(entity)!.upsert(db, id, {
    ...fields,
    'version': version,
    'created_at': ago(const Duration(days: 20)),
    'updated_at': ago(Duration(hours: id.hashCode % 90)),
  });

  const organisations = [
    (
      'org-1',
      'Mairie de Rodez',
      'commune',
      'en_discussion',
      'Rodez',
      '12000',
      '12',
      44.3506,
      2.5750,
      24000,
      'org-3',
    ),
    (
      'org-2',
      'Mairie de Millau',
      'commune',
      'client',
      'Millau',
      '12100',
      '12',
      44.0986,
      3.0783,
      22000,
      'org-3',
    ),
    (
      'org-3',
      'Rodez Agglomération',
      'epci',
      'contacte',
      'Rodez',
      '12000',
      '12',
      44.3530,
      2.5700,
      56000,
      null,
    ),
    (
      'org-4',
      'Festival des Nuits de Nacre',
      'festival',
      'a_prospecter',
      'Tulle',
      '19000',
      '19',
      45.2658,
      1.7722,
      null,
      null,
    ),
    (
      'org-5',
      'Région Occitanie',
      'region',
      'partenaire',
      'Toulouse',
      '31000',
      '31',
      43.6045,
      1.4440,
      6000000,
      null,
    ),
    (
      'org-6',
      'Office de tourisme de Conques',
      'office_tourisme',
      'perdu',
      'Conques',
      '12320',
      '12',
      44.5990,
      2.3980,
      null,
      null,
    ),
    (
      'org-7',
      'Mairie de St Affrique',
      'commune',
      'a_prospecter',
      'Saint-Affrique',
      '12400',
      '12',
      null,
      null,
      8000,
      null,
    ),
    (
      'org-8',
      'Commune de Saint-Affrique',
      'commune',
      'a_prospecter',
      'Saint-Affrique',
      '12400',
      '12',
      null,
      null,
      null,
      null,
    ),
  ];
  for (final (id, name, kind, status, city, cp, dept, lat, lng, pop, parent)
      in organisations) {
    await put('organisations', id, {
      'name': name,
      'kind': kind,
      'status': status,
      'city': city,
      'postal_code': cp,
      'departement_code': dept,
      'region_code': dept == '19' ? '75' : '76',
      'latitude': lat,
      'longitude': lng,
      'population': pop,
      'parent_id': parent,
      'email': 'contact@${city.toLowerCase().replaceAll(' ', '')}.fr',
      'website': 'https://www.${city.toLowerCase().replaceAll(' ', '')}.fr',
      'phone': '05 65 00 00 0${id.substring(4)}',
      'custom_fields': {'budget_mobilite': 120000},
      'source': id == 'org-7' ? 'Import CSV communes.csv' : null,
    });
  }

  const contacts = [
    (
      'ct-1',
      'Mme',
      'Anne',
      'Durand',
      'org-1',
      'Directrice générale des services',
      'direction',
      'a.durand@rodez.fr',
    ),
    (
      'ct-2',
      'M.',
      'Paul',
      'Martin',
      'org-1',
      'Maire',
      'elus',
      'maire@rodez.fr',
    ),
    (
      'ct-3',
      'Mme',
      'Léa',
      'Petit',
      'org-2',
      'Chargée de mobilité',
      'mobilite',
      'l.petit@millau.fr',
    ),
    (
      'ct-4',
      'M.',
      'Jean',
      'Roux',
      'org-4',
      'Programmateur',
      'culture',
      'jean@nuitsdenacre.fr',
    ),
    (
      'ct-5',
      'Mme',
      'Claire',
      'Bernard',
      'org-5',
      'Vice-présidente transports',
      'elus',
      null,
    ),
  ];
  for (final (id, civ, first, last, org, job, service, email) in contacts) {
    await put('contacts', id, {
      'civility': civ,
      'first_name': first,
      'last_name': last,
      'organisation_id': org,
      'job_title': job,
      'service': service,
      'email': email,
      'mobile': '06 12 34 56 7${id.substring(3)}',
      'do_not_contact': id == 'ct-4',
    });
  }
  await put('positions', 'pos-1', {
    'contact_id': 'ct-2',
    'organisation_id': 'org-1',
    'is_elected': true,
    'mandate_role': 'maire',
    'delegation': 'Mobilités et grands projets',
    'start_date': '2020-07-03',
  });
  await put('positions', 'pos-2', {
    'contact_id': 'ct-5',
    'organisation_id': 'org-5',
    'is_elected': true,
    'mandate_role': 'vice_president',
    'delegation': 'Transports et intermodalité',
    'start_date': '2021-07-02',
  });

  await put('pipelines', 'pl-1', {
    'name': 'Collectivités',
    'kind': 'collectivites',
    'sort_order': 0.0,
  });
  await put('pipelines', 'pl-2', {
    'name': 'Festivals',
    'kind': 'festivals',
    'sort_order': 1.0,
  });
  const stages = [
    ('st-1', 'Identifiée', 10, 'open', '#64748B'),
    ('st-2', 'Premier contact', 20, 'open', '#0EA5E9'),
    ('st-3', 'Proposition envoyée', 60, 'open', '#6366F1'),
    ('st-4', 'Gagnée', 100, 'won', '#22C55E'),
    ('st-5', 'Perdue', 0, 'lost', '#EF4444'),
  ];
  for (final (i, (id, name, probability, outcome, color)) in stages.indexed) {
    await put('pipeline_stages', id, {
      'pipeline_id': 'pl-1',
      'name': name,
      'sort_order': i.toDouble(),
      'probability': probability,
      'outcome': outcome,
      'color': color,
    });
  }
  const deals = [
    (
      'deal-1',
      'Navettes estivales 2027',
      'st-3',
      'org-1',
      'ct-1',
      4500000,
      'open',
      '2026-11-30',
    ),
    (
      'deal-2',
      'Transport à la demande',
      'st-2',
      'org-3',
      null,
      12000000,
      'open',
      '2026-06-30',
    ),
    (
      'deal-3',
      'Desserte festival',
      'st-1',
      'org-2',
      'ct-3',
      800000,
      'open',
      null,
    ),
    (
      'deal-4',
      'Ligne touristique Conques',
      'st-5',
      'org-6',
      null,
      1500000,
      'lost',
      null,
    ),
    (
      'deal-5',
      'Convention régionale',
      'st-4',
      'org-5',
      'ct-5',
      25000000,
      'won',
      '2026-03-01',
    ),
  ];
  for (final (i, (id, title, stage, org, contact, amount, status, close))
      in deals.indexed) {
    await put('deals', id, {
      'title': title,
      'pipeline_id': 'pl-1',
      'stage_id': stage,
      'organisation_id': org,
      'contact_id': contact,
      'amount_cents': amount,
      'status': status,
      'expected_close_date': close,
      'sort_order': i.toDouble(),
    });
  }

  await put('activities', 'act-1', {
    'kind': 'meeting',
    'subject': 'Présentation du service de navettes',
    'body': 'Intérêt fort de la DGS, attente du budget 2027.',
    'organisation_id': 'org-1',
    'contact_id': 'ct-1',
    'starts_at': ago(const Duration(days: 3)),
  });
  await put('activities', 'act-2', {
    'kind': 'task',
    'subject': 'Envoyer la proposition chiffrée',
    'organisation_id': 'org-1',
    'deal_id': 'deal-1',
    'due_at': ago(const Duration(days: 1)),
  });
  await put('activities', 'act-3', {
    'kind': 'task',
    'subject': 'Relancer le programmateur',
    'organisation_id': 'org-4',
    'contact_id': 'ct-4',
    'due_at': now.add(const Duration(days: 5)).toIso8601String(),
  });
  await put('activities', 'act-4', {
    'kind': 'call',
    'subject': 'Appel de qualification',
    'organisation_id': 'org-2',
    'contact_id': 'ct-3',
    'starts_at': ago(const Duration(days: 8)),
  });
  await put('attachments', 'file-1', {
    'file_id': 'a' * 64,
    'file_name': 'Proposition navettes 2027.pdf',
    'size': 482133,
    'mime_type': 'application/pdf',
    'organisation_id': 'org-1',
  });

  await put('taggings', 'tg-1', {
    'tag_id': 'tag-1',
    'entity': 'organisations',
    'record_id': 'org-1',
  });
  await put('taggings', 'tg-2', {
    'tag_id': 'tag-4',
    'entity': 'organisations',
    'record_id': 'org-1',
  });
  await put('taggings', 'tg-3', {
    'tag_id': 'tag-2',
    'entity': 'organisations',
    'record_id': 'org-4',
  });
  await put('custom_fields', 'cf-1', {
    'entity': 'organisations',
    'key': 'budget_mobilite',
    'label': 'Budget mobilité (€)',
    'type': 'number',
    'sort_order': 0.0,
  });
  await put('segments', 'seg-1', {
    'name': 'Aveyron à prospecter',
    'entity': 'organisations',
    'config': {
      'search': '',
      'filters': [
        {'column': 'departement', 'op': 'equals', 'value': '12'},
      ],
      'sort': 'name',
      'asc': true,
    },
  });
}
