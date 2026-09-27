import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../billing/billing_actions.dart';
import '../crm/crm_format.dart';

/// Export RGPD (droit d'accès) : fichier JSON de toutes les données du
/// contact.
Future<void> exportContactData(
  BuildContext context,
  WidgetRef ref,
  ContactRow contact,
) {
  final api = ref.read(apiClientProvider);
  if (api == null) return Future.value();
  return saveDownload(
    context,
    ref,
    fileName: 'rgpd-${contactName(contact).replaceAll(' ', '-')}.json',
    load: () async => utf8.encode(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(await api.get('/api/v1/gdpr/contacts/${contact.id}/export')),
    ),
  );
}

/// Anonymisation (droit à l'effacement), après confirmation.
Future<void> eraseContactData(
  BuildContext context,
  WidgetRef ref,
  ContactRow contact,
) async {
  final l10n = context.l10n;
  final api = ref.read(apiClientProvider);
  if (api == null) return;
  final ok = await confirm(
    context,
    title: l10n.gdprEraseTitle(contactName(contact)),
    message: l10n.gdprEraseMessage,
    confirmLabel: l10n.gdprErase,
    destructive: true,
  );
  if (!ok) return;
  try {
    await api.post('/api/v1/gdpr/contacts/${contact.id}/erase');
    ref.read(toastProvider).success(l10n.gdprErased);
    await ref.read(syncEngineProvider)?.syncNow();
  } on ApiFailure catch (e) {
    ref.read(toastProvider).error(e.message);
  }
}

/// Bouton « Données personnelles » d'une fiche contact.
class GdprButton extends ConsumerWidget {
  const GdprButton({super.key, required this.contact});

  final ContactRow contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final online = ref.watch(apiClientProvider) != null;
    return MenuAnchor(
      menuChildren: buildMenuItems(context, [
        VMenuItem(
          label: l10n.gdprExport,
          icon: LucideIcons.fileDown,
          onSelected: online
              ? () => unawaited(exportContactData(context, ref, contact))
              : null,
        ),
        VMenuItem(
          label: l10n.gdprErase,
          icon: LucideIcons.eraser,
          destructive: true,
          onSelected: online
              ? () => unawaited(eraseContactData(context, ref, contact))
              : null,
        ),
      ]),
      builder: (context, controller, _) => VIconButton(
        icon: LucideIcons.shieldUser,
        tooltip: l10n.gdprPersonalData,
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
      ),
    );
  }
}
