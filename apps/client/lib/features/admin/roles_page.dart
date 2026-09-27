import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../design_system/design_system.dart';
import 'admin_data.dart';

class RolesPage extends ConsumerWidget {
  const RolesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final canManage = ref.watch(permissionProvider(Permission.roleManage));
    final roles = ref.watch(rolesProvider);

    Future<void> edit([RoleInfo? role]) async {
      final saved = await showVModal<bool>(
        context,
        builder: (_) => _RoleDialog(role: role),
      );
      if (saved ?? false) ref.invalidate(rolesProvider);
    }

    Future<void> remove(RoleInfo role) async {
      final ok = await confirm(
        context,
        title: l10n.roleDeleteTitle,
        message: l10n.roleDeleteMessage(role.name),
        confirmLabel: l10n.delete,
        destructive: true,
      );
      if (!ok) return;
      try {
        await ref.read(apiClientProvider)!.delete('/api/v1/roles/${role.id}');
        ref.invalidate(rolesProvider);
      } on ApiFailure catch (e) {
        ref.read(toastProvider).error(e.message);
      }
    }

    return Column(
      children: [
        PageHeader(
          title: l10n.navRoles,
          subtitle: l10n.rolesSubtitle,
          icon: LucideIcons.shieldCheck,
          actions: [
            if (canManage)
              VButton.primary(
                label: l10n.roleNew,
                icon: LucideIcons.plus,
                onPressed: edit,
              ),
          ],
        ),
        Expanded(
          child: switch (roles) {
            AsyncData(:final value) => ListView.separated(
              padding: const EdgeInsets.all(VSpace.x5),
              itemCount: value.length,
              separatorBuilder: (_, _) => const SizedBox(height: VSpace.x3),
              itemBuilder: (context, i) {
                final role = value[i];
                return VCard(
                  title: role.name,
                  description: role.description,
                  actions: [
                    if (role.isSystem)
                      VBadge(l10n.systemRole, icon: LucideIcons.lock)
                    else if (canManage) ...[
                      VIconButton(
                        icon: LucideIcons.pencil,
                        tooltip: l10n.edit,
                        onPressed: () => edit(role),
                      ),
                      VIconButton(
                        icon: LucideIcons.trash2,
                        tooltip: l10n.delete,
                        onPressed: () => remove(role),
                      ),
                    ],
                  ],
                  child: Wrap(
                    spacing: VSpace.x1_5,
                    runSpacing: VSpace.x1_5,
                    children: [
                      for (final key in role.permissions)
                        Tooltip(
                          message: key,
                          child: VBadge(
                            Permission.fromKey(key)?.label ?? key,
                            tone: VTone.accent,
                          ),
                        ),
                      if (role.permissions.isEmpty)
                        Text(l10n.noPermission, style: context.text.small),
                    ],
                  ),
                );
              },
            ),
            AsyncError(:final error) => EmptyState(
              icon: LucideIcons.cloudOff,
              title: l10n.onlineOnlyTitle,
              message: error is ApiFailure ? error.message : l10n.genericError,
            ),
            _ => const SkeletonRows(rows: 4),
          },
        ),
      ],
    );
  }
}

class _RoleDialog extends ConsumerStatefulWidget {
  const _RoleDialog({required this.role});

  final RoleInfo? role;

  @override
  ConsumerState<_RoleDialog> createState() => _RoleDialogState();
}

class _RoleDialogState extends ConsumerState<_RoleDialog> {
  late final _name = TextEditingController(text: widget.role?.name);
  late final _key = TextEditingController(text: widget.role?.key);
  late final _description = TextEditingController(
    text: widget.role?.description,
  );
  late final Set<String> _permissions = {...?widget.role?.permissions};
  ApiFailure? _error;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _key.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final request = SaveRoleRequest(
      key: widget.role == null ? _key.text.trim() : null,
      name: _name.text.trim(),
      description: _description.text.trim().isEmpty
          ? null
          : _description.text.trim(),
      permissions: _permissions.toList(),
    ).toJson();
    try {
      final api = ref.read(apiClientProvider)!;
      if (widget.role == null) {
        await api.post('/api/v1/roles', request);
      } else {
        await api.put('/api/v1/roles/${widget.role!.id}', request);
      }
      if (mounted) Navigator.pop(context, true);
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final creating = widget.role == null;
    return VModal(
      title: creating ? l10n.roleNew : l10n.roleEdit,
      icon: LucideIcons.shieldCheck,
      width: 560,
      actions: [
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
          if (_error != null && _error!.issues.isEmpty) ...[
            VBanner(message: _error!.message, tone: VTone.danger),
            const SizedBox(height: VSpace.x3),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: VTextField(
                  controller: _name,
                  label: l10n.roleName,
                  autofocus: true,
                  error: _error?.issueFor('name'),
                ),
              ),
              if (creating) ...[
                const SizedBox(width: VSpace.x3),
                Expanded(
                  child: VTextField(
                    controller: _key,
                    label: l10n.roleKey,
                    hint: 'charge_mission',
                    monospace: true,
                    error: _error?.issueFor('key'),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(controller: _description, label: l10n.tagDescription),
          const SizedBox(height: VSpace.x4),
          Text(l10n.permissionsLabel, style: context.text.label),
          for (final permission in Permission.values)
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _permissions.contains(permission.key),
              onChanged: (v) => setState(
                () => v!
                    ? _permissions.add(permission.key)
                    : _permissions.remove(permission.key),
              ),
              title: Text(permission.label, style: context.text.body),
              subtitle: Text(permission.key, style: context.text.small),
            ),
        ],
      ),
    );
  }
}
