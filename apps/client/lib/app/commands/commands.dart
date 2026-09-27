import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../design_system/design_system.dart';
import '../../features/settings/settings_page.dart';
import '../providers.dart';
import '../router.dart';
import '../shell/shortcuts_help.dart';

enum CommandGroup {
  actions('Actions'),
  navigation('Navigation'),
  records('Données');

  const CommandGroup(this.label);

  final String label;
}

/// Lecture d'un provider depuis une commande.
typedef Reader = T Function<T>(ProviderListenable<T> provider);

/// Commande exécutable depuis la palette (Ctrl+K).
@immutable
final class AppCommand {
  const AppCommand({
    required this.id,
    required this.label,
    required this.group,
    required this.icon,
    required this.run,
    this.shortcut,
    this.keywords = '',
    this.subtitle,
    this.leading,
  });

  final String id;
  final String label;
  final CommandGroup group;
  final IconData icon;
  final String? shortcut;

  /// Termes supplémentaires pris en compte par la recherche.
  final String keywords;
  final String? subtitle;
  final Widget? leading;
  final void Function(BuildContext context, Reader read) run;
}

/// Commandes disponibles pour l'utilisateur connecté.
final commandsProvider = Provider<List<AppCommand>>((ref) {
  bool can(Permission p) => ref.watch(permissionProvider(p));

  return [
    if (can(Permission.tagWrite))
      AppCommand(
        id: 'tag.new',
        label: 'Nouveau tag',
        group: CommandGroup.actions,
        icon: LucideIcons.plus,
        shortcut: 'Ctrl N',
        keywords: 'créer ajouter étiquette',
        run: (context, _) => context.go('${Routes.tags}?new=1'),
      ),
    AppCommand(
      id: 'sync.now',
      label: 'Synchroniser maintenant',
      group: CommandGroup.actions,
      icon: LucideIcons.refreshCw,
      shortcut: 'F5',
      keywords: 'synchro actualiser serveur',
      run: (_, read) => read(syncEngineProvider)?.syncNow(),
    ),
    AppCommand(
      id: 'theme.toggle',
      label: 'Basculer thème clair / sombre',
      group: CommandGroup.actions,
      icon: LucideIcons.sunMoon,
      shortcut: 'Ctrl Maj L',
      keywords: 'apparence dark light nuit',
      run: (context, read) =>
          read(themeModeProvider.notifier).toggle(Theme.of(context).brightness),
    ),
    AppCommand(
      id: 'sidebar.toggle',
      label: 'Afficher / masquer la barre latérale',
      group: CommandGroup.actions,
      icon: LucideIcons.panelLeft,
      shortcut: 'Ctrl B',
      keywords: 'menu navigation',
      run: (_, read) => read(sidebarCollapsedProvider.notifier).toggle(),
    ),
    AppCommand(
      id: 'help.shortcuts',
      label: 'Raccourcis clavier',
      group: CommandGroup.actions,
      icon: LucideIcons.keyboard,
      shortcut: 'F1',
      keywords: 'aide clavier',
      run: (context, _) => showShortcutsHelp(context),
    ),
    AppCommand(
      id: 'auth.logout',
      label: 'Se déconnecter',
      group: CommandGroup.actions,
      icon: LucideIcons.logOut,
      keywords: 'quitter déconnexion',
      run: (_, read) => read(authProvider.notifier).logout(),
    ),
    AppCommand(
      id: 'nav.tags',
      label: 'Aller aux tags',
      group: CommandGroup.navigation,
      icon: LucideIcons.tags,
      shortcut: 'Ctrl 1',
      run: (context, _) => context.go(Routes.tags),
    ),
    AppCommand(
      id: 'nav.sync',
      label: 'Aller à la synchronisation',
      group: CommandGroup.navigation,
      icon: LucideIcons.refreshCw,
      shortcut: 'Ctrl 2',
      keywords: 'conflits erreurs',
      run: (context, _) => context.go(Routes.sync),
    ),
    for (final section in SettingsSection.values)
      AppCommand(
        id: 'nav.settings.${section.name}',
        label: 'Paramètres : ${section.label}',
        group: CommandGroup.navigation,
        icon: section.icon,
        shortcut: section == SettingsSection.appearance ? 'Ctrl ,' : null,
        keywords: section.keywords,
        run: (context, _) => context.go('${Routes.settings}/${section.name}'),
      ),
    if (can(Permission.userRead))
      AppCommand(
        id: 'nav.users',
        label: 'Aller aux utilisateurs',
        group: CommandGroup.navigation,
        icon: LucideIcons.users,
        keywords: 'comptes équipe administration',
        run: (context, _) => context.go(Routes.users),
      ),
    if (can(Permission.userRead))
      AppCommand(
        id: 'nav.roles',
        label: 'Aller aux rôles et permissions',
        group: CommandGroup.navigation,
        icon: LucideIcons.shieldCheck,
        keywords: 'droits administration',
        run: (context, _) => context.go(Routes.roles),
      ),
    if (can(Permission.auditRead))
      AppCommand(
        id: 'nav.audit',
        label: "Aller au journal d'audit",
        group: CommandGroup.navigation,
        icon: LucideIcons.scrollText,
        keywords: 'historique traçabilité sécurité',
        run: (context, _) => context.go(Routes.audit),
      ),
    if (kDebugMode)
      AppCommand(
        id: 'nav.design',
        label: 'Catalogue du design system',
        group: CommandGroup.navigation,
        icon: LucideIcons.palette,
        keywords: 'composants debug',
        run: (context, _) => context.go(Routes.designSystem),
      ),
    // Recherche globale : les données locales sont interrogeables ici.
    for (final tag in ref.watch(tagsProvider).value ?? const <Tag>[])
      AppCommand(
        id: 'tag.${tag.id}',
        label: tag.name,
        subtitle: tag.description,
        group: CommandGroup.records,
        icon: LucideIcons.tag,
        leading: ColorDot(parseHexColor(tag.color)),
        keywords: 'tag ${tag.description ?? ''}',
        run: (context, _) => context.go('${Routes.tags}?id=${tag.id}'),
      ),
  ];
});
