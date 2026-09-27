import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/design_system.dart';
import '../features/admin/audit_page.dart';
import '../features/admin/connectors_page.dart';
import '../features/admin/public_data_page.dart';
import '../features/admin/roles_page.dart';
import '../features/admin/users_page.dart';
import '../features/auth/auth_state.dart';
import '../features/auth/login_page.dart';
import '../features/auth/mfa_page.dart';
import '../features/auth/server_setup_page.dart';
import '../features/billing/billing_page.dart';
import '../features/crm/activities/tasks_page.dart';
import '../features/crm/contacts/contact_page.dart';
import '../features/crm/contacts/contacts_page.dart';
import '../features/crm/contacts/elected_page.dart';
import '../features/crm/deals/pipeline_page.dart';
import '../features/crm/duplicates/duplicates_page.dart';
import '../features/crm/map/map_page.dart';
import '../features/crm/organisations/organisation_page.dart';
import '../features/crm/organisations/organisations_page.dart';
import '../features/dev/design_system_gallery.dart';
import '../features/email/emails_page.dart';
import '../features/settings/settings_page.dart';
import '../features/sync/sync_page.dart';
import '../features/tags/tags_page.dart';
import 'providers.dart';
import 'shell/app_shell.dart';

/// Chemins de l'application.
abstract final class Routes {
  static const setup = '/setup';
  static const login = '/login';
  static const mfa = '/login/mfa';
  static const organisations = '/organisations';
  static const contacts = '/contacts';
  static const elected = '/elus';
  static const pipelines = '/pipelines';
  static const tasks = '/taches';
  static const map = '/carte';
  static const duplicates = '/doublons';
  static const emails = '/emails';
  static const billing = '/facturation';
  static const tags = '/tags';
  static const sync = '/sync';
  static const settings = '/settings';
  static const users = '/admin/users';
  static const roles = '/admin/roles';
  static const audit = '/admin/audit';
  static const publicData = '/admin/donnees-publiques';
  static const connectors = '/admin/connecteurs';
  static const designSystem = '/dev/design-system';

  static const _public = {setup, login, mfa};
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier(0);
  ref
    ..listen(authProvider, (_, _) => refresh.value++)
    ..onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: Routes.organisations,
    refreshListenable: refresh,
    redirect: (context, state) {
      final location = state.matchedLocation;
      return switch (ref.read(authProvider)) {
        AuthNeedsServer() => location == Routes.setup ? null : Routes.setup,
        AuthSignedOut() => location == Routes.login ? null : Routes.login,
        AuthMfaRequired() => location == Routes.mfa ? null : Routes.mfa,
        AuthSignedIn() =>
          Routes._public.contains(location) ? Routes.organisations : null,
      };
    },
    routes: [
      GoRoute(
        path: Routes.setup,
        pageBuilder: (_, state) => _fade(state, const ServerSetupPage()),
      ),
      GoRoute(
        path: Routes.login,
        pageBuilder: (_, state) => _fade(state, const LoginPage()),
      ),
      GoRoute(
        path: Routes.mfa,
        pageBuilder: (_, state) => _fade(state, const MfaPage()),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(
            path: Routes.organisations,
            pageBuilder: (_, state) => _instant(
              state,
              OrganisationsPage(
                create: state.uri.queryParameters.containsKey('new'),
              ),
            ),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (_, state) => _instant(
                  state,
                  OrganisationPage(
                    key: ValueKey(state.pathParameters['id']),
                    id: state.pathParameters['id']!,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.contacts,
            pageBuilder: (_, state) => _instant(
              state,
              ContactsPage(
                create: state.uri.queryParameters.containsKey('new'),
              ),
            ),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (_, state) => _instant(
                  state,
                  ContactPage(
                    key: ValueKey(state.pathParameters['id']),
                    id: state.pathParameters['id']!,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.elected,
            pageBuilder: (_, state) => _instant(state, const ElectedPage()),
          ),
          GoRoute(
            path: Routes.pipelines,
            pageBuilder: (_, state) => _instant(
              state,
              PipelinePage(pipelineId: state.uri.queryParameters['id']),
            ),
          ),
          GoRoute(
            path: Routes.tasks,
            pageBuilder: (_, state) => _instant(state, const TasksPage()),
          ),
          GoRoute(
            path: Routes.map,
            pageBuilder: (_, state) => _instant(state, const MapPage()),
          ),
          GoRoute(
            path: Routes.emails,
            pageBuilder: (_, state) => _instant(state, const EmailsPage()),
          ),
          GoRoute(
            path: Routes.billing,
            pageBuilder: (_, state) => _instant(state, const BillingPage()),
          ),
          GoRoute(
            path: Routes.duplicates,
            pageBuilder: (_, state) => _instant(state, const DuplicatesPage()),
          ),
          GoRoute(
            path: Routes.tags,
            pageBuilder: (_, state) => _instant(
              state,
              TagsPage(
                initialTagId: state.uri.queryParameters.containsKey('new')
                    ? ''
                    : state.uri.queryParameters['id'],
              ),
            ),
          ),
          GoRoute(
            path: Routes.sync,
            pageBuilder: (_, state) => _instant(state, const SyncPage()),
          ),
          GoRoute(
            path: Routes.settings,
            redirect: (_, state) => state.fullPath == Routes.settings
                ? '${Routes.settings}/${SettingsSection.appearance.name}'
                : null,
            routes: [
              GoRoute(
                path: ':section',
                pageBuilder: (_, state) => _instant(
                  state,
                  SettingsPage(
                    section:
                        SettingsSection.values
                            .where(
                              (s) => s.name == state.pathParameters['section'],
                            )
                            .firstOrNull ??
                        SettingsSection.appearance,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.users,
            pageBuilder: (_, state) => _instant(state, const UsersPage()),
          ),
          GoRoute(
            path: Routes.roles,
            pageBuilder: (_, state) => _instant(state, const RolesPage()),
          ),
          GoRoute(
            path: Routes.publicData,
            pageBuilder: (_, state) => _instant(state, const PublicDataPage()),
          ),
          GoRoute(
            path: Routes.connectors,
            pageBuilder: (_, state) => _instant(state, const ConnectorsPage()),
          ),
          GoRoute(
            path: Routes.audit,
            pageBuilder: (_, state) => _instant(state, const AuditPage()),
          ),
          if (kDebugMode)
            GoRoute(
              path: Routes.designSystem,
              pageBuilder: (_, state) =>
                  _instant(state, const DesignSystemGallery()),
            ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

Page<void> _instant(GoRouterState state, Widget child) =>
    NoTransitionPage(key: state.pageKey, child: child);

Page<void> _fade(GoRouterState state, Widget child) => CustomTransitionPage(
  key: state.pageKey,
  transitionDuration: VMotion.normal,
  child: child,
  transitionsBuilder: (context, animation, _, child) =>
      FadeTransition(opacity: animation, child: child),
);
