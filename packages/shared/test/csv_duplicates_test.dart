import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  group('CSV', () {
    test('export Excel français : ;, guillemets, BOM, CRLF', () {
      const text =
          '﻿Nom;Ville;Notes\r\n'
          'Mairie de Rodez;Rodez;"Contact ; urgent"\r\n'
          '"Office de tourisme ""Aveyron""";Millau;"Ligne 1\nLigne 2"\r\n'
          '\r\n';
      final table = parseCsv(text);
      expect(table.delimiter, ';');
      expect(table.headers, ['Nom', 'Ville', 'Notes']);
      expect(table.rows, [
        ['Mairie de Rodez', 'Rodez', 'Contact ; urgent'],
        ['Office de tourisme "Aveyron"', 'Millau', 'Ligne 1\nLigne 2'],
      ]);
    });

    test('virgule, lignes courtes complétées', () {
      final table = parseCsv('a,b,c\n1,2\n4,5,6,7');
      expect(table.delimiter, ',');
      expect(table.rows, [
        ['1', '2', ''],
        ['4', '5', '6'],
      ]);
    });

    test('tabulation et fichier vide', () {
      expect(parseCsv('a\tb\n1\t2').rows.single, ['1', '2']);
      expect(parseCsv('').headers, isEmpty);
    });
  });

  group('Doublons', () {
    test('normalisation des noms', () {
      expect(
        normalizeName('Mairie de Saint-Affrique'),
        normalizeName('Commune de St Affrique'),
      );
      expect(
        normalizeName("Communauté d'agglomération"),
        'communaute agglomeration',
      );
      expect(searchText('Élodie ÇA'), 'elodie ca');
    });

    test('organisations : SIRET, INSEE par type, nom + lieu', () {
      final orgs = [
        {
          'id': 'a',
          'name': 'Mairie de Rodez',
          'kind': 'commune',
          'insee_code': '12202',
        },
        {'id': 'b', 'name': 'Rodez', 'kind': 'commune', 'insee_code': '12202'},
        {
          'id': 'c',
          'name': 'Office de tourisme',
          'kind': 'office_tourisme',
          'insee_code': '12202',
        },
        {
          'id': 'd',
          'name': 'Festival X',
          'kind': 'festival',
          'postal_code': '12100',
        },
        {
          'id': 'e',
          'name': 'festival x',
          'kind': 'festival',
          'postal_code': '12100',
        },
        {
          'id': 'f',
          'name': 'Festival X',
          'kind': 'festival',
          'postal_code': '31000',
        },
      ];
      final groups = groupDuplicates(orgs, organisationDuplicateKeys);
      expect(groups.map((g) => g.map((o) => o['id']).toList()), [
        ['a', 'b'],
        ['d', 'e'],
      ]);
    });

    test('contacts : email, mobile, nom dans la même organisation', () {
      final contacts = [
        {
          'id': '1',
          'last_name': 'Durand',
          'first_name': 'Anne',
          'email': 'A.Durand@rodez.fr',
        },
        {
          'id': '2',
          'last_name': 'Martin',
          'first_name': 'Paul',
          'email': 'a.durand@rodez.fr',
        },
        {
          'id': '3',
          'last_name': 'Petit',
          'first_name': 'Léa',
          'mobile': '06 12 34 56 78',
        },
        {
          'id': '4',
          'last_name': 'Petit',
          'first_name': 'Lea',
          'mobile': '+33 6 12 34 56 78',
        },
        {
          'id': '5',
          'last_name': 'Roux',
          'first_name': 'Jean',
          'organisation_id': 'o1',
        },
        {
          'id': '6',
          'last_name': 'Roux',
          'first_name': 'Jean',
          'organisation_id': 'o2',
        },
      ];
      final groups = groupDuplicates(contacts, contactDuplicateKeys);
      expect(groups.map((g) => g.map((c) => c['id']).toList()), [
        ['1', '2'],
        ['3', '4'],
      ]);
    });

    test('regroupement transitif', () {
      final groups = groupDuplicates(
        ['a1', 'a2b', 'b3', 'c'],
        (s) => {
          for (final ch in s.split(''))
            if (!RegExp(r'\d').hasMatch(ch)) ch,
        },
      );
      expect(groups.single, ['a1', 'a2b', 'b3']);
    });

    test('fusion : champs vides complétés, champs personnalisés réunis', () {
      final changes = mergeDuplicateFields(
        {
          'name': 'Mairie de Rodez',
          'phone': '',
          'email': null,
          'custom_fields': {'budget': 10},
        },
        [
          {'name': 'Rodez', 'phone': '05 65 00 00 00', 'email': null},
          {
            'email': 'contact@rodez.fr',
            'custom_fields': {'budget': 99, 'contact_prefere': 'email'},
          },
        ],
        ['name', 'phone', 'email', 'custom_fields'],
      );
      expect(changes, {
        'phone': '05 65 00 00 00',
        'email': 'contact@rodez.fr',
        'custom_fields': {'budget': 10, 'contact_prefere': 'email'},
      });
    });
  });
}
