import 'dart:async';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../core/api_client.dart';
import '../../../core/format.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';

/// Taille maximale d'un fichier joint (identique au serveur).
const maxAttachmentBytes = 25 * 1024 * 1024;

const _mimeTypes = {
  'pdf': 'application/pdf',
  'png': 'image/png',
  'jpg': 'image/jpeg',
  'jpeg': 'image/jpeg',
  'gif': 'image/gif',
  'txt': 'text/plain',
  'csv': 'text/csv',
  'doc': 'application/msword',
  'docx':
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  'xls': 'application/vnd.ms-excel',
  'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  'pptx':
      'application/vnd.openxmlformats-officedocument.presentationml.presentation',
  'odt': 'application/vnd.oasis.opendocument.text',
  'ods': 'application/vnd.oasis.opendocument.spreadsheet',
  'zip': 'application/zip',
};

/// Type MIME d'après l'extension du fichier.
String mimeTypeFor(String fileName) =>
    _mimeTypes[p.extension(fileName).replaceFirst('.', '').toLowerCase()] ??
    'application/octet-stream';

/// Taille lisible (`1,2 Mo`).
String formatSize(int bytes) {
  if (bytes < 1024) return '$bytes o';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} Ko';
  return '${(bytes / 1024 / 1024).toStringAsFixed(1).replaceAll('.', ',')} Mo';
}

/// Fichiers joints d'une fiche (envoi et téléchargement : connexion au
/// serveur requise).
class AttachmentsPanel extends ConsumerStatefulWidget {
  const AttachmentsPanel({
    super.key,
    required this.filter,
    this.organisationId,
    this.contactId,
    this.dealId,
  });

  final bool Function(AttachmentRow attachment) filter;
  final String? organisationId;
  final String? contactId;
  final String? dealId;

  @override
  ConsumerState<AttachmentsPanel> createState() => _AttachmentsPanelState();
}

class _AttachmentsPanelState extends ConsumerState<AttachmentsPanel> {
  bool _uploading = false;

  Future<void> _upload() async {
    final l10n = context.l10n;
    final toasts = ref.read(toastProvider);
    final file = await openFile();
    if (file == null) return;
    final api = ref.read(apiClientProvider);
    if (api == null) return;
    final size = await file.length();
    if (size > maxAttachmentBytes) {
      toasts.error(l10n.attachmentTooLarge);
      return;
    }
    setState(() => _uploading = true);
    try {
      final bytes = await file.readAsBytes();
      final mime = file.mimeType ?? mimeTypeFor(file.name);
      final fileId = await api.uploadFile(bytes, mimeType: mime);
      await ref.read(recordStoreProvider).create(SyncEntities.attachments, {
        'file_id': fileId,
        'file_name': file.name,
        'size': size,
        'mime_type': mime,
        'organisation_id': widget.organisationId,
        'contact_id': widget.contactId,
        'deal_id': widget.dealId,
      });
      toasts.success(l10n.attachmentUploaded);
    } on ApiFailure catch (e) {
      toasts.error(e.message);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _download(AttachmentRow attachment) async {
    final l10n = context.l10n;
    final toasts = ref.read(toastProvider);
    final api = ref.read(apiClientProvider);
    if (api == null) return;
    final location = await getSaveLocation(suggestedName: attachment.fileName);
    if (location == null) return;
    try {
      final bytes = await api.downloadFile(attachment.fileId);
      await File(location.path).writeAsBytes(bytes);
      toasts.success(l10n.attachmentDownloaded);
      await launchUrl(Uri.file(location.path));
    } on ApiFailure catch (e) {
      toasts.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.activityWrite));
    final files = [
      for (final a
          in ref.watch(attachmentsProvider).value ?? const <AttachmentRow>[])
        if (widget.filter(a)) a,
    ];

    return ListView(
      padding: const EdgeInsets.all(VSpace.x4),
      children: [
        Row(
          children: [
            Expanded(child: Text(l10n.attachmentsHint, style: t.small)),
            if (canWrite)
              VButton.primary(
                label: l10n.attachmentAdd,
                icon: LucideIcons.paperclip,
                size: VButtonSize.sm,
                loading: _uploading,
                onPressed: () => unawaited(_upload()),
              ),
          ],
        ),
        const SizedBox(height: VSpace.x3),
        if (files.isEmpty)
          EmptyState(icon: LucideIcons.paperclip, title: l10n.attachmentsEmpty),
        for (final file in files)
          VContextMenuRegion(
            items: () => [
              VMenuItem(
                label: l10n.attachmentDownload,
                icon: LucideIcons.download,
                onSelected: () => unawaited(_download(file)),
              ),
              if (canWrite)
                VMenuItem(
                  label: l10n.delete,
                  icon: LucideIcons.trash2,
                  destructive: true,
                  dividerBefore: true,
                  onSelected: () => unawaited(
                    ref.read(recordStoreProvider).delete(
                      SyncEntities.attachments,
                      [file.id],
                    ),
                  ),
                ),
            ],
            child: Pressable(
              onPressed: () => unawaited(_download(file)),
              semanticLabel: file.fileName,
              builder: (context, s) => AnimatedContainer(
                duration: VMotion.fast,
                margin: const EdgeInsets.only(bottom: VSpace.x1_5),
                padding: const EdgeInsets.symmetric(
                  horizontal: VSpace.x3,
                  vertical: VSpace.x2,
                ),
                decoration: BoxDecoration(
                  color: s.hovered ? c.surfaceHover : c.surface,
                  borderRadius: VRadius.mdAll,
                  border: Border.all(color: c.border),
                ),
                child: Row(
                  children: [
                    Icon(LucideIcons.file, size: 16, color: c.textMuted),
                    const SizedBox(width: VSpace.x3),
                    Expanded(
                      child: Text(
                        file.fileName,
                        overflow: TextOverflow.ellipsis,
                        style: t.bodyStrong,
                      ),
                    ),
                    Text(formatSize(file.size), style: t.small),
                    const SizedBox(width: VSpace.x3),
                    Text(formatRelative(file.createdAt), style: t.small),
                    const SizedBox(width: VSpace.x2),
                    Icon(LucideIcons.download, size: 14, color: c.textSubtle),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
