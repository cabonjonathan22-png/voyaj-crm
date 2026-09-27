import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import 'tags_repository.dart';

/// Panneau de création / modification d'un tag.
class TagEditor extends ConsumerStatefulWidget {
  const TagEditor({
    super.key,
    required this.tag,
    required this.onClose,
    required this.onSaved,
    required this.pending,
  });

  /// `null` : création.
  final Tag? tag;
  final VoidCallback onClose;
  final ValueChanged<String> onSaved;

  /// Modifications locales pas encore synchronisées.
  final bool pending;

  @override
  ConsumerState<TagEditor> createState() => _TagEditorState();
}

class _TagEditorState extends ConsumerState<TagEditor> {
  late final _name = TextEditingController(text: widget.tag?.name ?? '');
  late final _description = TextEditingController(
    text: widget.tag?.description ?? '',
  );
  late String _color = widget.tag?.color ?? tagPalette.first;
  Map<String, String> _errors = const {};
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  TagDraft get _draft =>
      (name: _name.text, color: _color, description: _description.text);

  bool get _dirty =>
      widget.tag == null ||
      _name.text.trim() != widget.tag!.name ||
      _color != widget.tag!.color ||
      (_description.text.trim().isEmpty ? null : _description.text.trim()) !=
          widget.tag!.description;

  Future<void> _save() async {
    final repository = ref.read(tagsRepositoryProvider);
    final issues = repository.validate(_draft);
    if (issues.isNotEmpty) {
      setState(() => _errors = {for (final i in issues) i.field: i.message});
      return;
    }
    setState(() {
      _saving = true;
      _errors = const {};
    });
    try {
      final l10n = context.l10n;
      final toasts = ref.read(toastProvider);
      if (widget.tag == null) {
        final id = await repository.create(_draft);
        toasts.success(l10n.tagCreated);
        widget.onSaved(id);
      } else {
        await repository.update(widget.tag!.id, _draft);
        toasts.success(l10n.tagSaved);
        widget.onSaved(widget.tag!.id);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.tagWrite));
    final tag = widget.tag;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter, control: true): () {
          if (canWrite) unawaited(_save());
        },
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () {
          if (canWrite) unawaited(_save());
        },
        const SingleActivator(LogicalKeyboardKey.escape): widget.onClose,
      },
      child: FocusScope(
        child: ColoredBox(
          color: c.backgroundSubtle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 48,
                padding: const EdgeInsets.only(
                  left: VSpace.x4,
                  right: VSpace.x2,
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: c.border)),
                ),
                child: Row(
                  children: [
                    Text(
                      tag == null ? l10n.tagNewTitle : l10n.tagDetailsTitle,
                      style: t.heading,
                    ),
                    const SizedBox(width: VSpace.x2),
                    if (widget.pending)
                      VBadge(
                        l10n.syncStatePending,
                        tone: VTone.warning,
                        icon: LucideIcons.cloudUpload,
                      ),
                    const Spacer(),
                    VIconButton(
                      icon: LucideIcons.x,
                      tooltip: '${l10n.close} (Échap)',
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(VSpace.x4),
                  children: [
                    VTextField(
                      controller: _name,
                      label: l10n.tagName,
                      autofocus: tag == null,
                      enabled: canWrite,
                      maxLength: tagNameMaxLength,
                      error: _errors['name'],
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _save(),
                    ),
                    const SizedBox(height: VSpace.x4),
                    Text(l10n.tagColor, style: t.label),
                    const SizedBox(height: VSpace.x2),
                    Wrap(
                      spacing: VSpace.x1_5,
                      runSpacing: VSpace.x1_5,
                      children: [
                        for (final color in tagPalette)
                          _Swatch(
                            color: color,
                            selected: color == _color,
                            onTap: canWrite
                                ? () => setState(() => _color = color)
                                : null,
                          ),
                      ],
                    ),
                    if (_errors['color'] != null) ...[
                      const SizedBox(height: VSpace.x1),
                      Text(
                        _errors['color']!,
                        style: t.small.copyWith(color: c.danger),
                      ),
                    ],
                    const SizedBox(height: VSpace.x4),
                    VTextField(
                      controller: _description,
                      label: l10n.tagDescription,
                      hint: l10n.tagDescriptionHint,
                      enabled: canWrite,
                      maxLines: 5,
                      minLines: 3,
                      maxLength: tagDescriptionMaxLength,
                      error: _errors['description'],
                      onChanged: (_) => setState(() {}),
                    ),
                    if (tag != null) ...[
                      const SizedBox(height: VSpace.x5),
                      Divider(height: 1, color: c.border),
                      const SizedBox(height: VSpace.x4),
                      _Meta(l10n.metaCreated, formatDateTime(tag.createdAt)),
                      _Meta(l10n.metaUpdated, formatDateTime(tag.updatedAt)),
                      _Meta(
                        l10n.metaVersion,
                        tag.version == 0 ? '—' : '${tag.version}',
                      ),
                    ],
                  ],
                ),
              ),
              if (canWrite)
                Container(
                  padding: const EdgeInsets.all(VSpace.x3),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: c.border)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VButton(label: l10n.cancel, onPressed: widget.onClose),
                      const SizedBox(width: VSpace.x2),
                      VButton.primary(
                        label: tag == null ? l10n.create : l10n.save,
                        shortcut: 'Ctrl S',
                        loading: _saving,
                        onPressed: _dirty ? _save : null,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String color;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final value = parseHexColor(color);
    return Pressable(
      onPressed: onTap,
      semanticLabel: color,
      builder: (context, s) => AnimatedContainer(
        duration: VMotion.fast,
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: value,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected || s.focused ? c.text : Colors.transparent,
            width: 2,
          ),
          boxShadow: s.hovered
              ? [BoxShadow(color: value.withValues(alpha: 0.5), blurRadius: 6)]
              : null,
        ),
        child: selected
            ? const Icon(LucideIcons.check, size: 14, color: Colors.white)
            : null,
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: VSpace.x2),
    child: Row(
      children: [
        SizedBox(width: 120, child: Text(label, style: context.text.small)),
        Expanded(child: Text(value, style: context.text.body)),
      ],
    ),
  );
}
