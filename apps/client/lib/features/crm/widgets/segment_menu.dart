import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../data/records/record_store.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';

/// Critères d'un segment : recherche, filtres et tri d'un tableau.
Map<String, dynamic> segmentConfig(TableViewConfig view) => {
  'search': view.search,
  'filters': [for (final f in view.filters) f.toJson()],
  'sort': view.sortColumn,
  'asc': view.sortAscending,
};

/// Applique les critères d'un segment à la vue (colonnes et largeurs
/// conservées).
TableViewConfig applySegment(TableViewConfig view, SegmentRow segment) {
  final config = TableViewConfig.fromJson(jsonDecodeMap(segment.config));
  return view.copyWith(
    search: config.search,
    filters: config.filters,
    sortColumn: () => config.sortColumn,
    sortAscending: config.sortAscending,
  );
}

/// Décode un objet JSON stocké en texte.
Map<String, dynamic> jsonDecodeMap(String text) =>
    (const JsonDecoder().convert(text) as Map).cast<String, dynamic>();

/// Menu des segments partagés (filtres enregistrés visibles par toute
/// l'équipe) d'une entité.
class SegmentMenu extends ConsumerWidget {
  const SegmentMenu({
    super.key,
    required this.entity,
    required this.view,
    required this.onViewChanged,
  });

  final CrmEntity entity;
  final TableViewConfig view;
  final ValueChanged<TableViewConfig> onViewChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.segmentWrite));
    final segments = [
      for (final s in ref.watch(segmentsProvider).value ?? const <SegmentRow>[])
        if (s.entity == entity.key) s,
    ];
    final current = segmentConfig(view);
    final active = segments
        .where((s) => _sameCriteria(jsonDecodeMap(s.config), current))
        .firstOrNull;
    final store = ref.watch(recordStoreProvider);
    final hasCriteria = view.search.isNotEmpty || view.activeFilterCount > 0;

    Future<void> saveAs() async {
      final saved = await showVModal<String>(
        context,
        builder: (_) => _SegmentForm(entity: entity, config: current),
      );
      if (saved != null && context.mounted) {
        ref.read(toastProvider).success(l10n.segmentSaved);
      }
    }

    return MenuAnchor(
      alignmentOffset: const Offset(0, 4),
      menuChildren: buildMenuItems(context, [
        for (final s in segments)
          VMenuItem(
            label: s.name,
            icon: s.id == active?.id ? LucideIcons.check : LucideIcons.filter,
            onSelected: () => onViewChanged(applySegment(view, s)),
          ),
        if (segments.isEmpty)
          VMenuItem(
            label: l10n.segmentNone,
            icon: LucideIcons.info,
            onSelected: null,
          ),
        if (canWrite && hasCriteria && active == null)
          VMenuItem(
            label: l10n.segmentSaveAs,
            icon: LucideIcons.save,
            dividerBefore: true,
            onSelected: () => unawaited(saveAs()),
          ),
        if (canWrite && active != null)
          VMenuItem(
            label: l10n.segmentDelete(active.name),
            icon: LucideIcons.trash2,
            destructive: true,
            dividerBefore: true,
            onSelected: () =>
                unawaited(store.delete(SyncEntities.segments, [active.id])),
          ),
      ]),
      builder: (context, controller, _) => VButton(
        label: active?.name ?? l10n.segments,
        icon: LucideIcons.layers,
        size: VButtonSize.sm,
        trailingIcon: LucideIcons.chevronDown,
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
      ),
    );
  }

  static bool _sameCriteria(Map<String, dynamic> a, Map<String, dynamic> b) =>
      TableViewConfig.fromJson(a) ==
      TableViewConfig.fromJson(b).copyWith(
        hiddenColumns: const {},
        columnOrder: const [],
        columnWidths: const {},
      );
}

class _SegmentForm extends ConsumerStatefulWidget {
  const _SegmentForm({required this.entity, required this.config});

  final CrmEntity entity;
  final Map<String, dynamic> config;

  @override
  ConsumerState<_SegmentForm> createState() => _SegmentFormState();
}

class _SegmentFormState extends ConsumerState<_SegmentForm> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  Map<String, String> _errors = const {};

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    try {
      final id = await ref
          .read(recordStoreProvider)
          .create(SyncEntities.segments, {
            'name': _name.text,
            'description': _description.text,
            'entity': widget.entity.key,
            'config': widget.config,
          });
      if (mounted) Navigator.of(context).pop(id);
    } on RecordValidationException catch (e) {
      setState(() => _errors = e.byField);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return VModal(
      title: l10n.segmentSaveAs,
      description: l10n.segmentSaveDescription,
      icon: LucideIcons.layers,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(label: l10n.save, onPressed: _save),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VTextField(
            controller: _name,
            label: l10n.segmentName,
            autofocus: true,
            error: _errors['name'],
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _description,
            label: l10n.segmentDescription,
            maxLines: 3,
            minLines: 2,
          ),
        ],
      ),
    );
  }
}
