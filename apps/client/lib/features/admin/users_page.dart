import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import 'admin_data.dart';

const _tableId = 'users';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final canManage = ref.watch(permissionProvider(Permission.userManage));
    final users = ref.watch(usersProvider);
    final roles = ref.watch(rolesProvider).value ?? const <RoleInfo>[];
    final roleNames = {for (final r in roles) r.key: r.name};
    final view = ref.watch(tableViewProvider(_tableId));

    Future<void> edit([UserSummary? user]) async {
      final saved = await showVModal<bool>(
        context,
        builder: (_) => _UserDialog(user: user, roles: roles),
      );
      if (saved ?? false) ref.invalidate(usersProvider);
    }

    final columns = <VColumn<UserSummary>>[
      VColumn(
        id: 'name',
        label: l10n.userName,
        width: 220,
        hideable: false,
        sortValue: (u) => u.displayName.toLowerCase(),
        filterValue: (u) => u.displayName,
        cell: (context, u) => Row(
          children: [
            VAvatar(u.displayName, size: 22),
            const SizedBox(width: VSpace.x2),
            Flexible(
              child: Text(u.displayName, style: context.text.bodyStrong),
            ),
          ],
        ),
      ),
      VColumn(
        id: 'email',
        label: l10n.emailLabel,
        width: 240,
        flex: true,
        sortValue: (u) => u.email,
        filterValue: (u) => u.email,
        cell: (context, u) => Text(u.email),
      ),
      VColumn(
        id: 'roles',
        label: l10n.rolesLabel,
        width: 200,
        filterValue: (u) => u.roles.map((r) => roleNames[r] ?? r).join(' '),
        cell: (context, u) => Wrap(
          spacing: VSpace.x1,
          children: [
            for (final r in u.roles)
              VBadge(roleNames[r] ?? r, tone: VTone.accent),
          ],
        ),
      ),
      VColumn(
        id: 'totp',
        label: l10n.twoFactorShort,
        width: 90,
        sortValue: (u) => u.totpEnabled ? 1 : 0,
        filterValue: (u) => u.totpEnabled ? l10n.enabled : l10n.disabled,
        cell: (context, u) => u.totpEnabled
            ? Icon(
                LucideIcons.shieldCheck,
                size: 15,
                color: context.colors.success,
              )
            : Icon(
                LucideIcons.shieldOff,
                size: 15,
                color: context.colors.textSubtle,
              ),
      ),
      VColumn(
        id: 'status',
        label: l10n.statusLabel,
        width: 110,
        sortValue: (u) => u.status.name,
        filterValue: (u) => u.status == UserStatus.active
            ? l10n.statusActive
            : l10n.statusDisabled,
        cell: (context, u) => u.status == UserStatus.active
            ? VBadge(l10n.statusActive, tone: VTone.success)
            : VBadge(l10n.statusDisabled),
      ),
      VColumn(
        id: 'lastLogin',
        label: l10n.lastLogin,
        width: 150,
        sortValue: (u) => u.lastLoginAt ?? DateTime(1970),
        cell: (context, u) => Text(
          u.lastLoginAt == null ? '—' : formatRelative(u.lastLoginAt!),
          style: context.text.small,
        ),
      ),
    ];

    final list = users.value ?? const <UserSummary>[];
    return Column(
      children: [
        PageHeader(
          title: l10n.navUsers,
          subtitle: l10n.usersSubtitle,
          icon: LucideIcons.users,
          actions: [
            if (canManage)
              VButton.primary(
                label: l10n.userNew,
                icon: LucideIcons.userPlus,
                onPressed: edit,
              ),
          ],
        ),
        VTableToolbar<UserSummary>(
          columns: columns,
          view: view,
          onViewChanged: ref.read(tableViewProvider(_tableId).notifier).set,
          savedViews: ref.watch(savedViewsProvider(_tableId)),
          onSavedViewsChanged: ref
              .read(savedViewsProvider(_tableId).notifier)
              .set,
          resultCount: list.length,
        ),
        Expanded(
          child: switch (users) {
            AsyncError(:final error) => EmptyState(
              icon: LucideIcons.cloudOff,
              title: l10n.onlineOnlyTitle,
              message: error is ApiFailure ? error.message : l10n.genericError,
              action: VButton(
                label: l10n.retry,
                onPressed: () => ref.invalidate(usersProvider),
              ),
            ),
            AsyncData() => VDataTable<UserSummary>(
              rows: applyTableView(list, columns, view),
              columns: columns,
              rowId: (u) => u.id,
              view: view,
              onViewChanged: ref.read(tableViewProvider(_tableId).notifier).set,
              onRowActivated: canManage ? edit : null,
            ),
            _ => const SkeletonRows(),
          },
        ),
      ],
    );
  }
}

class _UserDialog extends ConsumerStatefulWidget {
  const _UserDialog({required this.user, required this.roles});

  final UserSummary? user;
  final List<RoleInfo> roles;

  @override
  ConsumerState<_UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends ConsumerState<_UserDialog> {
  late final _name = TextEditingController(text: widget.user?.displayName);
  late final _email = TextEditingController(text: widget.user?.email);
  final _password = TextEditingController();
  late final Set<String> _roles = {...?widget.user?.roles};
  late bool _active = widget.user?.status != UserStatus.disabled;
  ApiFailure? _error;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final api = ref.read(apiClientProvider)!;
    try {
      if (widget.user == null) {
        await api.post(
          '/api/v1/users',
          CreateUserRequest(
            email: _email.text.trim(),
            displayName: _name.text.trim(),
            password: _password.text,
            roles: _roles.toList(),
          ).toJson(),
        );
      } else {
        await api.patch(
          '/api/v1/users/${widget.user!.id}',
          UpdateUserRequest(
            displayName: _name.text.trim(),
            status: _active ? UserStatus.active : UserStatus.disabled,
            roles: _roles.toList(),
          ).toJson(),
        );
      }
      if (mounted) Navigator.pop(context, true);
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _revokeSessions() async {
    try {
      await ref
          .read(apiClientProvider)!
          .post('/api/v1/users/${widget.user!.id}/revoke-sessions');
      if (mounted) {
        ref.read(toastProvider).success(context.l10n.sessionsRevoked);
      }
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final creating = widget.user == null;
    final error = _error;
    return VModal(
      title: creating ? l10n.userNew : l10n.userEdit,
      icon: creating ? LucideIcons.userPlus : LucideIcons.userCog,
      width: 520,
      actions: [
        if (!creating)
          VButton.ghost(
            label: l10n.revokeAllSessions,
            icon: LucideIcons.logOut,
            onPressed: _revokeSessions,
          ),
        const Spacer(),
        VButton(label: l10n.cancel, onPressed: () => Navigator.pop(context)),
        VButton.primary(
          label: creating ? l10n.create : l10n.save,
          loading: _busy,
          onPressed: _save,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (error != null && error.issues.isEmpty) ...[
            VBanner(message: error.message, tone: VTone.danger),
            const SizedBox(height: VSpace.x3),
          ],
          VTextField(
            controller: _name,
            label: l10n.userName,
            autofocus: true,
            error: error?.issueFor('display_name'),
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _email,
            label: l10n.emailLabel,
            enabled: creating,
            error: error?.issueFor('email'),
          ),
          if (creating) ...[
            const SizedBox(height: VSpace.x3),
            VTextField(
              controller: _password,
              label: l10n.initialPassword,
              obscure: true,
              helper: l10n.passwordPolicy(minPasswordLength),
              error: error?.issueFor('password'),
            ),
          ],
          const SizedBox(height: VSpace.x4),
          Text(l10n.rolesLabel, style: context.text.label),
          const SizedBox(height: VSpace.x1),
          for (final role in widget.roles)
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _roles.contains(role.key),
              onChanged: (v) => setState(
                () => v! ? _roles.add(role.key) : _roles.remove(role.key),
              ),
              title: Text(role.name, style: context.text.bodyStrong),
              subtitle: role.description == null
                  ? null
                  : Text(role.description!, style: context.text.small),
            ),
          if (!creating) ...[
            const SizedBox(height: VSpace.x2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.accountActive,
                    style: context.text.bodyStrong,
                  ),
                ),
                Switch(
                  value: _active,
                  onChanged: (v) => setState(() => _active = v),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
