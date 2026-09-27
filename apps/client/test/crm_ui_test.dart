import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/app/app.dart';
import 'package:voyaj_client/app/bootstrap.dart';
import 'package:voyaj_client/app/providers.dart';
import 'package:voyaj_client/app/router.dart';
import 'package:voyaj_client/design_system/design_system.dart';
import 'package:voyaj_client/features/crm/map/map_page.dart';

import 'support/crm_seed.dart';
import 'support/fake_api.dart';
import 'support/test_app.dart';

/// Parcours utilisateur dans les écrans du CRM.
void main() {
  setUpAll(loadFonts);

  Future<(ProviderContainer, Bootstrap)> start(
    WidgetTester tester,
    String route, {
    bool online = false,
  }) async {
    tester.view
      ..physicalSize = const Size(1440, 900)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final boot = (await tester.runAsync(() async {
      final boot = await testBootstrap();
      await seedCrm(boot.db);
      return boot;
    }))!;
    final container = ProviderContainer(
      overrides: [
        bootstrapProvider.overrideWithValue(boot),
        syncEngineProvider.overrideWithValue(null),
        mapTilesEnabledProvider.overrideWithValue(false),
        if (online) apiClientProvider.overrideWithValue(fakeApi(boot)),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const VoyajApp()),
    );
    container.read(routerProvider).go(route);
    await settle(tester);
    return (container, boot);
  }

  Future<void> stop(
    WidgetTester tester,
    ProviderContainer container,
    Bootstrap boot,
  ) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    container.dispose();
    // Écritures encore en file dans la zone de test : on les laisse finir.
    await settle(tester);
    await tester.runAsync(boot.db.close);
  }

  testWidgets('création d’une organisation depuis la liste', (tester) async {
    final (container, boot) = await start(tester, Routes.organisations);

    await tester.tap(find.text('Nouvelle organisation').first);
    await settle(tester);
    expect(find.byType(VModal), findsOneWidget);

    // Nom vide : erreur de validation, rien n'est créé.
    await tester.tap(find.text('Créer'));
    await settle(tester);
    expect(find.text('Le nom est obligatoire.'), findsOneWidget);

    final nameField = find.byWidgetPredicate(
      (w) => w is TextField && w.autofocus,
    );
    expect(nameField, findsOneWidget);
    await tester.enterText(nameField, 'Mairie de Villefranche');
    await tester.tap(find.text('Créer'));
    await settle(tester);

    expect(find.byType(VModal), findsNothing);
    expect(
      container.read(routerProvider).state.matchedLocation,
      startsWith('${Routes.organisations}/'),
    );
    expect(find.text('Mairie de Villefranche'), findsWidgets);
    final created = await tester.runAsync(
      () => boot.db.select(boot.db.organisations).get(),
    );
    final org = created!.firstWhere((o) => o.name == 'Mairie de Villefranche');
    expect(org.kind, 'commune');
    expect(org.status, 'a_prospecter');
    expect(org.ownerId, testUser.id);

    await stop(tester, container, boot);
  });

  testWidgets('Kanban : une affaire glissée change d’étape', (tester) async {
    final (container, boot) = await start(tester, Routes.pipelines);

    final card = find.text('Desserte festival');
    final target = find.text('Proposition envoyée');
    expect(card, findsOneWidget);
    final gesture = await tester.startGesture(tester.getCenter(card));
    await tester.pump(const Duration(milliseconds: 100));
    final end = tester.getCenter(target) + const Offset(0, 200);
    final startPoint = tester.getCenter(card);
    for (var i = 1; i <= 10; i++) {
      await gesture.moveTo(Offset.lerp(startPoint, end, i / 10)!);
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await settle(tester);

    final deal = await tester.runAsync(
      () => (boot.db.select(
        boot.db.deals,
      )..where((t) => t.id.equals(sid('deal-3')))).getSingle(),
    );
    expect(deal!.stageId, sid('st-3'));
    expect(deal.probability, 60);

    await stop(tester, container, boot);
  });

  testWidgets('facture créée depuis la fiche avec le catalogue', (
    tester,
  ) async {
    final (container, boot) = await start(
      tester,
      '${Routes.organisations}/${sid('org-2')}',
    );
    await tester.tap(find.text('Factures'));
    await settle(tester);
    await tester.tap(find.text('Nouvelle facture'));
    await settle(tester);
    expect(find.byType(VModal), findsOneWidget);

    await tester.enterText(
      find.byWidgetPredicate((w) => w is TextField && w.autofocus),
      'Transport du festival',
    );
    await tester.tap(find.text('Depuis le catalogue'));
    await settle(tester);
    await tester.tap(find.textContaining('Accompagnement guide'));
    await settle(tester);
    await tester.tap(find.text('Créer'));
    await settle(tester);

    final invoices = await tester.runAsync(
      () => boot.db.select(boot.db.invoices).get(),
    );
    final created = invoices!.singleWhere(
      (i) => i.subject == 'Transport du festival',
    );
    expect(created.kind, 'invoice');
    expect(created.status, 'draft');
    expect(created.organisationId, sid('org-2'));
    expect(created.lines, contains('"unit_price_cents":25000'));
    // Fiche du brouillon ouverte après création.
    expect(find.text('Émettre'), findsOneWidget);

    await stop(tester, container, boot);
  });

  testWidgets('devis accepté transformé en facture', (tester) async {
    final (container, boot) = await start(tester, Routes.billing);
    await tester.tap(find.text('Devis').first);
    await settle(tester);
    await tester.tap(find.text('D2026-00001'));
    await settle(tester);
    await tester.tap(find.text('Facturer'));
    await settle(tester);

    final invoices = await tester.runAsync(
      () => boot.db.select(boot.db.invoices).get(),
    );
    final created = invoices!.singleWhere(
      (i) => i.quoteId == sid('inv-1') && i.number == null,
    );
    expect(created.kind, 'invoice');
    expect(created.number, isNull);
    expect(created.lines, contains('Navette estivale'));

    await stop(tester, container, boot);
  });

  testWidgets('éditeur de connecteur : champs selon le type', (tester) async {
    final (container, boot) = await start(
      tester,
      Routes.connectors,
      online: true,
    );
    await tester.tap(find.text('Nouveau connecteur'));
    await settle(tester);
    expect(find.byType(VModal), findsOneWidget);
    expect(find.text('Mappage'), findsOneWidget);
    expect(find.text('Chemin de la liste dans la réponse'), findsOneWidget);

    await tester.tap(find.text('API REST (JSON)'));
    await settle(tester);
    await tester.tap(find.text('MySQL / MariaDB').last);
    await settle(tester);
    expect(find.text('Requête SELECT'), findsOneWidget);
    expect(find.text('Connexion chiffrée (TLS)'), findsOneWidget);

    await stop(tester, container, boot);
  });
}

/// Laisse les écritures (base réelle) et animations se terminer.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 30)),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }
}
