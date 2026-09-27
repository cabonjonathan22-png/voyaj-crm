import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import 'tag_editor.dart';

const _tableId = 'tags';

/// Liste des tags avec panneau de détail.
class TagsPage extends ConsumerStatefulWidget {
  const TagsPage({super.key, this.initialTagId});

  /// Tag à ouvrir (`?id=`), ou `new` pour une création.
  final String? initialTagId;

  @override
  ConsumerState<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends ConsumerState<TagsPage> {
  final _searchFocus = FocusNode();
  Set<String> _selection = {};

  /// Tag ouvert dans le panneau (`''` = création).
  String? _openId;

  @override
  void initState() {
    super.initState();
    _openId = widget.initialTagId;
  }

  @override
  void didUpdateWidget(covariant TagsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTagId != oldWidget.initialTagId &&
        widget.initialTagId != null) {
      setState(() => _openId = widget.initialTagId);
    }
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  void _open(String? id) {
    setState(() => _openId = id);
    // L'URL reflète le panneau ouvert, sans empiler l'historique.
    if (GoRouterState.of(context).uri.queryParameters.isNotEmpty) {
      context.go(Routes.tags);
    }
  }

  Future<void> _delete(Set<String> ids, List<Tag> tags) async {
    if (ids.isEmpty) return;
    final l10n = context.l10n;
    final names = tags.where((t) => ids.contains(t.id)).map((t) => t.name);
    final ok = await confirm(
      context,
      title: l10n.tagDeleteTitle(ids.length),
      message: l10n.tagDeleteMessage(ids.length, names.take(3).join(', ')),
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await ref.read(tagsRepositoryProvider).delete(ids);
    ref.read(toastProvider).success(l10n.tagDeleted(ids.length));
    setState(() {
      _selection = {};
      if (ids.contains(_openId)) _openId = null;
    });
  }

  List<VColumn<Tag>> _columns(Set<String> pending) {
    final l10n = context.l10n;
    return [
      VColumn(
        id: 'name',
        label: l10n.tagName,
        width: 220,
        hideable: false,
        sortValue: (t) => t.name.toLowerCase(),
        filterValue: (t) => t.name,
        cell: (context, t) => Row(
          children: [
            ColorDot(parseHexColor(t.color)),
            const SizedBox(width: VSpace.x2 + 2),
            Flexible(
              child: Text(
                t.name,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodyStrong,
              ),
            ),
          ],
        ),
      ),
      VColumn(
        id: 'description',
        label: l10n.tagDescription,
        width: 280,
        flex: true,
        sortValue: (t) => (t.description ?? '').toLowerCase(),
        filterValue: (t) => t.description,
        cell: (context, t) => Text(
          t.description ?? '',
          style: context.text.body.copyWith(color: context.colors.textMuted),
        ),
      ),
      VColumn(
        id: 'color',
        label: l10n.tagColor,
        width: 110,
        filterValue: (t) => t.color,
        sortValue: (t) => t.color,
        cell: (context, t) => Text(t.color, style: context.text.mono),
      ),
      VColumn(
        id: 'updated',
        label: l10n.tagUpdated,
        width: 150,
        sortValue: (t) => t.updatedAt,
        cell: (context, t) => Tooltip(
          message: formatDateTime(t.updatedAt),
          child: Text(formatRelative(t.updatedAt), style: context.text.small),
        ),
      ),
      VColumn(
        id: 'sync',
        label: l10n.tagSync,
        width: 130,
        sortValue: (t) => pending.contains(t.id) ? 0 : 1,
        filterValue: (t) => pending.contains(t.id)
            ? l10n.syncStatePending
            : l10n.syncStateSynced,
        cell: (context, t) => pending.contains(t.id)
            ? VBadge(
                l10n.syncStatePending,
                tone: VTone.warning,
                icon: LucideIcons.cloudUpload,
              )
            : VBadge(
                l10n.syncStateSynced,
                tone: VTone.success,
                icon: LucideIcons.cloudCheck,
              ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.tagWrite));
    final tagsAsync = ref.watch(tagsProvider);
    final pending =
        ref.watch(pendingIdsProvider(SyncEntities.tags.name)).value ??
        const <String>{};
    final view = ref.watch(tableViewProvider(_tableId));
    final savedViews = ref.watch(savedViewsProvider(_tableId));
    final tags = tagsAsync.value ?? const <Tag>[];
    final columns = _columns(pending);
    final rows = applyTableView(tags, columns, view);
    final creating = _openId == '' || _openId == 'new';
    final openTag = tags.where((t) => t.id == _openId).firstOrNull;
    final panelOpen = creating || openTag != null;

    return CallbackShortcuts(
      bindings: {
        if (canWrite)
          const SingleActivator(LogicalKeyboardKey.keyN, control: true): () =>
              _open(''),
        const SingleActivator(LogicalKeyboardKey.keyF, control: true):
            _searchFocus.requestFocus,
        if (canWrite)
          const SingleActivator(LogicalKeyboardKey.delete): () =>
              unawaited(_delete(_selection, tags)),
      },
      child: Column(
        children: [
          PageHeader(
            title: l10n.tagsTitle,
            subtitle: l10n.tagsSubtitle,
            icon: LucideIcons.tags,
            actions: [
              if (canWrite)
                VButton.primary(
                  label: l10n.tagsNew,
                  icon: LucideIcons.plus,
                  shortcut: 'Ctrl N',
                  onPressed: () => _open(''),
                ),
            ],
          ),
          Expanded(
            child: VSplitView(
              showSecondary: panelOpen,
              secondary: panelOpen
                  ? TagEditor(
                      key: ValueKey(creating ? 'new' : openTag!.id),
                      tag: creating ? null : openTag,
                      pending: openTag != null && pending.contains(openTag.id),
                      onClose: () => _open(null),
                      onSaved: (id) => setState(() => _openId = id),
                    )
                  : const SizedBox.shrink(),
              primary: Column(
                children: [
                  VTableToolbar<Tag>(
                    columns: columns,
                    view: view,
                    onViewChanged: ref
                        .read(tableViewProvider(_tableId).notifier)
                        .set,
                    savedViews: savedViews,
                    onSavedViewsChanged: ref
                        .read(savedViewsProvider(_tableId).notifier)
                        .set,
                    searchFocusNode: _searchFocus,
                    resultCount: rows.length,
                    selectionCount: _selection.length,
                    onClearSelection: () => setState(() => _selection = {}),
                    bulkActions: [
                      if (canWrite)
                        BulkAction(
                          label: l10n.delete,
                          icon: LucideIcons.trash2,
                          destructive: true,
                          onPressed: () => _delete(_selection, tags),
                        ),
                    ],
                  ),
                  Expanded(
                    child: tagsAsync.isLoading && tags.isEmpty
                        ? const SkeletonRows()
                        : VDataTable<Tag>(
                            rows: rows,
                            columns: columns,
                            rowId: (t) => t.id,
                            view: view,
                            onViewChanged: ref
                                .read(tableViewProvider(_tableId).notifier)
                                .set,
                            selection: _selection,
                            onSelectionChanged: (s) =>
                                setState(() => _selection = s),
                            activeRowId: openTag?.id,
                            onRowActivated: (t) => _open(t.id),
                            rowMenu: (t) => [
                              VMenuItem(
                                label: canWrite ? l10n.edit : l10n.open,
                                icon: LucideIcons.pencil,
                                shortcut: 'Entrée',
                                onSelected: () => _open(t.id),
                              ),
                              VMenuItem(
                                label: l10n.copyName,
                                icon: LucideIcons.copy,
                                onSelected: () => Clipboard.setData(
                                  ClipboardData(text: t.name),
                                ),
                              ),
                              if (canWrite)
                                VMenuItem(
                                  label: l10n.delete,
                                  icon: LucideIcons.trash2,
                                  shortcut: 'Suppr',
                                  destructive: true,
                                  dividerBefore: true,
                                  onSelected: () => _delete(
                                    _selection.contains(t.id)
                                        ? _selection
                                        : {t.id},
                                    tags,
                                  ),
                                ),
                            ],
                            empty: tags.isEmpty
                                ? EmptyState(
                                    icon: LucideIcons.tags,
                                    title: l10n.tagsEmptyTitle,
                                    message: l10n.tagsEmptyMessage,
                                    action: canWrite
                                        ? VButton.primary(
                                            label: l10n.tagsNew,
                                            icon: LucideIcons.plus,
                                            onPressed: () => _open(''),
                                          )
                                        : null,
                                  )
                                : EmptyState(
                                    icon: LucideIcons.searchX,
                                    title: l10n.noResultTitle,
                                    message: l10n.noResultMessage,
                                    action: VButton(
                                      label: l10n.resetFilters,
                                      onPressed: () => ref
                                          .read(
                                            tableViewProvider(
                                              _tableId,
                                            ).notifier,
                                          )
                                          .set(
                                            view.copyWith(
                                              search: '',
                                              filters: const [],
                                            ),
                                          ),
                                    ),
                                  ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
