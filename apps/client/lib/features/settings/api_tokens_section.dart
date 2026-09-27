import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import 'settings_page.dart';

final _apiTokensProvider = FutureProvider.autoDispose<List<ApiTokenInfo>>((
  ref,
) async {
  final json = await ref
      .watch(apiClientProvider)!
      .get('/api/v1/auth/api-tokens');
  return [
    for (final t in json! as List)
      ApiTokenInfo.fromJson(t as Map<String, dynamic>),
  ];
});

/// Jetons d'API personnels (intégrations : ERP, scripts, outils no-code).
class ApiTokensSection extends ConsumerWidget {
  const ApiTokensSection({super.key});

  Future<void> _revoke(
    BuildContext context,
    WidgetRef ref,
    ApiTokenInfo token,
  ) async {
    final l10n = context.l10n;
    final ok = await confirm(
      context,
      title: l10n.apiTokenRevokeTitle(token.name),
      message: l10n.apiTokenRevokeMessage,
      confirmLabel: l10n.apiTokenRevoke,
      destructive: true,
    );
    if (!ok) return;
    try {
      await ref
          .read(apiClientProvider)!
          .delete('/api/v1/auth/api-tokens/${token.id}');
      ref.invalidate(_apiTokensProvider);
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final t = context.text;
    if (ref.watch(apiClientProvider) == null) {
      return SettingsScroll(
        children: [VBanner(message: l10n.billingSettingsOffline)],
      );
    }
    final tokens = ref.watch(_apiTokensProvider);
    return SettingsScroll(
      children: [
        VCard(
          title: l10n.apiTokensTitle,
          description: l10n.apiTokensHelp,
          actions: [
            VButton(
              label: l10n.apiTokenNew,
              icon: LucideIcons.plus,
              size: VButtonSize.sm,
              onPressed: () async {
                final created = await showVModal<bool>(
                  context,
                  builder: (_) => const _CreateTokenModal(),
                );
                if (created == true) ref.invalidate(_apiTokensProvider);
              },
            ),
          ],
          child: tokens.when(
            loading: () => const VSpinner(),
            error: (e, _) =>
                Text(e is ApiFailure ? e.message : '$e', style: t.small),
            data: (list) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (list.isEmpty) Text(l10n.apiTokensEmpty, style: t.small),
                for (final token in list)
                  SettingRow(
                    label: token.name,
                    description: [
                      l10n.apiTokenPermissions(token.permissions.length),
                      l10n.apiTokenCreated(
                        formatDateTime(token.createdAt.toLocal()),
                      ),
                      if (token.lastUsedAt case final used?)
                        l10n.apiTokenUsed(formatRelative(used)),
                      if (token.expiresAt case final expires?)
                        l10n.apiTokenExpires(formatDateTime(expires.toLocal())),
                    ].join(' · '),
                    control: VButton(
                      label: l10n.apiTokenRevoke,
                      size: VButtonSize.sm,
                      onPressed: () => unawaited(_revoke(context, ref, token)),
                    ),
                  ),
              ],
            ),
          ),
        ),
        VCard(
          title: l10n.apiDocTitle,
          child: Text(l10n.apiDocHelp, style: t.body),
        ),
      ],
    );
  }
}

class _CreateTokenModal extends ConsumerStatefulWidget {
  const _CreateTokenModal();

  @override
  ConsumerState<_CreateTokenModal> createState() => _CreateTokenModalState();
}

class _CreateTokenModalState extends ConsumerState<_CreateTokenModal> {
  final _name = TextEditingController();
  final _permissions = <String>{};
  int? _days = 365;
  String? _token;
  Map<String, String> _errors = const {};
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    setState(() => _saving = true);
    try {
      final json = await ref
          .read(apiClientProvider)!
          .post(
            '/api/v1/auth/api-tokens',
            CreateApiTokenRequest(
              name: _name.text,
              permissions: _permissions.toList(),
              expiresInDays: _days,
            ).toJson(),
          );
      setState(
        () => _token = CreatedApiToken.fromJson(
          json! as Map<String, dynamic>,
        ).token,
      );
    } on ApiFailure catch (e) {
      setState(() => _errors = {for (final i in e.issues) i.field: i.message});
      if (e.issues.isEmpty) ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final mine = ref.watch(currentUserProvider)?.permissions ?? const [];
    if (_token case final token?) {
      return VModal(
        title: l10n.apiTokenNew,
        icon: LucideIcons.keyRound,
        width: 620,
        actions: [
          VButton.primary(
            label: l10n.close,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            VBanner(message: l10n.connectorTokenOnce, tone: VTone.warning),
            const SizedBox(height: VSpace.x3),
            Row(
              children: [
                Expanded(child: SelectableText(token, style: t.mono)),
                VIconButton(
                  icon: LucideIcons.copy,
                  tooltip: l10n.copy,
                  onPressed: () =>
                      unawaited(Clipboard.setData(ClipboardData(text: token))),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return VModal(
      title: l10n.apiTokenNew,
      icon: LucideIcons.keyRound,
      width: 620,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(
          label: l10n.create,
          loading: _saving,
          onPressed: () => unawaited(_create()),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          VTextField(
            controller: _name,
            label: l10n.apiTokenName,
            hint: l10n.apiTokenNameHint,
            autofocus: true,
            error: _errors['name'],
          ),
          const SizedBox(height: VSpace.x3),
          VSelect<int?>(
            label: l10n.apiTokenValidity,
            value: _days,
            width: double.infinity,
            options: [
              VSelectOption(30, l10n.apiTokenDays(30)),
              VSelectOption(90, l10n.apiTokenDays(90)),
              VSelectOption(365, l10n.apiTokenDays(365)),
              VSelectOption(null, l10n.apiTokenNoExpiry),
            ],
            onChanged: (v) => setState(() => _days = v),
          ),
          const SizedBox(height: VSpace.x3),
          Text(l10n.apiTokenScopes, style: t.label),
          if (_errors['permissions'] != null)
            Text(
              _errors['permissions']!,
              style: t.small.copyWith(color: context.colors.danger),
            ),
          SizedBox(
            height: 260,
            child: ListView(
              children: [
                for (final p in Permission.values)
                  if (mine.contains(p.key))
                    Row(
                      children: [
                        Checkbox(
                          value: _permissions.contains(p.key),
                          onChanged: (v) => setState(() {
                            if (v ?? false) {
                              _permissions.add(p.key);
                            } else {
                              _permissions.remove(p.key);
                            }
                          }),
                        ),
                        Expanded(child: Text(p.label, style: t.body)),
                      ],
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
