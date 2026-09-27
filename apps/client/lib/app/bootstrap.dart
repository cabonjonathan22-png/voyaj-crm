import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../core/secure_store.dart';
import '../data/local/database.dart';
import '../data/sync/local_clock.dart';

/// Tout ce qui doit être chargé avant le premier affichage.
@immutable
final class Bootstrap {
  const Bootstrap({
    required this.db,
    required this.secureStore,
    required this.clock,
    required this.serverUrl,
    required this.tokens,
    required this.cachedUser,
    required this.themeMode,
    required this.sidebarCollapsed,
  });

  final AppDatabase db;
  final SecureStore secureStore;
  final LocalClock clock;
  final Uri? serverUrl;
  final AuthTokens? tokens;
  final CurrentUser? cachedUser;
  final ThemeMode themeMode;
  final bool sidebarCollapsed;

  static Future<Bootstrap> load() async {
    final secureStore = SecureStore();
    final (key, created) = await secureStore.databaseKey();
    if (created) await _deleteOrphanDatabase();
    final db = AppDatabase.open(encryptionKey: key);

    final serverUrl =
        await db.readSetting<String>(SettingKeys.serverUrl) ??
        _defaultServerUrl();
    final userJson = await db.readSetting<Map<String, dynamic>>(
      SettingKeys.currentUser,
    );
    final theme = await db.readSetting<String>(SettingKeys.themeMode);

    return Bootstrap(
      db: db,
      secureStore: secureStore,
      clock: await LocalClock.load(db),
      serverUrl: serverUrl == null ? null : Uri.parse(serverUrl),
      tokens: await secureStore.readTokens(),
      cachedUser: userJson == null ? null : CurrentUser.fromJson(userJson),
      themeMode:
          ThemeMode.values.where((m) => m.name == theme).firstOrNull ??
          ThemeMode.system,
      sidebarCollapsed:
          await db.readSetting<bool>(SettingKeys.sidebarCollapsed) ?? false,
    );
  }

  /// Adresse du serveur fournie par l'installeur (`voyaj.json` à côté de
  /// l'exécutable) : les utilisateurs n'ont rien à saisir.
  static String? _defaultServerUrl() {
    final file = File(
      p.join(p.dirname(Platform.resolvedExecutable), 'voyaj.json'),
    );
    if (!file.existsSync()) return null;
    try {
      final json = jsonDecode(file.readAsStringSync());
      return json is Map<String, dynamic>
          ? json['server_url'] as String?
          : null;
    } on FormatException {
      return null;
    }
  }

  /// Nouvelle clé (coffre réinitialisé) : une ancienne base serait
  /// illisible. Elle ne contient que des données déjà présentes sur le
  /// serveur ou non envoyées ; on repart d'une base vide.
  static Future<void> _deleteOrphanDatabase() async {
    final dir = await getApplicationSupportDirectory();
    for (final suffix in ['', '-wal', '-shm', '-journal']) {
      final file = File(p.join(dir.path, 'voyaj.sqlite$suffix'));
      if (file.existsSync()) await file.delete();
    }
  }
}
