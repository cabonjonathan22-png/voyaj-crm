import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import 'settings_page.dart';

final _sessionsProvider = FutureProvider.autoDispose<List<SessionInfo>>((
  ref,
) async {
  final json = await ref.watch(apiClientProvider)!.get('/api/v1/auth/sessions');
  return [
    for (final s in json! as List<dynamic>)
      SessionInfo.fromJson(s as Map<String, dynamic>),
  ];
});

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) => const SettingsScroll(
    children: [_PasswordCard(), _TwoFactorCard(), _SessionsCard()],
  );
}

// ── Mot de passe ──────────────────────────────────────────────────────────

class _PasswordCard extends ConsumerStatefulWidget {
  const _PasswordCard();

  @override
  ConsumerState<_PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends ConsumerState<_PasswordCard> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  Map<String, String> _errors = const {};
  bool _busy = false;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final policy = validatePassword('new', _next.text);
    final errors = {
      if (_current.text.isEmpty) 'current': l10n.fieldRequired,
      if (policy != null) 'new': policy.message,
      if (_confirm.text != _next.text) 'confirm': l10n.passwordMismatch,
    };
    setState(() => _errors = errors);
    if (errors.isNotEmpty) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(apiClientProvider)!
          .post(
            '/api/v1/auth/password',
            ChangePasswordRequest(
              currentPassword: _current.text,
              newPassword: _next.text,
            ).toJson(),
          );
      _current.clear();
      _next.clear();
      _confirm.clear();
      ref.read(toastProvider).success(l10n.passwordChanged);
      ref.invalidate(_sessionsProvider);
    } on ApiFailure catch (e) {
      setState(
        () => _errors = {
          e.code == ApiErrorCodes.invalidCredentials ? 'current' : 'new':
              e.message,
        },
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return VCard(
      title: l10n.passwordTitle,
      description: l10n.passwordDescription,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VTextField(
            controller: _current,
            label: l10n.currentPassword,
            obscure: true,
            error: _errors['current'],
          ),
          const SizedBox(height: VSpace.x3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: VTextField(
                  controller: _next,
                  label: l10n.newPassword,
                  obscure: true,
                  helper: l10n.passwordPolicy(minPasswordLength),
                  error: _errors['new'],
                ),
              ),
              const SizedBox(width: VSpace.x3),
              Expanded(
                child: VTextField(
                  controller: _confirm,
                  label: l10n.confirmPassword,
                  obscure: true,
                  error: _errors['confirm'],
                  onSubmitted: (_) => _submit(),
                ),
              ),
            ],
          ),
          const SizedBox(height: VSpace.x4),
          VButton.primary(
            label: l10n.changePassword,
            loading: _busy,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

// ── Double authentification ──────────────────────────────────────────────

class _TwoFactorCard extends ConsumerWidget {
  const _TwoFactorCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(currentUserProvider);
    final enabled = user?.totpEnabled ?? false;

    Future<void> withCode(
      String title,
      Future<void> Function(String code) action,
    ) async {
      final code = await _promptCode(context, title);
      if (code == null) return;
      try {
        await action(code);
      } on ApiFailure catch (e) {
        ref.read(toastProvider).error(e.message);
      }
    }

    return VCard(
      title: l10n.twoFactorTitle,
      description: l10n.twoFactorDescription,
      actions: [
        VBadge(
          enabled ? l10n.enabled : l10n.disabled,
          tone: enabled ? VTone.success : VTone.neutral,
          icon: enabled ? LucideIcons.shieldCheck : LucideIcons.shieldOff,
        ),
      ],
      child: Wrap(
        spacing: VSpace.x2,
        runSpacing: VSpace.x2,
        children: enabled
            ? [
                VButton(
                  label: l10n.regenerateRecoveryCodes,
                  icon: LucideIcons.keyRound,
                  onPressed: () =>
                      withCode(l10n.regenerateRecoveryCodes, (code) async {
                        final json = await ref
                            .read(apiClientProvider)!
                            .post(
                              '/api/v1/auth/totp/recovery-codes',
                              CodeRequest(code: code).toJson(),
                            );
                        if (context.mounted) {
                          await _showRecoveryCodes(
                            context,
                            RecoveryCodesResponse.fromJson(
                              json! as Map<String, dynamic>,
                            ).codes,
                          );
                        }
                      }),
                ),
                VButton.danger(
                  label: l10n.disableTwoFactor,
                  onPressed: () =>
                      withCode(l10n.disableTwoFactor, (code) async {
                        await ref
                            .read(apiClientProvider)!
                            .post(
                              '/api/v1/auth/totp/disable',
                              CodeRequest(code: code).toJson(),
                            );
                        await ref.read(authProvider.notifier).refreshUser();
                        ref.read(toastProvider).success(l10n.twoFactorDisabled);
                      }),
                ),
              ]
            : [
                VButton.primary(
                  label: l10n.enableTwoFactor,
                  icon: LucideIcons.shieldCheck,
                  onPressed: () => showVModal<void>(
                    context,
                    dismissible: false,
                    builder: (_) => const _TotpSetupDialog(),
                  ),
                ),
              ],
      ),
    );
  }
}

Future<String?> _promptCode(BuildContext context, String title) async {
  final controller = TextEditingController();
  final l10n = context.l10n;
  final code = await showVModal<String>(
    context,
    builder: (context) => VModal(
      title: title,
      description: l10n.codePromptDescription,
      icon: LucideIcons.keyRound,
      width: 400,
      actions: [
        VButton(label: l10n.cancel, onPressed: () => Navigator.pop(context)),
        VButton.primary(
          label: l10n.confirmAction,
          onPressed: () => Navigator.pop(context, controller.text.trim()),
        ),
      ],
      child: VTextField(
        controller: controller,
        label: l10n.mfaCodeLabel,
        autofocus: true,
        monospace: true,
        onSubmitted: (v) => Navigator.pop(context, v.trim()),
      ),
    ),
  );
  controller.dispose();
  return code == null || code.isEmpty ? null : code;
}

Future<void> _showRecoveryCodes(BuildContext context, List<String> codes) {
  final l10n = context.l10n;
  return showVModal<void>(
    context,
    dismissible: false,
    builder: (context) => VModal(
      title: l10n.recoveryCodesTitle,
      description: l10n.recoveryCodesDescription,
      icon: LucideIcons.keyRound,
      actions: [
        VButton(
          label: l10n.copy,
          icon: LucideIcons.copy,
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: codes.join('\n'))),
        ),
        VButton.primary(
          label: l10n.recoveryCodesSaved,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(VSpace.x4),
        decoration: BoxDecoration(
          color: context.colors.backgroundSubtle,
          borderRadius: VRadius.mdAll,
          border: Border.all(color: context.colors.border),
        ),
        child: Wrap(
          spacing: VSpace.x6,
          runSpacing: VSpace.x2,
          children: [
            for (final code in codes)
              SizedBox(
                width: 150,
                child: SelectableText(code, style: context.text.mono),
              ),
          ],
        ),
      ),
    ),
  );
}

class _TotpSetupDialog extends ConsumerStatefulWidget {
  const _TotpSetupDialog();

  @override
  ConsumerState<_TotpSetupDialog> createState() => _TotpSetupDialogState();
}

class _TotpSetupDialogState extends ConsumerState<_TotpSetupDialog> {
  final _code = TextEditingController();
  TotpSetupResponse? _setup;
  String? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    try {
      final json = await ref
          .read(apiClientProvider)!
          .post('/api/v1/auth/totp/setup');
      if (mounted) {
        setState(
          () => _setup = TotpSetupResponse.fromJson(
            json! as Map<String, dynamic>,
          ),
        );
      }
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    }
  }

  Future<void> _confirm() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final json = await ref
          .read(apiClientProvider)!
          .post(
            '/api/v1/auth/totp/confirm',
            CodeRequest(code: _code.text.trim()).toJson(),
          );
      final codes = RecoveryCodesResponse.fromJson(
        json! as Map<String, dynamic>,
      ).codes;
      await ref.read(authProvider.notifier).refreshUser();
      if (!mounted) return;
      final navigator = Navigator.of(context);
      final toasts = ref.read(toastProvider);
      final message = context.l10n.twoFactorEnabled;
      await _showRecoveryCodes(context, codes);
      navigator.pop();
      toasts.success(message);
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final setup = _setup;
    return VModal(
      title: l10n.enableTwoFactor,
      description: l10n.totpSetupDescription,
      icon: LucideIcons.shieldCheck,
      width: 520,
      actions: [
        VButton(label: l10n.cancel, onPressed: () => Navigator.pop(context)),
        VButton.primary(
          label: l10n.activate,
          loading: _busy,
          onPressed: setup == null ? null : _confirm,
        ),
      ],
      child: setup == null
          ? (_error == null
                ? const Center(child: VSpinner(size: 24))
                : VBanner(message: _error!, tone: VTone.danger))
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(VSpace.x2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: VRadius.mdAll,
                    border: Border.all(color: c.border),
                  ),
                  child: QrImageView(
                    data: setup.otpauthUri,
                    size: 168,
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: VSpace.x5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.totpStepScan, style: context.text.body),
                      const SizedBox(height: VSpace.x3),
                      Text(l10n.totpManualKey, style: context.text.label),
                      const SizedBox(height: VSpace.x1),
                      SelectableText(
                        setup.secret.replaceAllMapped(
                          RegExp('.{4}'),
                          (m) => '${m[0]} ',
                        ),
                        style: context.text.mono,
                      ),
                      const SizedBox(height: VSpace.x4),
                      VTextField(
                        controller: _code,
                        label: l10n.totpStepCode,
                        hint: '123456',
                        autofocus: true,
                        monospace: true,
                        error: _error,
                        onSubmitted: (_) => _confirm(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// ── Sessions ──────────────────────────────────────────────────────────────

class _SessionsCard extends ConsumerWidget {
  const _SessionsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final sessions = ref.watch(_sessionsProvider);

    Future<void> revoke(String id) async {
      try {
        await ref.read(apiClientProvider)!.delete('/api/v1/auth/sessions/$id');
        ref.invalidate(_sessionsProvider);
        ref.read(toastProvider).success(l10n.sessionRevoked);
      } on ApiFailure catch (e) {
        ref.read(toastProvider).error(e.message);
      }
    }

    return VCard(
      title: l10n.sessionsTitle,
      description: l10n.sessionsDescription,
      child: switch (sessions) {
        AsyncData(:final value) => Column(
          children: [
            for (final s in value)
              Container(
                padding: const EdgeInsets.symmetric(vertical: VSpace.x2 + 2),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: c.borderSubtle)),
                ),
                child: Row(
                  children: [
                    Icon(
                      s.platform == 'windows' ||
                              s.platform == 'macos' ||
                              s.platform == 'linux'
                          ? LucideIcons.laptop
                          : LucideIcons.smartphone,
                      size: 18,
                      color: c.textMuted,
                    ),
                    const SizedBox(width: VSpace.x3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                s.deviceName,
                                style: context.text.bodyStrong,
                              ),
                              if (s.current) ...[
                                const SizedBox(width: VSpace.x2),
                                VBadge(l10n.thisDevice, tone: VTone.accent),
                              ],
                            ],
                          ),
                          Text(
                            [
                              s.platform,
                              ?s.ip,
                              l10n.lastActivity(formatRelative(s.lastSeenAt)),
                            ].join(' · '),
                            style: context.text.small,
                          ),
                        ],
                      ),
                    ),
                    if (!s.current)
                      VButton(
                        label: l10n.revoke,
                        size: VButtonSize.sm,
                        onPressed: () => revoke(s.id),
                      ),
                  ],
                ),
              ),
          ],
        ),
        AsyncError(:final error) => Text(
          error is ApiFailure ? error.message : l10n.genericError,
          style: context.text.small,
        ),
        _ => const Skeleton(height: 40),
      },
    );
  }
}
