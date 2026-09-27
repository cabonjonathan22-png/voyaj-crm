import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

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
    if (can(Permission.organisationWrite))
      AppCommand(
        id: 'organisation.new',
        label: 'Nouvelle organisation',
        group: CommandGroup.actions,
        icon: LucideIcons.building2,
        keywords: 'créer ajouter collectivité mairie festival',
        run: (context, _) => context.go('${Routes.organisations}?new=1'),
      ),
    if (can(Permission.contactWrite))
      AppCommand(
        id: 'contact.new',
        label: 'Nouveau contact',
        group: CommandGroup.actions,
        icon: LucideIcons.userPlus,
        keywords: 'créer ajouter personne élu',
        run: (context, _) => context.go('${Routes.contacts}?new=1'),
      ),
    if (can(Permission.tagWrite))
      AppCommand(
        id: 'tag.new',
        label: 'Nouveau tag',
        group: CommandGroup.actions,
        icon: LucideIcons.plus,
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
    for (final (route, label, icon, shortcut, keywords, permission) in [
      (
        Routes.dashboard,
        'Aller au tableau de bord',
        LucideIcons.layoutDashboard,
        'Ctrl 0',
        'accueil indicateurs chiffre affaires pipeline',
        null,
      ),
      (
        Routes.organisations,
        'Aller aux organisations',
        LucideIcons.building2,
        'Ctrl 1',
        'collectivités mairies communes festivals',
        Permission.organisationRead,
      ),
      (
        Routes.contacts,
        'Aller aux contacts',
        LucideIcons.users,
        'Ctrl 2',
        'personnes',
        Permission.contactRead,
      ),
      (
        Routes.elected,
        'Aller aux élus',
        LucideIcons.award,
        null,
        'maires mandats conseillers',
        Permission.contactRead,
      ),
      (
        Routes.pipelines,
        'Aller aux pipelines',
        LucideIcons.kanban,
        'Ctrl 3',
        'affaires kanban opportunités ventes',
        Permission.dealRead,
      ),
      (
        Routes.tasks,
        'Aller aux tâches',
        LucideIcons.squareCheck,
        'Ctrl 4',
        'activités rappels agenda',
        Permission.activityRead,
      ),
      (
        Routes.map,
        'Aller à la carte',
        LucideIcons.map,
        'Ctrl 5',
        'géographie territoire',
        Permission.organisationRead,
      ),
      (
        Routes.emails,
        'Aller aux emails',
        LucideIcons.mail,
        'Ctrl 6',
        'messagerie boîte réception modèles séquences',
        Permission.emailUse,
      ),
      (
        Routes.billing,
        'Aller à la facturation',
        LucideIcons.receipt,
        'Ctrl 7',
        'factures devis avoirs produits comptabilité fec tva chorus',
        Permission.invoiceRead,
      ),
      (
        Routes.duplicates,
        'Aller aux doublons',
        LucideIcons.copy,
        null,
        'fusion dédoublonnage',
        Permission.organisationRead,
      ),
    ])
      if (permission == null || can(permission))
        AppCommand(
          id: 'nav.$route',
          label: label,
          group: CommandGroup.navigation,
          icon: icon,
          shortcut: shortcut,
          keywords: keywords,
          run: (context, _) => context.go(route),
        ),
    AppCommand(
      id: 'nav.tags',
      label: 'Aller aux tags',
      group: CommandGroup.navigation,
      icon: LucideIcons.tags,
      run: (context, _) => context.go(Routes.tags),
    ),
    AppCommand(
      id: 'nav.sync',
      label: 'Aller à la synchronisation',
      group: CommandGroup.navigation,
      icon: LucideIcons.refreshCw,
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
    if (can(Permission.publicDataManage))
      AppCommand(
        id: 'nav.public-data',
        label: 'Aller aux données publiques',
        group: CommandGroup.navigation,
        icon: LucideIcons.landmark,
        keywords: 'communes epci aom festivals import insee geo',
        run: (context, _) => context.go(Routes.publicData),
      ),
    if (can(Permission.connectorManage))
      AppCommand(
        id: 'nav.connectors',
        label: 'Aller aux connecteurs',
        group: CommandGroup.navigation,
        icon: LucideIcons.plug,
        keywords: 'import api rest supabase firebase mysql mongodb webhook',
        run: (context, _) => context.go(Routes.connectors),
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
  ];
});
