import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/app/bootstrap.dart';
import 'package:voyaj_client/core/secure_store.dart';
import 'package:voyaj_client/data/local/database.dart';
import 'package:voyaj_client/data/sync/local_clock.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

final testUser = CurrentUser(
  id: '01a0e2e2-342f-724e-8b9a-9d12d8be87cd',
  email: 'camille.martin@voyaj.fr',
  displayName: 'Camille Martin',
  totpEnabled: true,
  roles: ['admin'],
  permissions: [for (final p in Permission.values) p.key],
);

/// Démarrage de test : base en mémoire, coffre simulé, utilisateur connecté.
Future<Bootstrap> testBootstrap({ThemeMode themeMode = ThemeMode.light}) async {
  FlutterSecureStorage.setMockInitialValues({});
  final db = AppDatabase(NativeDatabase.memory());
  final now = DateTime.now().toUtc();
  return Bootstrap(
    db: db,
    secureStore: SecureStore(),
    clock: await LocalClock.load(db),
    serverUrl: Uri.parse('http://localhost:1'),
    tokens: AuthTokens(
      sessionId: newId(),
      accessToken: 'a',
      accessExpiresAt: now.add(const Duration(hours: 1)),
      refreshToken: 'r',
      refreshExpiresAt: now.add(const Duration(days: 1)),
    ),
    cachedUser: testUser,
    themeMode: themeMode,
    sidebarCollapsed: false,
  );
}

/// Charge Inter et les icônes Lucide (sinon les tests affichent des
/// rectangles).
Future<void> loadFonts() async {
  final inter = FontLoader('Inter')
    ..addFont(rootBundle.load('assets/fonts/InterVariable.ttf'));
  final lucide = FontLoader('packages/lucide_icons_flutter/Lucide')
    ..addFont(
      rootBundle.load('packages/lucide_icons_flutter/assets/lucide.ttf'),
    );
  await Future.wait([inter.load(), lucide.load()]);
}

/// Enregistre une capture PNG si `VOYAJ_SCREENSHOTS` désigne un dossier.
Future<void> captureScreenshot(WidgetTester tester, String name) async {
  final dir = Platform.environment['VOYAJ_SCREENSHOTS'];
  if (dir == null) return;
  final boundary =
      tester.renderObject(find.byType(RepaintBoundary).first)
          as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    await File('$dir/$name.png').writeAsBytes(bytes!.buffer.asUint8List());
  });
}
