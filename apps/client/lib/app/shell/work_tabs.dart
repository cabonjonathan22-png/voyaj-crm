import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../providers.dart';

/// Type de fiche ouverte dans un onglet.
enum WorkTabKind {
  organisation(LucideIcons.building2),
  contact(LucideIcons.user);

  const WorkTabKind(this.icon);

  final IconData icon;
}

/// Fiche ouverte (onglet de travail).
@immutable
final class WorkTab {
  const WorkTab({required this.route, required this.title, required this.kind});

  factory WorkTab.fromJson(Map<String, dynamic> json) => WorkTab(
    route: json['route'] as String,
    title: json['title'] as String,
    kind: WorkTabKind.values.byName(json['kind'] as String),
  );

  final String route;
  final String title;
  final WorkTabKind kind;

  Map<String, dynamic> toJson() => {
    'route': route,
    'title': title,
    'kind': kind.name,
  };
}

/// Nombre maximal d'onglets : le plus ancien est fermé au-delà.
const maxWorkTabs = 12;

/// Onglets de travail, mémorisés par poste.
final workTabsProvider = NotifierProvider<WorkTabsController, List<WorkTab>>(
  WorkTabsController.new,
);

final class WorkTabsController extends Notifier<List<WorkTab>> {
  @override
  List<WorkTab> build() {
    unawaited(_load());
    return const [];
  }

  Future<void> _load() async {
    final json = await ref
        .read(appDatabaseProvider)
        .readSetting<List<dynamic>>(SettingKeys.workTabs);
    if (json == null || !ref.mounted || state.isNotEmpty) return;
    state = [
      for (final t in json)
        if (WorkTabKind.values.any((k) => k.name == (t as Map)['kind']))
          WorkTab.fromJson(t as Map<String, dynamic>),
    ];
  }

  void _set(List<WorkTab> tabs) {
    state = tabs;
    unawaited(
      ref.read(appDatabaseProvider).writeSetting(SettingKeys.workTabs, [
        for (final t in tabs) t.toJson(),
      ]),
    );
  }

  /// Ouvre (ou met à jour le titre de) l'onglet de [tab.route].
  void open(WorkTab tab) {
    final index = state.indexWhere((t) => t.route == tab.route);
    if (index >= 0) {
      if (state[index].title != tab.title) {
        _set([...state]..[index] = tab);
      }
      return;
    }
    final tabs = [...state, tab];
    _set(tabs.length > maxWorkTabs ? tabs.sublist(1) : tabs);
  }

  /// Ferme l'onglet ; retourne la route voisine à afficher s'il était
  /// actif, ou `null`.
  String? close(String route, {required String? current}) {
    final index = state.indexWhere((t) => t.route == route);
    if (index < 0) return null;
    final tabs = [...state]..removeAt(index);
    _set(tabs);
    if (route != current) return null;
    if (tabs.isEmpty) return '';
    return tabs[index.clamp(0, tabs.length - 1)].route;
  }

  void closeAll() => _set(const []);
}

/// Barre des onglets de travail (au-dessus du contenu).
class WorkTabsBar extends ConsumerWidget {
  const WorkTabsBar({
    super.key,
    required this.location,
    required this.fallback,
  });

  final String location;

  /// Route affichée quand le dernier onglet actif est fermé.
  final String Function(WorkTab closed) fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final tabs = ref.watch(workTabsProvider);
    if (tabs.isEmpty) return const SizedBox.shrink();

    void close(WorkTab tab) {
      final next = ref
          .read(workTabsProvider.notifier)
          .close(tab.route, current: location);
      if (next == null) return;
      context.go(next.isEmpty ? fallback(tab) : next);
    }

    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: c.backgroundSubtle,
        border: Border(bottom: BorderSide(color: c.border)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: VSpace.x2),
        children: [
          for (final tab in tabs)
            _TabItem(
              tab: tab,
              active: location == tab.route,
              onOpen: () => context.go(tab.route),
              onClose: () => close(tab),
            ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.tab,
    required this.active,
    required this.onOpen,
    required this.onClose,
  });

  final WorkTab tab;
  final bool active;
  final VoidCallback onOpen;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onPressed: onOpen,
      semanticLabel: tab.title,
      builder: (context, s) => AnimatedContainer(
        duration: VMotion.fast,
        constraints: const BoxConstraints(maxWidth: 220),
        margin: const EdgeInsets.only(top: 4, right: 2),
        padding: const EdgeInsets.only(left: VSpace.x2 + 2, right: 2),
        decoration: BoxDecoration(
          color: active
              ? c.background
              : s.hovered
              ? c.surfaceHover
              : Colors.transparent,
          // Bordures de couleurs différentes : pas de coins arrondis possibles.
          borderRadius: active
              ? null
              : const BorderRadius.vertical(top: Radius.circular(VRadius.sm)),
          border: active
              ? Border(
                  top: BorderSide(color: c.accent, width: 2),
                  left: BorderSide(color: c.border),
                  right: BorderSide(color: c.border),
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(tab.kind.icon, size: 13, color: c.textMuted),
            const SizedBox(width: VSpace.x1_5),
            Flexible(
              child: Text(
                tab.title,
                overflow: TextOverflow.ellipsis,
                style: context.text.small.copyWith(
                  color: active ? c.text : c.textMuted,
                ),
              ),
            ),
            const SizedBox(width: VSpace.x1),
            Opacity(
              opacity: active || s.hovered ? 1 : 0,
              child: VIconButton(
                icon: LucideIcons.x,
                tooltip: 'Fermer (Ctrl W)',
                size: VButtonSize.sm,
                onPressed: onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
