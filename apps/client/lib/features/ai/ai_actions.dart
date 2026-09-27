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
import '../email/composer.dart';

/// L'assistant IA est-il disponible (connexion, droit, clé côté serveur) ?
final aiEnabledProvider = FutureProvider.autoDispose<bool>((ref) async {
  final api = ref.watch(apiClientProvider);
  if (api == null || !ref.watch(permissionProvider(Permission.aiUse))) {
    return false;
  }
  try {
    final json = await api.get('/api/v1/ai/status');
    return (json! as Map<String, dynamic>)['enabled'] == true;
  } on ApiFailure {
    return false;
  }
});

/// Bouton « Synthèse IA » d'une fiche organisation.
class AiSummaryButton extends ConsumerWidget {
  const AiSummaryButton({super.key, required this.organisationId});

  final String organisationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(aiEnabledProvider).value != true) {
      return const SizedBox.shrink();
    }
    return VButton(
      label: context.l10n.aiSummary,
      icon: LucideIcons.sparkles,
      onPressed: () => unawaited(
        showVModal<void>(
          context,
          builder: (_) => _SummaryModal(organisationId: organisationId),
        ),
      ),
    );
  }
}

class _SummaryModal extends ConsumerStatefulWidget {
  const _SummaryModal({required this.organisationId});

  final String organisationId;

  @override
  ConsumerState<_SummaryModal> createState() => _SummaryModalState();
}

class _SummaryModalState extends ConsumerState<_SummaryModal> {
  String? _text;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    setState(() {
      _text = null;
      _error = null;
    });
    try {
      final json = await ref
          .read(apiClientProvider)!
          .post('/api/v1/ai/organisations/${widget.organisationId}/summary');
      if (mounted) {
        setState(
          () => _text = AiText.fromJson(json! as Map<String, dynamic>).text,
        );
      }
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    return VModal(
      title: l10n.aiSummary,
      icon: LucideIcons.sparkles,
      width: 720,
      actions: [
        if (_text != null)
          VButton(
            label: l10n.copy,
            icon: LucideIcons.copy,
            onPressed: () =>
                unawaited(Clipboard.setData(ClipboardData(text: _text!))),
          ),
        if (_text != null || _error != null)
          VButton(
            label: l10n.aiRegenerate,
            icon: LucideIcons.refreshCw,
            onPressed: () => unawaited(_load()),
          ),
        VButton.primary(
          label: l10n.close,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_error != null)
            VBanner(message: _error!, tone: VTone.danger)
          else if (_text == null)
            Row(
              children: [
                const VSpinner(),
                const SizedBox(width: VSpace.x3),
                Text(l10n.aiWorking, style: t.small),
              ],
            )
          else
            SelectableText(_text!, style: t.body),
          const SizedBox(height: VSpace.x3),
          Text(l10n.aiDisclaimer, style: t.caption),
        ],
      ),
    );
  }
}

/// Bouton « Email avec l'IA » d'une fiche contact : brouillon ouvert dans
/// l'éditeur d'email, à relire avant envoi.
class AiEmailButton extends ConsumerWidget {
  const AiEmailButton({super.key, required this.contact});

  final ContactRow contact;

  Future<void> _draft(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final instructions = await showVModal<String>(
      context,
      builder: (_) => const _InstructionsModal(),
    );
    if (instructions == null || !context.mounted) return;
    final toasts = ref.read(toastProvider)..info(l10n.aiWorking);
    try {
      final json = await ref
          .read(apiClientProvider)!
          .post(
            '/api/v1/ai/email-draft',
            DraftEmailRequest(
              contactId: contact.id,
              instructions: instructions,
            ).toJson(),
          );
      final draft = EmailDraft.fromJson(json! as Map<String, dynamic>);
      if (!context.mounted) return;
      await showComposer(
        context,
        to: contact.email,
        subject: draft.subject,
        body: draft.body,
        contactId: contact.id,
        organisationId: contact.organisationId,
      );
    } on ApiFailure catch (e) {
      toasts.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(aiEnabledProvider).value != true ||
        contact.email == null ||
        !ref.watch(permissionProvider(Permission.emailUse))) {
      return const SizedBox.shrink();
    }
    return VButton(
      label: context.l10n.aiEmail,
      icon: LucideIcons.sparkles,
      onPressed: () => unawaited(_draft(context, ref)),
    );
  }
}

class _InstructionsModal extends StatefulWidget {
  const _InstructionsModal();

  @override
  State<_InstructionsModal> createState() => _InstructionsModalState();
}

class _InstructionsModalState extends State<_InstructionsModal> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _submit() {
    if (_text.text.trim().isEmpty) return;
    Navigator.of(context).pop(_text.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return VModal(
      title: l10n.aiEmail,
      icon: LucideIcons.sparkles,
      width: 560,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(label: l10n.aiWrite, onPressed: _submit),
      ],
      child: VTextField(
        controller: _text,
        label: l10n.aiEmailGoal,
        hint: l10n.aiEmailGoalHint,
        maxLines: 3,
        autofocus: true,
      ),
    );
  }
}
