import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import 'composer.dart';
import 'email_data.dart';
import 'sequences.dart';

/// Onglet « Emails » d'une fiche contact : échanges (comptes de
/// l'utilisateur, en ligne) et séquences en cours.
class ContactEmailsTab extends ConsumerStatefulWidget {
  const ContactEmailsTab({super.key, required this.contact});

  final ContactRow contact;

  @override
  ConsumerState<ContactEmailsTab> createState() => _ContactEmailsTabState();
}

class _ContactEmailsTabState extends ConsumerState<ContactEmailsTab> {
  List<EmailMessage>? _messages;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final api = ref.read(emailApiProvider);
    if (api == null) return;
    try {
      final list = await api.messages(contactId: widget.contact.id);
      if (mounted) setState(() => _messages = list);
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final contact = widget.contact;
    final enrollments = [
      for (final e
          in ref.watch(enrollmentsProvider).value ?? const <EnrollmentRow>[])
        if (e.contactId == contact.id) e,
    ];
    return ListView(
      padding: const EdgeInsets.all(VSpace.x4),
      children: [
        Wrap(
          spacing: VSpace.x2,
          children: [
            VButton.primary(
              label: l10n.emailNew,
              icon: LucideIcons.penLine,
              size: VButtonSize.sm,
              onPressed: contact.email == null
                  ? null
                  : () => unawaited(
                      showComposer(
                        context,
                        to: contact.email,
                        contactId: contact.id,
                        organisationId: contact.organisationId,
                      ).then((sent) {
                        if (sent != null) unawaited(_load());
                      }),
                    ),
            ),
            VButton(
              label: l10n.sequenceEnroll,
              icon: LucideIcons.listOrdered,
              size: VButtonSize.sm,
              onPressed: contact.email == null || contact.doNotContact == true
                  ? null
                  : () => unawaited(
                      enrollContact(context, ref, contactId: contact.id),
                    ),
            ),
          ],
        ),
        if (contact.email == null) ...[
          const SizedBox(height: VSpace.x2),
          Text(l10n.emailContactWithoutAddress, style: t.small),
        ],
        const SizedBox(height: VSpace.x4),
        Text(l10n.emailSequences, style: t.label),
        const SizedBox(height: VSpace.x2),
        EnrollmentList(enrollments: enrollments),
        const SizedBox(height: VSpace.x4),
        Text(l10n.emailExchanges, style: t.label),
        const SizedBox(height: VSpace.x2),
        if (_error != null)
          VBanner(message: _error!, tone: VTone.warning)
        else if (_messages == null)
          const SkeletonRows(rows: 3)
        else if (_messages!.isEmpty)
          Text(l10n.emailEmpty, style: t.small)
        else
          for (final m in _messages!)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: VSpace.x1),
              child: Row(
                children: [
                  Icon(
                    m.direction == 'out' ? LucideIcons.send : LucideIcons.mail,
                    size: 14,
                    color: context.colors.textMuted,
                  ),
                  const SizedBox(width: VSpace.x2),
                  Expanded(
                    child: Text(
                      '${m.subject} — ${m.snippet}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: t.body,
                    ),
                  ),
                  Text(formatDateTime(m.sentAt), style: t.small),
                ],
              ),
            ),
      ],
    );
  }
}
