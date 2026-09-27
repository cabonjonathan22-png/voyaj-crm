import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import 'email_data.dart';

/// Valeurs des variables de modèle pour un contact.
Map<String, String?> templateValues(
  ContactRow? contact,
  OrganisationRow? organisation,
  String? userName,
) => {
  'contact.civility': contact?.civility,
  'contact.first_name': contact?.firstName,
  'contact.last_name': contact?.lastName,
  'contact.job_title': contact?.jobTitle,
  'organisation.name': organisation?.name,
  'organisation.city': organisation?.city,
  'user.name': userName,
};

/// Rédaction d'un email (nouveau message ou réponse). Retourne le
/// message envoyé.
Future<EmailMessage?> showComposer(
  BuildContext context, {
  String? to,
  String? subject,
  String? body,
  String? contactId,
  String? organisationId,
  String? inReplyTo,
  String? accountId,
}) => showVModal<EmailMessage>(
  context,
  builder: (_) => _Composer(
    to: to,
    subject: subject,
    body: body,
    contactId: contactId,
    organisationId: organisationId,
    inReplyTo: inReplyTo,
    accountId: accountId,
  ),
);

class _Composer extends ConsumerStatefulWidget {
  const _Composer({
    this.to,
    this.subject,
    this.body,
    this.contactId,
    this.organisationId,
    this.inReplyTo,
    this.accountId,
  });

  final String? to;
  final String? subject;
  final String? body;
  final String? contactId;
  final String? organisationId;
  final String? inReplyTo;
  final String? accountId;

  @override
  ConsumerState<_Composer> createState() => _ComposerState();
}

class _ComposerState extends ConsumerState<_Composer> {
  late final _to = TextEditingController(text: widget.to ?? '');
  final _cc = TextEditingController();
  late final _subject = TextEditingController(text: widget.subject ?? '');
  late final _body = TextEditingController(text: widget.body ?? '');
  String? _accountId;
  Map<String, String> _errors = const {};
  bool _sending = false;

  @override
  void dispose() {
    _to.dispose();
    _cc.dispose();
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  static List<String> _addresses(String text) => [
    for (final a in text.split(RegExp(r'[,;\s]+')))
      if (a.trim().isNotEmpty) a.trim(),
  ];

  void _applyTemplate(EmailTemplateRow template) {
    final contact = ref.read(contactByIdProvider)[widget.contactId];
    final organisation = ref.read(
      organisationByIdProvider,
    )[widget.organisationId ?? contact?.organisationId];
    final values = templateValues(
      contact,
      organisation,
      ref.read(currentUserProvider)?.displayName,
    );
    setState(() {
      _subject.text = renderTemplate(template.subject, values);
      _body.text = renderTemplate(template.body, values);
    });
  }

  Future<void> _send(String accountId) async {
    final l10n = context.l10n;
    setState(() {
      _sending = true;
      _errors = const {};
    });
    try {
      final message = await ref
          .read(emailApiProvider)!
          .send(
            SendEmailRequest(
              accountId: accountId,
              to: _addresses(_to.text),
              cc: _addresses(_cc.text),
              subject: _subject.text,
              body: _body.text,
              contactId: widget.contactId,
              organisationId: widget.organisationId,
              inReplyTo: widget.inReplyTo,
            ),
          );
      ref.read(toastProvider).success(l10n.emailSent);
      if (mounted) Navigator.of(context).pop(message);
    } on ApiFailure catch (e) {
      if (!mounted) return;
      setState(() {
        _errors = {
          for (final i in e.issues) i.field: i.message,
          if (e.issues.isEmpty) '': e.message,
        };
      });
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final accounts = ref.watch(emailAccountsProvider);
    final templates =
        ref.watch(emailTemplatesProvider).value ?? const <EmailTemplateRow>[];
    final list = accounts.value ?? const <EmailAccountInfo>[];
    final accountId =
        _accountId ??
        list.where((a) => a.id == widget.accountId).firstOrNull?.id ??
        list.firstOrNull?.id;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter, control: true): () {
          if (accountId != null && !_sending) unawaited(_send(accountId));
        },
      },
      child: VModal(
        title: widget.inReplyTo == null ? l10n.emailNew : l10n.emailReply,
        icon: LucideIcons.mail,
        width: 680,
        actions: [
          if (templates.isNotEmpty)
            MenuAnchor(
              menuChildren: buildMenuItems(context, [
                for (final t in templates)
                  VMenuItem(
                    label: t.name,
                    icon: LucideIcons.fileText,
                    onSelected: () => _applyTemplate(t),
                  ),
              ]),
              builder: (context, controller, _) => VButton.ghost(
                label: l10n.emailUseTemplate,
                icon: LucideIcons.fileText,
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
              ),
            ),
          const Spacer(),
          VButton(
            label: l10n.cancel,
            onPressed: () => Navigator.of(context).pop(),
          ),
          VButton.primary(
            label: l10n.emailSend,
            icon: LucideIcons.send,
            shortcut: 'Ctrl Entrée',
            loading: _sending,
            onPressed: accountId == null ? null : () => _send(accountId),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (accounts.hasError)
              VBanner(message: l10n.emailOffline, tone: VTone.danger)
            else if (accounts.hasValue && list.isEmpty)
              VBanner(message: l10n.emailNoAccount, tone: VTone.warning)
            else if (list.length > 1)
              VSelect<String>(
                label: l10n.emailFrom,
                value: accountId,
                width: double.infinity,
                options: [for (final a in list) VSelectOption(a.id, a.address)],
                onChanged: (v) => setState(() => _accountId = v),
              ),
            if (_errors[''] != null) ...[
              const SizedBox(height: VSpace.x2),
              VBanner(message: _errors['']!, tone: VTone.danger),
            ],
            const SizedBox(height: VSpace.x3),
            VTextField(
              controller: _to,
              label: l10n.emailTo,
              hint: 'prenom.nom@mairie.fr',
              error: _errors['to'],
              autofocus: widget.to == null,
            ),
            const SizedBox(height: VSpace.x3),
            VTextField(controller: _cc, label: l10n.emailCc),
            const SizedBox(height: VSpace.x3),
            VTextField(
              controller: _subject,
              label: l10n.emailSubject,
              error: _errors['subject'],
              autofocus: widget.to != null,
            ),
            const SizedBox(height: VSpace.x3),
            VTextField(
              controller: _body,
              label: l10n.emailBody,
              maxLines: 14,
              minLines: 8,
            ),
          ],
        ),
      ),
    );
  }
}
