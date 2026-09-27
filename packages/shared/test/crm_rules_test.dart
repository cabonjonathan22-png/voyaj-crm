import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  group('FieldSpec', () {
    test('dates calendaires : format strict et date existante', () {
      const spec = FieldSpec(FieldType.date);
      expect(spec.accepts('2026-09-27'), isTrue);
      expect(spec.accepts('2024-02-29'), isTrue);
      expect(spec.accepts('2026-02-30'), isFalse);
      expect(spec.accepts('2026-9-27'), isFalse);
      expect(spec.accepts('2026-09-27T00:00:00Z'), isFalse);
      expect(spec.accepts(null), isTrue);
    });

    test('énumérations', () {
      final spec = FieldSpec.oneOf(
        keysOf(OrganisationKind.values),
        nullable: false,
      );
      expect(spec.accepts('commune'), isTrue);
      expect(spec.accepts('office_tourisme'), isTrue);
      expect(spec.accepts('Commune'), isFalse);
      expect(spec.accepts(null), isFalse);
    });

    test('décimaux et JSON', () {
      expect(const FieldSpec(FieldType.decimal).accepts(3), isTrue);
      expect(const FieldSpec(FieldType.decimal).accepts('3'), isFalse);
      expect(const FieldSpec(FieldType.json).accepts(const {'a': 1}), isTrue);
      expect(const FieldSpec(FieldType.json).accepts(const [1]), isTrue);
      expect(const FieldSpec(FieldType.json).accepts('{}'), isFalse);
    });
  });

  group('Règles CRM', () {
    Map<String, Object?> org([Map<String, Object?> extra = const {}]) => {
      'name': 'Mairie de Millau',
      'kind': 'commune',
      'status': 'a_prospecter',
      ...extra,
    };

    test('organisation valide', () {
      expect(
        validateOrganisationRecord(
          org({
            'siren': '211201459',
            'siret': '21120145900014',
            'insee_code': '12145',
            'postal_code': '12100',
            'departement_code': '12',
            'website': 'https://www.millau.fr',
            'email': 'contact@millau.fr',
          }),
        ),
        isEmpty,
      );
      expect(validateOrganisationRecord(org({'insee_code': '2A004'})), isEmpty);
    });

    test('organisation : formats refusés', () {
      final fields = {
        for (final i in validateOrganisationRecord(
          org({
            'name': ' ',
            'siren': '12345678',
            'postal_code': '1210',
            'latitude': 120,
            'website': 'www.millau.fr',
            'email': 'pas-un-email',
          }),
        ))
          i.field,
      };
      expect(
        fields,
        containsAll([
          'name',
          'siren',
          'postal_code',
          'latitude',
          'website',
          'email',
        ]),
      );
    });

    test('une organisation ne peut pas être sa propre parente', () {
      final id = newId();
      expect(
        validateOrganisationRecord(org({'id': id, 'parent_id': id})),
        hasLength(1),
      );
    });

    test('mandat : fonction obligatoire et dates ordonnées', () {
      final base = {
        'contact_id': newId(),
        'organisation_id': newId(),
        'is_elected': true,
      };
      expect(validatePositionRecord(base).single.field, 'mandate_role');
      expect(
        validatePositionRecord({
          ...base,
          'mandate_role': 'maire',
          'start_date': '2026-03-01',
          'end_date': '2020-03-01',
        }).single.field,
        'end_date',
      );
    });

    test('champ personnalisé : identifiant et options', () {
      expect(
        validateCustomFieldRecord({
          'key': 'budget_2026',
          'label': 'Budget',
          'type': 'number',
        }),
        isEmpty,
      );
      expect(
        validateCustomFieldRecord({
          'key': 'Budget 2026',
          'label': 'Budget',
          'type': 'select',
        }).map((i) => i.field),
        ['key', 'options'],
      );
    });

    test('affaire : montant et probabilité bornés', () {
      final issues = validateDealRecord({
        'title': 'Navettes',
        'pipeline_id': newId(),
        'stage_id': newId(),
        'amount_cents': -1,
        'probability': 120,
      });
      expect(issues.map((i) => i.field), ['amount_cents', 'probability']);
    });
  });

  test('registre : chaque entité est retrouvée par son nom', () {
    for (final schema in SyncEntities.all) {
      expect(SyncEntities.byName(schema.name), same(schema));
    }
    expect(SyncEntities.all.map((e) => e.name).toSet(), hasLength(18));
  });
}
