import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/app/app.dart';
import 'package:voyaj_client/app/providers.dart';
import 'package:voyaj_client/app/router.dart';
import 'package:voyaj_client/data/local/database.dart';
import 'package:voyaj_client/features/crm/map/map_page.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/crm_seed.dart';
import 'support/test_app.dart';

/// Rend chaque écran (thèmes clair et sombre) et vérifie qu'aucune
/// exception n'est levée. Avec `VOYAJ_SCREENSHOTS=<dossier>`, enregistre une
/// capture de chaque écran (revue visuelle).
void main() {
  setUpAll(loadFonts);

  final screens = {
    'organisations': Routes.organisations,
    'organisation_new': '${Routes.organisations}?new=1',
    'organisation_detail': '${Routes.organisations}/${sid('org-1')}',
    'contacts': Routes.contacts,
    'contact_detail': '${Routes.contacts}/${sid('ct-2')}',
    'elected': Routes.elected,
    'pipelines': Routes.pipelines,
    'tasks': Routes.tasks,
    'map': Routes.map,
    'duplicates': Routes.duplicates,
    'settings_custom_fields': '${Routes.settings}/customFields',
    'tags': Routes.tags,
    'tag_detail': '${Routes.tags}?id=tag-1',
    'tag_new': '${Routes.tags}?new=1',
    'sync': Routes.sync,
    'settings_appearance': '${Routes.settings}/appearance',
    'settings_security': '${Routes.settings}/security',
    'settings_server': '${Routes.settings}/server',
    'users': Routes.users,
    'roles': Routes.roles,
    'audit': Routes.audit,
    'design_system': Routes.designSystem,
  };

  for (final theme in [ThemeMode.light, ThemeMode.dark]) {
    for (final MapEntry(key: name, value: route) in screens.entries) {
      testWidgets('écran $name (${theme.name})', (tester) async {
        tester.view
          ..physicalSize = const Size(1440, 900)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        final boot = (await tester.runAsync(() async {
          final boot = await testBootstrap(themeMode: theme);
          await _seed(boot.db);
          await seedCrm(boot.db);
          return boot;
        }))!;
        final container = ProviderContainer(
          overrides: [
            bootstrapProvider.overrideWithValue(boot),
            syncEngineProvider.overrideWithValue(null),
            mapTilesEnabledProvider.overrideWithValue(false),
          ],
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const RepaintBoundary(child: VoyajApp()),
          ),
        );
        container.read(routerProvider).go(route);
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(tester.takeException(), isNull);
        await captureScreenshot(tester, '${name}_${theme.name}');

        await tester.pumpWidget(const SizedBox());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        await tester.pump(const Duration(seconds: 1));
        await tester.runAsync(boot.db.close);
      });
    }
  }
}

Future<void> _seed(AppDatabase db) async {
  final now = DateTime.now().toUtc();
  final samples = [
    ('tag-1', 'Prioritaire', '#EF4444', 'Collectivités à contacter ce mois-ci'),
    ('tag-2', 'Festival 2026', '#F59E0B', 'Éditions prévues en 2026'),
    ('tag-3', 'AOM', '#6366F1', 'Autorités organisatrices de la mobilité'),
    ('tag-4', 'Occitanie', '#10B981', null),
    ('tag-5', 'Relance', '#0EA5E9', 'Sans réponse depuis 30 jours'),
    ('tag-6', 'Partenaire', '#A855F7', 'Offices de tourisme, associations'),
  ];
  for (final (i, (id, name, color, description)) in samples.indexed) {
    await db
        .into(db.tags)
        .insert(
          TagsCompanion.insert(
            id: id,
            name: name,
            color: color,
            description: Value(description),
            version: Value(i == 4 ? 0 : 3),
            createdAt: now.subtract(Duration(days: 10 + i)),
            updatedAt: now.subtract(Duration(hours: i * 7)),
          ),
        );
  }
  await db
      .into(db.outbox)
      .insert(
        OutboxCompanion.insert(
          opId: newId(),
          entity: 'tags',
          entityId: 'tag-5',
          baseVersion: 0,
          hlc: const Hlc(1, 0, 'n').toString(),
          fields: '{"name":"Relance"}',
          createdAt: now,
        ),
      );
}
