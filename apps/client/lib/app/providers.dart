import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../core/api_client.dart';
import '../core/secure_store.dart';
import '../data/local/database.dart';
import '../data/sync/local_clock.dart';
import '../data/sync/sync_engine.dart';
import '../design_system/design_system.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/auth_state.dart';
import '../features/tags/tags_repository.dart';
import 'bootstrap.dart';

/// Données chargées au démarrage (remplacé dans `main`).
final bootstrapProvider = Provider<Bootstrap>(
  (ref) => throw UnimplementedError('bootstrapProvider non initialisé'),
);

final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => ref.watch(bootstrapProvider).db,
);

final secureStoreProvider = Provider<SecureStore>(
  (ref) => ref.watch(bootstrapProvider).secureStore,
);

final localClockProvider = Provider<LocalClock>(
  (ref) => ref.watch(bootstrapProvider).clock,
);

final toastProvider = Provider<ToastController>((ref) {
  final controller = ToastController();
  ref.onDispose(controller.dispose);
  return controller;
});

// ── Session ──────────────────────────────────────────────────────────────

/// Jetons de session en mémoire, persistés dans le coffre sécurisé.
final class TokenStore {
  TokenStore(this._secure, this._tokens);

  final SecureStore _secure;
  AuthTokens? _tokens;

  AuthTokens? get current => _tokens;

  Future<void> save(AuthTokens tokens) async {
    _tokens = tokens;
    await _secure.writeTokens(tokens);
  }

  Future<void> clear() async {
    _tokens = null;
    await _secure.clearTokens();
  }
}

final tokenStoreProvider = Provider<TokenStore>(
  (ref) => TokenStore(
    ref.watch(secureStoreProvider),
    ref.watch(bootstrapProvider).tokens,
  ),
);

final authProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

final currentUserProvider = Provider<CurrentUser?>((ref) {
  final state = ref.watch(authProvider);
  return state is AuthSignedIn ? state.user : null;
});

/// Indique si l'utilisateur connecté a [Permission].
final permissionProvider = Provider.family<bool, Permission>(
  (ref, permission) =>
      ref.watch(currentUserProvider)?.permissions.contains(permission.key) ??
      false,
);

// ── Serveur et synchronisation ──────────────────────────────────────────

final serverUrlProvider = NotifierProvider<ServerUrlController, Uri?>(
  ServerUrlController.new,
);

final class ServerUrlController extends Notifier<Uri?> {
  @override
  Uri? build() => ref.read(bootstrapProvider).serverUrl;

  Future<void> set(Uri url) async {
    await ref
        .read(appDatabaseProvider)
        .writeSetting(SettingKeys.serverUrl, url.toString());
    state = url;
  }
}

final apiClientProvider = Provider<ApiClient?>((ref) {
  final url = ref.watch(serverUrlProvider);
  if (url == null) return null;
  final tokens = ref.watch(tokenStoreProvider);
  final client = ApiClient(
    baseUri: url,
    loadTokens: () async => tokens.current,
    saveTokens: tokens.save,
    onSessionLost: (failure) =>
        ref.read(authProvider.notifier).sessionLost(failure.message),
  );
  ref.onDispose(client.close);
  return client;
});

final syncEngineProvider = Provider<SyncEngine?>((ref) {
  final userId = ref.watch(currentUserProvider.select((u) => u?.id));
  final api = ref.watch(apiClientProvider);
  if (userId == null || api == null) return null;
  final engine = SyncEngine(
    db: ref.watch(appDatabaseProvider),
    api: api,
    clock: ref.watch(localClockProvider),
    onSessionLost: () => ref
        .read(authProvider.notifier)
        .sessionLost('Votre session a expiré. Reconnectez-vous.'),
  )..start();
  ref.onDispose(() => unawaited(engine.dispose()));
  return engine;
});

final syncStatusProvider = StreamProvider<SyncStatus>((ref) async* {
  final engine = ref.watch(syncEngineProvider);
  if (engine == null) {
    yield const SyncStatus();
    return;
  }
  yield engine.status;
  yield* engine.statusStream;
});

final pendingOperationsProvider = StreamProvider<int>(
  (ref) => ref.watch(appDatabaseProvider).watchPendingCount(),
);

/// Enregistrements d'une entité en attente d'envoi.
final pendingIdsProvider = StreamProvider.family<Set<String>, String>(
  (ref, entity) => ref.watch(appDatabaseProvider).watchPendingIds(entity),
);

// ── Données ──────────────────────────────────────────────────────────────

final tagsRepositoryProvider = Provider<TagsRepository>(
  (ref) => TagsRepository(
    db: ref.watch(appDatabaseProvider),
    clock: ref.watch(localClockProvider),
    currentUserId: ref.watch(currentUserProvider.select((u) => u?.id)),
    onChanged: () => ref.read(syncEngineProvider)?.notifyLocalChange(),
  ),
);

final tagsProvider = StreamProvider<List<Tag>>(
  (ref) => ref.watch(tagsRepositoryProvider).watchAll(),
);

// ── Préférences ──────────────────────────────────────────────────────────

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);

final class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(bootstrapProvider).themeMode;

  void set(ThemeMode mode) {
    state = mode;
    unawaited(
      ref
          .read(appDatabaseProvider)
          .writeSetting(SettingKeys.themeMode, mode.name),
    );
  }

  /// Bascule clair ↔ sombre (en partant du thème effectivement affiché).
  void toggle(Brightness current) =>
      set(current == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
}

final sidebarCollapsedProvider = NotifierProvider<SidebarController, bool>(
  SidebarController.new,
);

final class SidebarController extends Notifier<bool> {
  @override
  bool build() => ref.read(bootstrapProvider).sidebarCollapsed;

  void toggle() {
    state = !state;
    unawaited(
      ref
          .read(appDatabaseProvider)
          .writeSetting(SettingKeys.sidebarCollapsed, state),
    );
  }
}

/// Configuration d'affichage d'un tableau, mémorisée par poste.
final tableViewProvider =
    NotifierProvider.family<TableViewController, TableViewConfig, String>(
      TableViewController.new,
    );

final class TableViewController extends Notifier<TableViewConfig> {
  TableViewController(this.tableId);

  final String tableId;
  Timer? _save;

  @override
  TableViewConfig build() {
    ref.onDispose(() => _save?.cancel());
    unawaited(_load());
    return const TableViewConfig();
  }

  Future<void> _load() async {
    final json = await ref
        .read(appDatabaseProvider)
        .readSetting<Map<String, dynamic>>(SettingKeys.tableView(tableId));
    if (json != null && ref.mounted) state = TableViewConfig.fromJson(json);
  }

  void set(TableViewConfig config) {
    state = config;
    _save?.cancel();
    _save = Timer(const Duration(milliseconds: 500), () {
      unawaited(
        ref
            .read(appDatabaseProvider)
            .writeSetting(SettingKeys.tableView(tableId), config.toJson()),
      );
    });
  }
}

/// Vues enregistrées d'un tableau.
final savedViewsProvider =
    NotifierProvider.family<SavedViewsController, List<SavedTableView>, String>(
      SavedViewsController.new,
    );

final class SavedViewsController extends Notifier<List<SavedTableView>> {
  SavedViewsController(this.tableId);

  final String tableId;

  @override
  List<SavedTableView> build() {
    unawaited(_load());
    return const [];
  }

  Future<void> _load() async {
    final json = await ref
        .read(appDatabaseProvider)
        .readSetting<List<dynamic>>(SettingKeys.savedViews(tableId));
    if (json != null && ref.mounted) {
      state = [
        for (final v in json)
          SavedTableView.fromJson(v as Map<String, dynamic>),
      ];
    }
  }

  void set(List<SavedTableView> views) {
    state = views;
    unawaited(
      ref.read(appDatabaseProvider).writeSetting(
        SettingKeys.savedViews(tableId),
        [for (final v in views) v.toJson()],
      ),
    );
  }
}
