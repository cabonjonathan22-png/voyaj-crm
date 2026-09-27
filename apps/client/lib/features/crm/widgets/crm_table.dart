import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../crm_actions.dart';
import '../crm_data.dart';
import '../crm_format.dart';
import 'record_tags.dart';
import 'segment_menu.dart';

/// Colonnes des champs personnalisés de [entity].
List<VColumn<T>> customFieldColumns<T>(
  List<CustomFieldRow> fields,
  String? Function(T row) customJson,
) => [
  for (final field in fields)
    VColumn<T>(
      id: 'custom.${field.key}',
      label: field.label,
      width: 150,
      sortValue: (row) {
        final value = decodeCustomValues(customJson(row))[field.key];
        return value is Comparable<Object> ? value : null;
      },
      filterValue: (row) => formatCustomValue(
        field,
        decodeCustomValues(customJson(row))[field.key],
      ),
      cell: (context, row) => Text(
        formatCustomValue(
          field,
          decodeCustomValues(customJson(row))[field.key],
        ),
        overflow: TextOverflow.ellipsis,
        style: context.text.body,
      ),
    ),
];

/// Colonne des tags appliqués.
VColumn<T> tagsColumn<T>(
  String label,
  Map<String, List<Tag>> tagsByRecord,
  String Function(T row) id,
) => VColumn<T>(
  id: 'tags',
  label: label,
  width: 200,
  filterValue: (row) =>
      (tagsByRecord[id(row)] ?? const []).map((t) => t.name).join(', '),
  cell: (context, row) => ClipRect(
    child: Row(
      children: [
        for (final tag in (tagsByRecord[id(row)] ?? const <Tag>[]).take(3))
          Padding(
            padding: const EdgeInsets.only(right: VSpace.x1),
            child: VBadge(tag.name, dotColor: parseHexColor(tag.color)),
          ),
      ],
    ),
  ),
);

/// Tableau standard des listes du CRM : barre d'outils (recherche,
/// filtres, vues, segments), sélection, actions groupées (tags, export,
/// suppression), menu contextuel.
class CrmTable<T> extends ConsumerStatefulWidget {
  const CrmTable({
    super.key,
    required this.tableId,
    required this.entity,
    required this.rows,
    required this.columns,
    required this.rowId,
    required this.onOpen,
    required this.loading,
    required this.empty,
    this.onDelete,
    this.searchFocusNode,
    this.exportName,
    this.extraMenu,
  });

  final String tableId;

  /// Entité des tags et segments (`null` : ni tags ni segments).
  final CrmEntity? entity;
  final List<T> rows;
  final List<VColumn<T>> columns;
  final String Function(T row) rowId;
  final ValueChanged<T> onOpen;
  final bool loading;
  final Widget empty;
  final Future<void> Function(Set<String> ids)? onDelete;
  final FocusNode? searchFocusNode;

  /// Nom du fichier CSV exporté (`null` : pas d'export).
  final String? exportName;
  final List<VMenuItem> Function(T row)? extraMenu;

  @override
  ConsumerState<CrmTable<T>> createState() => _CrmTableState<T>();
}

class _CrmTableState<T> extends ConsumerState<CrmTable<T>> {
  Set<String> _selection = {};

  Future<void> _tagSelection() async {
    final l10n = context.l10n;
    final tagId = await pickTag(context, ref, title: l10n.tagApplyTitle);
    if (tagId == null || !mounted) return;
    final count = await applyTag(
      ref.read(recordStoreProvider),
      entity: widget.entity!,
      recordIds: _selection,
      tagId: tagId,
      taggings: ref.read(taggingsProvider).value ?? const [],
    );
    ref.read(toastProvider).success(l10n.tagApplied(count));
  }

  Future<void> _export(List<T> rows, List<VColumn<T>> columns) async {
    final l10n = context.l10n;
    final location = await getSaveLocation(
      suggestedName: '${widget.exportName}.csv',
      acceptedTypeGroups: const [
        XTypeGroup(label: 'CSV', extensions: ['csv']),
      ],
    );
    if (location == null) return;
    final exportable = [
      for (final c in columns)
        if (c.filterValue != null) c,
    ];
    String cell(String? v) {
      final text = v ?? '';
      return text.contains(RegExp('[;"\n]'))
          ? '"${text.replaceAll('"', '""')}"'
          : text;
    }

    final lines = [
      exportable.map((c) => cell(c.label)).join(';'),
      for (final row in rows)
        exportable.map((c) => cell(c.filterValue!(row))).join(';'),
    ];
    // BOM : Excel reconnaît l'UTF-8.
    await File(
      location.path,
    ).writeAsString('﻿${lines.join('\r\n')}\r\n', encoding: utf8);
    if (mounted) ref.read(toastProvider).success(l10n.exportDone(rows.length));
  }

  Future<void> _delete(Set<String> ids) async {
    await widget.onDelete!(ids);
    if (mounted) setState(() => _selection = {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final view = ref.watch(tableViewProvider(widget.tableId));
    final setView = ref.read(tableViewProvider(widget.tableId).notifier).set;
    final savedViews = ref.watch(savedViewsProvider(widget.tableId));
    final canTag =
        widget.entity != null &&
        ref.watch(permissionProvider(Permission.tagApply));
    final canExport =
        widget.exportName != null &&
        ref.watch(permissionProvider(Permission.dataExport));
    final rows = applyTableView(widget.rows, widget.columns, view);
    final visibleColumns = orderedVisibleColumns(widget.columns, view);
    _selection = _selection.intersection({
      for (final r in widget.rows) widget.rowId(r),
    });

    return CallbackShortcuts(
      bindings: {
        if (widget.onDelete != null)
          const SingleActivator(LogicalKeyboardKey.delete): () {
            if (_selection.isNotEmpty) unawaited(_delete(_selection));
          },
      },
      child: Column(
        children: [
          VTableToolbar<T>(
            columns: widget.columns,
            view: view,
            onViewChanged: setView,
            savedViews: savedViews,
            onSavedViewsChanged: ref
                .read(savedViewsProvider(widget.tableId).notifier)
                .set,
            searchFocusNode: widget.searchFocusNode,
            resultCount: rows.length,
            selectionCount: _selection.length,
            onClearSelection: () => setState(() => _selection = {}),
            bulkActions: [
              if (canTag)
                BulkAction(
                  label: l10n.tagApplyTitle,
                  icon: LucideIcons.tag,
                  onPressed: () => unawaited(_tagSelection()),
                ),
              if (canExport)
                BulkAction(
                  label: l10n.exportCsv,
                  icon: LucideIcons.download,
                  onPressed: () => unawaited(
                    _export([
                      for (final r in rows)
                        if (_selection.contains(widget.rowId(r))) r,
                    ], visibleColumns),
                  ),
                ),
              if (widget.onDelete != null)
                BulkAction(
                  label: l10n.delete,
                  icon: LucideIcons.trash2,
                  destructive: true,
                  onPressed: () => unawaited(_delete(_selection)),
                ),
            ],
            trailing: [
              if (widget.entity != null)
                SegmentMenu(
                  entity: widget.entity!,
                  view: view,
                  onViewChanged: setView,
                ),
              if (canExport)
                VIconButton(
                  icon: LucideIcons.download,
                  tooltip: l10n.exportCsv,
                  onPressed: rows.isEmpty
                      ? null
                      : () => unawaited(_export(rows, visibleColumns)),
                ),
            ],
          ),
          Expanded(
            child: widget.loading && widget.rows.isEmpty
                ? const SkeletonRows()
                : VDataTable<T>(
                    rows: rows,
                    columns: widget.columns,
                    rowId: widget.rowId,
                    view: view,
                    onViewChanged: setView,
                    selection: _selection,
                    onSelectionChanged: (s) => setState(() => _selection = s),
                    onRowActivated: widget.onOpen,
                    rowMenu: (row) => [
                      VMenuItem(
                        label: l10n.open,
                        icon: LucideIcons.externalLink,
                        shortcut: 'Entrée',
                        onSelected: () => widget.onOpen(row),
                      ),
                      ...?widget.extraMenu?.call(row),
                      if (widget.onDelete != null)
                        VMenuItem(
                          label: l10n.delete,
                          icon: LucideIcons.trash2,
                          shortcut: 'Suppr',
                          destructive: true,
                          dividerBefore: true,
                          onSelected: () => unawaited(
                            _delete(
                              _selection.contains(widget.rowId(row))
                                  ? _selection
                                  : {widget.rowId(row)},
                            ),
                          ),
                        ),
                    ],
                    empty: widget.rows.isEmpty
                        ? widget.empty
                        : EmptyState(
                            icon: LucideIcons.searchX,
                            title: l10n.noResultTitle,
                            message: l10n.noResultMessage,
                            action: VButton(
                              label: l10n.resetFilters,
                              onPressed: () => setView(
                                view.copyWith(search: '', filters: const []),
                              ),
                            ),
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
