import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import '../email/email_data.dart';
import 'settings_page.dart';

/// Préréglages des serveurs IMAP / SMTP courants.
const _presets = <String, (String, int, String, int, SmtpSecurity)>{
  'OVH': ('ssl0.ovh.net', 993, 'ssl0.ovh.net', 465, SmtpSecurity.tls),
  'Gmail (mot de passe d’application)': (
    'imap.gmail.com',
    993,
    'smtp.gmail.com',
    465,
    SmtpSecurity.tls,
  ),
  'Outlook / Microsoft 365': (
    'outlook.office365.com',
    993,
    'smtp.office365.com',
    587,
    SmtpSecurity.starttls,
  ),
  'Orange': ('imap.orange.fr', 993, 'smtp.orange.fr', 465, SmtpSecurity.tls),
  'Ionos': ('imap.ionos.fr', 993, 'smtp.ionos.fr', 465, SmtpSecurity.tls),
};

/// Comptes email de l'utilisateur (connexion au serveur requise).
class EmailAccountsSection extends ConsumerStatefulWidget {
  const EmailAccountsSection({super.key});

  @override
  ConsumerState<EmailAccountsSection> createState() =>
      _EmailAccountsSectionState();
}

class _EmailAccountsSectionState extends ConsumerState<EmailAccountsSection> {
  List<String> _providers = const ['imap'];
  String? _busy;

  @override
  void initState() {
    super.initState();
    unawaited(_loadProviders());
  }

  Future<void> _loadProviders() async {
    try {
      final providers = await ref.read(emailApiProvider)!.providers();
      if (mounted) setState(() => _providers = providers);
    } on ApiFailure {
      // Hors ligne : seul l'ajout IMAP est proposé (il échouera proprement).
    }
  }

  Future<void> _run(String key, Future<void> Function() action) async {
    setState(() => _busy = key);
    try {
      await action();
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  Future<void> _oauth(String provider) => _run(provider, () async {
    final url = await ref.read(emailApiProvider)!.oauthStart(provider);
    await launchUrl(url);
    ref.read(toastProvider).info(context.l10n.emailOAuthContinue);
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final accounts = ref.watch(emailAccountsProvider);
    final api = ref.read(emailApiProvider)!;

    return SettingsScroll(
      children: [
        VCard(
          title: l10n.emailAccountsTitle,
          description: l10n.emailAccountsDescription,
          actions: [
            VIconButton(
              icon: LucideIcons.refreshCw,
              tooltip: l10n.refresh,
              onPressed: () => ref.invalidate(emailAccountsProvider),
            ),
          ],
          child: accounts.when(
            loading: () => const SkeletonRows(rows: 2),
            error: (e, _) => VBanner(
              message: e is ApiFailure ? e.message : l10n.emailOffline,
              tone: VTone.danger,
            ),
            data: (list) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (list.isEmpty) Text(l10n.emailNoAccount, style: t.small),
                for (final a in list)
                  Padding(
                    padding: const EdgeInsets.only(bottom: VSpace.x3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          LucideIcons.mail,
                          size: 16,
                          color: context.colors.textMuted,
                        ),
                        const SizedBox(width: VSpace.x3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.address, style: t.bodyStrong),
                              Text(
                                [
                                  switch (a.provider) {
                                    EmailProvider.google => 'Google',
                                    EmailProvider.microsoft => 'Microsoft',
                                    EmailProvider.imap => 'IMAP / SMTP',
                                  },
                                  if (a.lastSyncAt != null)
                                    l10n.syncLastAt(
                                      formatRelative(a.lastSyncAt!),
                                    ),
                                ].join(' · '),
                                style: t.small,
                              ),
                              if (a.lastError != null)
                                Text(
                                  a.lastError!,
                                  style: t.small.copyWith(
                                    color: context.colors.danger,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        VButton(
                          label: l10n.emailSyncNow,
                          size: VButtonSize.sm,
                          loading: _busy == 'sync-${a.id}',
                          onPressed: () => unawaited(
                            _run('sync-${a.id}', () async {
                              await api.sync(a.id);
                              ref.invalidate(emailAccountsProvider);
                            }),
                          ),
                        ),
                        VIconButton(
                          icon: LucideIcons.trash2,
                          tooltip: l10n.emailDisconnect,
                          size: VButtonSize.sm,
                          onPressed: () => unawaited(
                            _run('delete-${a.id}', () async {
                              final ok = await confirm(
                                context,
                                title: l10n.emailDisconnect,
                                message: l10n.emailDisconnectMessage(a.address),
                                confirmLabel: l10n.emailDisconnect,
                                destructive: true,
                              );
                              if (!ok) return;
                              await api.deleteAccount(a.id);
                              ref.invalidate(emailAccountsProvider);
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        VCard(
          title: l10n.emailConnectAccount,
          description: l10n.emailConnectDescription,
          child: Wrap(
            spacing: VSpace.x2,
            runSpacing: VSpace.x2,
            children: [
              if (_providers.contains('google'))
                VButton(
                  label: l10n.emailConnectGoogle,
                  icon: LucideIcons.mail,
                  loading: _busy == 'google',
                  onPressed: () => unawaited(_oauth('google')),
                ),
              if (_providers.contains('microsoft'))
                VButton(
                  label: l10n.emailConnectMicrosoft,
                  icon: LucideIcons.mail,
                  loading: _busy == 'microsoft',
                  onPressed: () => unawaited(_oauth('microsoft')),
                ),
              VButton.primary(
                label: l10n.emailAddImap,
                icon: LucideIcons.plus,
                onPressed: () => unawaited(
                  showVModal<void>(
                    context,
                    builder: (_) => const _ImapForm(),
                  ).then((_) => ref.invalidate(emailAccountsProvider)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ImapForm extends ConsumerStatefulWidget {
  const _ImapForm();

  @override
  ConsumerState<_ImapForm> createState() => _ImapFormState();
}

class _ImapFormState extends ConsumerState<_ImapForm> {
  final _address = TextEditingController();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _imapHost = TextEditingController();
  final _imapPort = TextEditingController(text: '993');
  final _smtpHost = TextEditingController();
  final _smtpPort = TextEditingController(text: '465');
  SmtpSecurity _security = SmtpSecurity.tls;
  bool _saving = false;
  String? _error;
  Map<String, String> _errors = const {};

  @override
  void dispose() {
    for (final c in [
      _address,
      _name,
      _username,
      _password,
      _imapHost,
      _imapPort,
      _smtpHost,
      _smtpPort,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _preset(String name) {
    final (imap, imapPort, smtp, smtpPort, security) = _presets[name]!;
    setState(() {
      _imapHost.text = imap;
      _imapPort.text = '$imapPort';
      _smtpHost.text = smtp;
      _smtpPort.text = '$smtpPort';
      _security = security;
    });
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
      _errors = const {};
    });
    try {
      await ref
          .read(emailApiProvider)!
          .createImap(
            CreateImapAccountRequest(
              address: _address.text.trim(),
              displayName: _name.text.trim().isEmpty ? null : _name.text.trim(),
              imapHost: _imapHost.text.trim(),
              imapPort: int.tryParse(_imapPort.text) ?? 993,
              smtpHost: _smtpHost.text.trim(),
              smtpPort: int.tryParse(_smtpPort.text) ?? 465,
              smtpSecurity: _security,
              username: _username.text.trim().isEmpty
                  ? _address.text.trim()
                  : _username.text.trim(),
              password: _password.text,
            ),
          );
      ref.read(toastProvider).success(context.l10n.emailAccountAdded);
      if (mounted) Navigator.of(context).pop();
    } on ApiFailure catch (e) {
      setState(() {
        _error = e.issues.isEmpty ? e.message : null;
        _errors = {for (final i in e.issues) i.field: i.message};
      });
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget pair(Widget a, Widget b) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: a),
        const SizedBox(width: VSpace.x3),
        Expanded(child: b),
      ],
    );
    return VModal(
      title: l10n.emailAddImap,
      description: l10n.emailImapHelp,
      icon: LucideIcons.server,
      width: 600,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(
          label: l10n.emailTestAndSave,
          loading: _saving,
          onPressed: _save,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: VSpace.x1_5,
            runSpacing: VSpace.x1_5,
            children: [
              for (final name in _presets.keys)
                VChip(name, onPressed: () => _preset(name)),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: VSpace.x3),
            VBanner(message: _error!, tone: VTone.danger),
          ],
          const SizedBox(height: VSpace.x3),
          pair(
            VTextField(
              controller: _address,
              label: l10n.orgEmail,
              autofocus: true,
              error: _errors['address'],
            ),
            VTextField(controller: _name, label: l10n.emailDisplayName),
          ),
          const SizedBox(height: VSpace.x3),
          pair(
            VTextField(
              controller: _username,
              label: l10n.emailUsername,
              hint: l10n.emailUsernameHint,
            ),
            VTextField(
              controller: _password,
              label: l10n.passwordLabel,
              obscure: true,
              error: _errors['password'],
            ),
          ),
          const SizedBox(height: VSpace.x3),
          pair(
            VTextField(
              controller: _imapHost,
              label: l10n.emailImapServer,
              error: _errors['imap_host'],
            ),
            VTextField(controller: _imapPort, label: l10n.emailPort),
          ),
          const SizedBox(height: VSpace.x3),
          pair(
            VTextField(
              controller: _smtpHost,
              label: l10n.emailSmtpServer,
              error: _errors['smtp_host'],
            ),
            VTextField(controller: _smtpPort, label: l10n.emailPort),
          ),
          const SizedBox(height: VSpace.x3),
          VSegmented<SmtpSecurity>(
            value: _security,
            onChanged: (v) => setState(() => _security = v),
            options: [
              const VSelectOption(SmtpSecurity.tls, 'SSL/TLS'),
              const VSelectOption(SmtpSecurity.starttls, 'STARTTLS'),
              VSelectOption(SmtpSecurity.none, l10n.emailSecurityNone),
            ],
          ),
        ],
      ),
    );
  }
}
