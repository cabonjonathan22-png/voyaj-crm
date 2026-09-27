import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../data/local/database.dart';
import '../../data/sync/local_entities.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import '../crm/widgets/record_form.dart';
import '../settings/settings_page.dart';
import 'composer.dart';
import 'email_data.dart';
import 'sequences.dart';

/// Messagerie : boîte de réception (en ligne), modèles et séquences.
class EmailsPage extends ConsumerStatefulWidget {
  const EmailsPage({super.key});

  @override
  ConsumerState<EmailsPage> createState() => _EmailsPageState();
}

class _EmailsPageState extends ConsumerState<EmailsPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canTemplates = ref.watch(
      permissionProvider(Permission.emailTemplateWrite),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navEmails,
          subtitle: l10n.emailsSubtitle,
          icon: LucideIcons.mail,
          actions: [
            if (_tab == 0)
              VButton.primary(
                label: l10n.emailNew,
                icon: LucideIcons.penLine,
                onPressed: () => unawaited(showComposer(context)),
              ),
            if (_tab == 1 && canTemplates)
              VButton.primary(
                label: l10n.templateNew,
                icon: LucideIcons.plus,
                onPressed: () => unawaited(_editTemplate(context, ref)),
              ),
            if (_tab == 2 && canTemplates)
              VButton.primary(
                label: l10n.sequenceNew,
                icon: LucideIcons.plus,
                onPressed: () => unawaited(showSequenceForm(context)),
              ),
          ],
        ),
        VTabBar(
          index: _tab,
          onChanged: (i) => setState(() => _tab = i),
          tabs: [
            VTab(l10n.emailInbox, icon: LucideIcons.inbox),
            VTab(
              l10n.emailTemplates,
              icon: LucideIcons.fileText,
              count:
                  (ref.watch(emailTemplatesProvider).value ?? const []).length,
            ),
            VTab(
              l10n.emailSequences,
              icon: LucideIcons.listOrdered,
              count:
                  (ref.watch(emailSequencesProvider).value ?? const []).length,
            ),
          ],
        ),
        Expanded(
          child: switch (_tab) {
            0 => const _Inbox(),
            1 => const _Templates(),
            _ => const _Sequences(),
          },
        ),
      ],
    );
  }
}

Future<void> _editTemplate(
  BuildContext context,
  WidgetRef ref, {
  EmailTemplateRow? template,
}) => showRecordForm(
  context,
  schema: SyncEntities.emailTemplates,
  title: template == null
      ? context.l10n.templateNew
      : context.l10n.templateEdit,
  icon: LucideIcons.fileText,
  id: template?.id,
  width: 680,
  initial: template == null
      ? const {}
      : rowToWire(SyncEntities.emailTemplates, template),
  fields: [
    TextFieldDef(
      'name',
      context.l10n.templateName,
      wide: true,
      autofocus: true,
    ),
    TextFieldDef('subject', context.l10n.emailSubject, wide: true),
    TextFieldDef(
      'body',
      context.l10n.emailBody,
      wide: true,
      maxLines: 12,
      hint: context.l10n.templateBodyHint,
    ),
    TextFieldDef('description', context.l10n.segmentDescription, wide: true),
  ],
);

// ── Boîte de réception ─────────────────────────────────────────────────

class _Inbox extends ConsumerStatefulWidget {
  const _Inbox();

  @override
  ConsumerState<_Inbox> createState() => _InboxState();
}

class _InboxState extends ConsumerState<_Inbox> {
  String? _accountId;
  List<EmailMessage>? _messages;
  EmailMessage? _open;
  String? _error;
  bool _syncing = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final api = ref.read(emailApiProvider);
    if (api == null) return;
    try {
      final messages = await api.messages(accountId: _accountId, limit: 100);
      if (mounted) {
        setState(() {
          _messages = messages;
          _error = null;
        });
      }
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    }
  }

  Future<void> _sync(List<EmailAccountInfo> accounts) async {
    setState(() => _syncing = true);
    try {
      for (final a in accounts) {
        if (_accountId == null || a.id == _accountId) {
          await ref.read(emailApiProvider)!.sync(a.id);
        }
      }
      ref.invalidate(emailAccountsProvider);
      await _load();
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  Future<void> _openMessage(EmailMessage summary) async {
    setState(() => _open = summary);
    try {
      final full = await ref.read(emailApiProvider)!.message(summary.id);
      if (mounted && _open?.id == summary.id) setState(() => _open = full);
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final accountsAsync = ref.watch(emailAccountsProvider);
    if (_error != null || accountsAsync.hasError) {
      return EmptyState(
        icon: LucideIcons.wifiOff,
        title: l10n.onlineOnlyTitle,
        message: _error ?? l10n.emailOffline,
        action: VButton(
          label: l10n.retry,
          onPressed: () {
            ref.invalidate(emailAccountsProvider);
            unawaited(_load());
          },
        ),
      );
    }
    final accounts = accountsAsync.value;
    if (accounts == null || _messages == null) return const SkeletonRows();
    if (accounts.isEmpty) {
      return EmptyState(
        icon: LucideIcons.mailPlus,
        title: l10n.emailNoAccountTitle,
        message: l10n.emailNoAccount,
        action: VButton.primary(
          label: l10n.emailConnectAccount,
          icon: LucideIcons.plug,
          onPressed: () => context.go(
            '${Routes.settings}/${SettingsSection.emailAccounts.name}',
          ),
        ),
      );
    }
    final contacts = ref.watch(contactByIdProvider);
    final errors = [
      for (final a in accounts)
        if (a.lastError != null) '${a.address} : ${a.lastError}',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            VSpace.x4,
            VSpace.x3,
            VSpace.x4,
            VSpace.x3,
          ),
          child: Row(
            children: [
              VSelect<String?>(
                value: _accountId,
                width: 280,
                options: [
                  VSelectOption(null, l10n.emailAllAccounts),
                  for (final a in accounts) VSelectOption(a.id, a.address),
                ],
                onChanged: (v) {
                  setState(() {
                    _accountId = v;
                    _messages = null;
                  });
                  unawaited(_load());
                },
              ),
              const Spacer(),
              VButton(
                label: l10n.emailSyncNow,
                icon: LucideIcons.refreshCw,
                loading: _syncing,
                onPressed: () => unawaited(_sync(accounts)),
              ),
            ],
          ),
        ),
        if (errors.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              VSpace.x4,
              0,
              VSpace.x4,
              VSpace.x3,
            ),
            child: VBanner(message: errors.join('\n'), tone: VTone.danger),
          ),
        Expanded(
          child: VSplitView(
            showSecondary: _open != null,
            secondary: _open == null
                ? const SizedBox.shrink()
                : _MessageView(
                    message: _open!,
                    onClose: () => setState(() => _open = null),
                  ),
            primary: _messages!.isEmpty
                ? EmptyState(icon: LucideIcons.inbox, title: l10n.emailEmpty)
                : ListView.builder(
                    itemCount: _messages!.length,
                    itemBuilder: (context, i) {
                      final m = _messages![i];
                      final contact = contacts[m.contactId];
                      final who = m.direction == 'out'
                          ? l10n.emailToPrefix(
                              m.to.map((a) => a.name ?? a.address).join(', '),
                            )
                          : m.from.name ?? m.from.address;
                      return Pressable(
                        onPressed: () => unawaited(_openMessage(m)),
                        semanticLabel: m.subject,
                        builder: (context, s) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: VSpace.x4,
                            vertical: VSpace.x2 + 2,
                          ),
                          decoration: BoxDecoration(
                            color: _open?.id == m.id
                                ? c.surfaceSelected
                                : s.hovered
                                ? c.surfaceHover
                                : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(color: c.borderSubtle),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                m.direction == 'out'
                                    ? LucideIcons.send
                                    : LucideIcons.mail,
                                size: 14,
                                color: m.read ? c.textSubtle : c.accent,
                              ),
                              const SizedBox(width: VSpace.x3),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  who,
                                  overflow: TextOverflow.ellipsis,
                                  style: m.read ? t.body : t.bodyStrong,
                                ),
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: m.subject,
                                        style: m.read ? t.body : t.bodyStrong,
                                      ),
                                      TextSpan(
                                        text: '  ${m.snippet}',
                                        style: t.small,
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (contact != null) ...[
                                const SizedBox(width: VSpace.x2),
                                VBadge(
                                  contactName(contact),
                                  icon: LucideIcons.user,
                                  tone: VTone.accent,
                                ),
                              ],
                              const SizedBox(width: VSpace.x3),
                              Text(formatRelative(m.sentAt), style: t.small),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _MessageView extends ConsumerWidget {
  const _MessageView({required this.message, required this.onClose});

  final EmailMessage message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final m = message;
    final contact = ref.watch(contactByIdProvider)[m.contactId];
    return ColoredBox(
      color: c.backgroundSubtle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
              VSpace.x4,
              VSpace.x3,
              VSpace.x2,
              VSpace.x3,
            ),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: c.border)),
            ),
            child: Row(
              children: [
                Expanded(child: SelectableText(m.subject, style: t.heading)),
                if (m.direction == 'in')
                  VButton(
                    label: l10n.emailReply,
                    icon: LucideIcons.reply,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(
                      showComposer(
                        context,
                        to: m.from.address,
                        subject: m.subject.toLowerCase().startsWith('re:')
                            ? m.subject
                            : 'Re: ${m.subject}',
                        body:
                            '\n\n${l10n.emailQuoteHeader(formatDateTime(m.sentAt), m.from.address)}\n'
                            '${(m.bodyText ?? '').split('\n').map((l) => '> $l').join('\n')}',
                        contactId: m.contactId,
                        organisationId: m.organisationId,
                        inReplyTo: m.messageId,
                        accountId: m.accountId,
                      ),
                    ),
                  ),
                VIconButton(
                  icon: LucideIcons.x,
                  tooltip: l10n.close,
                  onPressed: onClose,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(VSpace.x4),
              children: [
                VInfoRow(
                  l10n.emailFrom,
                  [
                    m.from.name,
                    '<${m.from.address}>',
                  ].whereType<String>().join(' '),
                  labelWidth: 70,
                ),
                VInfoRow(
                  l10n.emailTo,
                  m.to.map((a) => a.address).join(', '),
                  labelWidth: 70,
                ),
                if (m.cc.isNotEmpty)
                  VInfoRow(
                    l10n.emailCc,
                    m.cc.map((a) => a.address).join(', '),
                    labelWidth: 70,
                  ),
                VInfoRow(
                  l10n.emailDate,
                  formatDateTime(m.sentAt),
                  labelWidth: 70,
                ),
                if (contact != null)
                  VInfoRow(
                    l10n.dealContact,
                    null,
                    labelWidth: 70,
                    child: VLink(
                      contactName(contact),
                      onPressed: () =>
                          context.go('${Routes.contacts}/${contact.id}'),
                    ),
                  ),
                const SizedBox(height: VSpace.x3),
                Divider(height: 1, color: c.border),
                const SizedBox(height: VSpace.x3),
                if (m.bodyText == null)
                  const SkeletonRows(rows: 4)
                else
                  SelectableText(m.bodyText!, style: t.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Modèles ────────────────────────────────────────────────────────────

class _Templates extends ConsumerWidget {
  const _Templates();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final t = context.text;
    final canWrite = ref.watch(
      permissionProvider(Permission.emailTemplateWrite),
    );
    final templates =
        ref.watch(emailTemplatesProvider).value ?? const <EmailTemplateRow>[];
    return ListView(
      padding: const EdgeInsets.all(VSpace.x6),
      children: [
        VBanner(
          icon: LucideIcons.braces,
          message: l10n.templateVariablesHelp(
            templateVariables.keys.map((k) => '{{$k}}').join('  '),
          ),
        ),
        const SizedBox(height: VSpace.x4),
        if (templates.isEmpty)
          EmptyState(icon: LucideIcons.fileText, title: l10n.templatesEmpty),
        for (final template in templates)
          Padding(
            padding: const EdgeInsets.only(bottom: VSpace.x3),
            child: VCard(
              title: template.name,
              description: template.subject,
              actions: [
                if (canWrite) ...[
                  VIconButton(
                    icon: LucideIcons.pencil,
                    tooltip: l10n.edit,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(
                      _editTemplate(context, ref, template: template),
                    ),
                  ),
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(
                      ref.read(recordStoreProvider).delete(
                        SyncEntities.emailTemplates,
                        [template.id],
                      ),
                    ),
                  ),
                ],
              ],
              child: Text(
                template.body,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: t.body.copyWith(color: context.colors.textMuted),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Séquences ──────────────────────────────────────────────────────────

class _Sequences extends ConsumerWidget {
  const _Sequences();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final t = context.text;
    final canWrite = ref.watch(
      permissionProvider(Permission.emailTemplateWrite),
    );
    final sequences =
        ref.watch(emailSequencesProvider).value ?? const <EmailSequenceRow>[];
    final templates = {
      for (final t
          in ref.watch(emailTemplatesProvider).value ??
              const <EmailTemplateRow>[])
        t.id: t,
    };
    final enrollments =
        ref.watch(enrollmentsProvider).value ?? const <EnrollmentRow>[];
    return ListView(
      padding: const EdgeInsets.all(VSpace.x6),
      children: [
        VBanner(icon: LucideIcons.info, message: l10n.sequencesHelp),
        const SizedBox(height: VSpace.x4),
        if (sequences.isEmpty)
          EmptyState(icon: LucideIcons.listOrdered, title: l10n.sequencesEmpty),
        for (final sequence in sequences)
          Padding(
            padding: const EdgeInsets.only(bottom: VSpace.x3),
            child: VCard(
              title: sequence.name,
              description: sequence.description,
              actions: [
                if (sequence.active == false) VBadge(l10n.sequenceInactive),
                if (canWrite) ...[
                  VIconButton(
                    icon: LucideIcons.pencil,
                    tooltip: l10n.edit,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(
                      showSequenceForm(context, sequence: sequence),
                    ),
                  ),
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(
                      ref.read(recordStoreProvider).delete(
                        SyncEntities.emailSequences,
                        [sequence.id],
                      ),
                    ),
                  ),
                ],
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (i, step) in sequenceSteps(sequence.steps).indexed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: VSpace.x1),
                      child: Text(
                        l10n.sequenceStepLine(
                          i + 1,
                          step.delayDays,
                          templates[step.templateId]?.name ?? '—',
                        ),
                        style: t.body,
                      ),
                    ),
                  const SizedBox(height: VSpace.x2),
                  EnrollmentList(
                    enrollments: [
                      for (final e in enrollments)
                        if (e.sequenceId == sequence.id) e,
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
