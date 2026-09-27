import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../core/format.dart';
import '../../data/sync/sync_engine.dart';
import '../../design_system/design_system.dart';
import '../../features/settings/settings_page.dart';
import '../app.dart';
import '../commands/command_palette.dart';
import '../providers.dart';
import '../router.dart';
import 'shortcuts_help.dart';

/// Mise en page principale : barre latérale + contenu, raccourcis globaux.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final collapsed = ref.watch(sidebarCollapsedProvider);

    void go(String route) => context.go(route);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): () =>
            unawaited(showCommandPalette(context)),
        const SingleActivator(LogicalKeyboardKey.keyB, control: true): () =>
            ref.read(sidebarCollapsedProvider.notifier).toggle(),
        const SingleActivator(
          LogicalKeyboardKey.keyL,
          control: true,
          shift: true,
        ): () => ref
            .read(themeModeProvider.notifier)
            .toggle(Theme.of(context).brightness),
        const SingleActivator(LogicalKeyboardKey.f5): () =>
            unawaited(ref.read(syncEngineProvider)?.syncNow()),
        const SingleActivator(LogicalKeyboardKey.f1): () =>
            unawaited(showShortcutsHelp(context)),
        const SingleActivator(LogicalKeyboardKey.digit1, control: true): () =>
            go(Routes.tags),
        const SingleActivator(LogicalKeyboardKey.digit2, control: true): () =>
            go(Routes.sync),
        const SingleActivator(LogicalKeyboardKey.comma, control: true): () =>
            go(Routes.settings),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          backgroundColor: c.background,
          body: Row(
            children: [
              AnimatedContainer(
                duration: VMotion.normal,
                curve: VMotion.curve,
                width: collapsed ? VSize.sidebarCollapsed : VSize.sidebar,
                child: _Sidebar(location: location, collapsed: collapsed),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label, this.route, {this.shortcut});

  final IconData icon;
  final String label;
  final String route;
  final String? shortcut;
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.location, required this.collapsed});

  final String location;
  final bool collapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final t = context.text;
    final l10n = context.l10n;
    bool can(Permission p) => ref.watch(permissionProvider(p));

    final workspace = [
      _NavItem(LucideIcons.tags, l10n.navTags, Routes.tags, shortcut: 'Ctrl 1'),
      _NavItem(
        LucideIcons.refreshCw,
        l10n.navSync,
        Routes.sync,
        shortcut: 'Ctrl 2',
      ),
    ];
    final admin = [
      if (can(Permission.userRead))
        _NavItem(LucideIcons.users, l10n.navUsers, Routes.users),
      if (can(Permission.userRead))
        _NavItem(LucideIcons.shieldCheck, l10n.navRoles, Routes.roles),
      if (can(Permission.auditRead))
        _NavItem(LucideIcons.scrollText, l10n.navAudit, Routes.audit),
    ];

    return Container(
      decoration: BoxDecoration(
        color: c.backgroundSubtle,
        border: Border(right: BorderSide(color: c.border)),
      ),
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: collapsed ? VSize.sidebarCollapsed : VSize.sidebar,
          maxWidth: collapsed ? VSize.sidebarCollapsed : VSize.sidebar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 52,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: VSpace.x3),
                  child: Row(
                    children: [
                      if (collapsed)
                        Tooltip(
                          message: '${l10n.expandSidebar} (Ctrl B)',
                          child: Pressable(
                            onPressed: () => ref
                                .read(sidebarCollapsedProvider.notifier)
                                .toggle(),
                            builder: (context, _) => const _Logo(),
                          ),
                        )
                      else
                        const _Logo(),
                      if (!collapsed) ...[
                        const SizedBox(width: VSpace.x2 + 2),
                        Expanded(child: Text('Voyaj CRM', style: t.heading)),
                        VIconButton(
                          icon: LucideIcons.panelLeftClose,
                          tooltip: '${l10n.collapseSidebar} (Ctrl B)',
                          size: VButtonSize.sm,
                          onPressed: () => ref
                              .read(sidebarCollapsedProvider.notifier)
                              .toggle(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  VSpace.x2,
                  0,
                  VSpace.x2,
                  VSpace.x2,
                ),
                child: _SearchButton(collapsed: collapsed),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: VSpace.x2),
                  children: [
                    for (final item in workspace)
                      _NavTile(
                        item: item,
                        location: location,
                        collapsed: collapsed,
                      ),
                    if (admin.isNotEmpty) ...[
                      _SectionLabel(l10n.sectionAdmin, collapsed: collapsed),
                      for (final item in admin)
                        _NavTile(
                          item: item,
                          location: location,
                          collapsed: collapsed,
                        ),
                    ],
                    if (kDebugMode) ...[
                      _SectionLabel(
                        l10n.sectionDevelopment,
                        collapsed: collapsed,
                      ),
                      _NavTile(
                        item: _NavItem(
                          LucideIcons.palette,
                          l10n.navDesignSystem,
                          Routes.designSystem,
                        ),
                        location: location,
                        collapsed: collapsed,
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(VSpace.x2),
                child: Column(
                  children: [
                    _SyncIndicator(collapsed: collapsed),
                    const SizedBox(height: VSpace.x1),
                    _NavTile(
                      item: _NavItem(
                        LucideIcons.settings,
                        l10n.navSettings,
                        Routes.settings,
                        shortcut: 'Ctrl ,',
                      ),
                      location: location,
                      collapsed: collapsed,
                    ),
                    _UserMenu(collapsed: collapsed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [c.accent, c.accentHover],
        ),
        borderRadius: VRadius.smAll,
      ),
      alignment: Alignment.center,
      child: const Text(
        'V',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 15,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({required this.collapsed});

  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Tooltip(
      message: collapsed ? '${context.l10n.search} (Ctrl K)' : '',
      child: Pressable(
        onPressed: () => unawaited(showCommandPalette(context)),
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: VSpace.x2 + 2),
          decoration: BoxDecoration(
            color: s.hovered ? c.surfaceHover : c.surface,
            borderRadius: VRadius.smAll,
            border: Border.all(color: s.focused ? c.focusRing : c.border),
          ),
          child: Row(
            children: [
              Icon(LucideIcons.search, size: 15, color: c.textSubtle),
              if (!collapsed) ...[
                const SizedBox(width: VSpace.x2),
                Expanded(
                  child: Text(
                    context.l10n.search,
                    style: context.text.body.copyWith(color: c.textSubtle),
                  ),
                ),
                const Kbd('Ctrl K'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label, {required this.collapsed});

  final String label;
  final bool collapsed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      VSpace.x2,
      VSpace.x4,
      VSpace.x2,
      VSpace.x1_5,
    ),
    child: collapsed
        ? Divider(height: 1, color: context.colors.border)
        : Text(
            label.toUpperCase(),
            style: context.text.caption.copyWith(
              color: context.colors.textSubtle,
              letterSpacing: 0.6,
            ),
          ),
  );
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.location,
    required this.collapsed,
  });

  final _NavItem item;
  final String location;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final active = location.startsWith(item.route);
    final tile = Pressable(
      onPressed: () => context.go(item.route),
      semanticLabel: item.label,
      builder: (context, s) => AnimatedContainer(
        duration: VMotion.fast,
        height: 32,
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: VSpace.x2 + 2),
        decoration: BoxDecoration(
          color: active
              ? c.surfaceSelected
              : s.hovered
              ? c.surfaceHover
              : Colors.transparent,
          borderRadius: VRadius.smAll,
          border: s.focused ? Border.all(color: c.focusRing, width: 2) : null,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 16,
              color: active ? c.accentText : c.textMuted,
            ),
            if (!collapsed) ...[
              const SizedBox(width: VSpace.x2 + 2),
              Expanded(
                child: Text(
                  item.label,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodyStrong.copyWith(
                    color: active ? c.text : c.textMuted,
                  ),
                ),
              ),
              if (s.hovered && item.shortcut != null) Kbd(item.shortcut!),
            ],
          ],
        ),
      ),
    );
    return collapsed
        ? Tooltip(
            message: item.shortcut == null
                ? item.label
                : '${item.label} (${item.shortcut})',
            child: tile,
          )
        : tile;
  }
}

class _SyncIndicator extends ConsumerWidget {
  const _SyncIndicator({required this.collapsed});

  final bool collapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final l10n = context.l10n;
    final status = ref.watch(syncStatusProvider).value ?? const SyncStatus();
    final pending = ref.watch(pendingOperationsProvider).value ?? 0;

    final (color, label) = switch (status.connection) {
      _ when status.syncing => (c.accent, l10n.syncSyncing),
      SyncConnection.online => (c.success, l10n.syncOnline),
      SyncConnection.connecting => (c.warning, l10n.syncConnecting),
      SyncConnection.offline => (c.textSubtle, l10n.syncOffline),
    };
    final details = [
      label,
      if (pending > 0) l10n.syncPending(pending),
      if (status.lastSyncAt != null)
        l10n.syncLastAt(formatRelative(status.lastSyncAt!)),
      ?status.lastError,
    ].join(' · ');

    return Tooltip(
      message: details,
      child: Pressable(
        onPressed: () => context.go(Routes.sync),
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: VSpace.x2 + 2),
          decoration: BoxDecoration(
            color: s.hovered ? c.surfaceHover : Colors.transparent,
            borderRadius: VRadius.smAll,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                child: Center(
                  child: status.syncing
                      ? VSpinner(size: 11, color: color)
                      : Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            boxShadow:
                                status.connection == SyncConnection.online
                                ? [
                                    BoxShadow(
                                      color: color.withValues(alpha: 0.4),
                                      blurRadius: 6,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                ),
              ),
              if (!collapsed) ...[
                const SizedBox(width: VSpace.x2 + 2),
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.small,
                  ),
                ),
                if (pending > 0)
                  VBadge('$pending', tone: VTone.warning)
                else if (status.lastError != null)
                  Icon(LucideIcons.circleAlert, size: 14, color: c.danger),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _UserMenu extends ConsumerWidget {
  const _UserMenu({required this.collapsed});

  final bool collapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final l10n = context.l10n;
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final dark = Theme.of(context).brightness == Brightness.dark;

    return MenuAnchor(
      alignmentOffset: const Offset(0, -4),
      menuChildren: buildMenuItems(context, [
        VMenuItem(
          label: l10n.menuSecurity,
          icon: LucideIcons.shieldCheck,
          onSelected: () =>
              context.go('${Routes.settings}/${SettingsSection.security.name}'),
        ),
        VMenuItem(
          label: dark ? l10n.themeLight : l10n.themeDark,
          icon: dark ? LucideIcons.sun : LucideIcons.moon,
          shortcut: 'Ctrl Maj L',
          onSelected: () => ref
              .read(themeModeProvider.notifier)
              .toggle(Theme.of(context).brightness),
        ),
        VMenuItem(
          label: l10n.shortcutsHelp,
          icon: LucideIcons.keyboard,
          shortcut: 'F1',
          onSelected: () => unawaited(showShortcutsHelp(context)),
        ),
        VMenuItem(
          label: l10n.signOut,
          icon: LucideIcons.logOut,
          dividerBefore: true,
          onSelected: () => unawaited(ref.read(authProvider.notifier).logout()),
        ),
      ]),
      builder: (context, controller, _) => Pressable(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: VSpace.x1_5 + 1),
          decoration: BoxDecoration(
            color: s.hovered || controller.isOpen
                ? c.surfaceHover
                : Colors.transparent,
            borderRadius: VRadius.smAll,
          ),
          child: Row(
            children: [
              VAvatar(user.displayName, size: 26),
              if (!collapsed) ...[
                const SizedBox(width: VSpace.x2),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.bodyStrong,
                      ),
                      Text(
                        user.email,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.caption.copyWith(
                          color: c.textSubtle,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.chevronsUpDown, size: 14, color: c.textSubtle),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
