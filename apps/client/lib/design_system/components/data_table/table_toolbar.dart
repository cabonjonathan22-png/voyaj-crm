import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../theme/app_theme.dart';
import '../../tokens/dimensions.dart';
import '../button.dart';
import '../modal.dart';
import '../select.dart';
import '../text_field.dart';
import 'data_table.dart';
import 'table_view_config.dart';

/// Action groupée proposée quand des lignes sont sélectionnées.
@immutable
final class BulkAction {
  const BulkAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.destructive = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool destructive;
}

/// Barre d'outils d'un [VDataTable].
class VTableToolbar<T> extends StatefulWidget {
  const VTableToolbar({
    super.key,
    required this.columns,
    required this.view,
    required this.onViewChanged,
    required this.savedViews,
    required this.onSavedViewsChanged,
    this.searchFocusNode,
    this.selectionCount = 0,
    this.onClearSelection,
    this.bulkActions = const [],
    this.trailing = const [],
    this.resultCount,
  });

  final List<VColumn<T>> columns;
  final TableViewConfig view;
  final ValueChanged<TableViewConfig> onViewChanged;
  final List<SavedTableView> savedViews;
  final ValueChanged<List<SavedTableView>> onSavedViewsChanged;
  final FocusNode? searchFocusNode;
  final int selectionCount;
  final VoidCallback? onClearSelection;
  final List<BulkAction> bulkActions;
  final List<Widget> trailing;
  final int? resultCount;

  @override
  State<VTableToolbar<T>> createState() => _VTableToolbarState<T>();
}

class _VTableToolbarState<T> extends State<VTableToolbar<T>> {
  late final _search = TextEditingController(text: widget.view.search);

  @override
  void didUpdateWidget(covariant VTableToolbar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.view.search != _search.text) _search.text = widget.view.search;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  String? get _currentViewName => widget.savedViews
      .where((v) => v.config == widget.view)
      .map((v) => v.name)
      .firstOrNull;

  Future<void> _editFilters() async {
    final result = await showVModal<List<ColumnFilter>>(
      context,
      builder: (context) => _FilterEditor<T>(
        columns: [
          for (final c in widget.columns)
            if (c.filterValue != null) c,
        ],
        initial: widget.view.filters,
      ),
    );
    if (result != null) {
      widget.onViewChanged(widget.view.copyWith(filters: result));
    }
  }

  Future<void> _saveView() async {
    final controller = TextEditingController(text: _currentViewName ?? '');
    final name = await showVModal<String>(
      context,
      builder: (context) => VModal(
        title: 'Enregistrer la vue',
        description: 'Tri, filtres, recherche et colonnes sont mémorisés.',
        width: 400,
        actions: [
          VButton(
            label: 'Annuler',
            onPressed: () => Navigator.of(context).pop(),
          ),
          VButton.primary(
            label: 'Enregistrer',
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          ),
        ],
        child: VTextField(
          controller: controller,
          label: 'Nom de la vue',
          autofocus: true,
          onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
        ),
      ),
    );
    controller.dispose();
    if (name == null || name.isEmpty) return;
    widget.onSavedViewsChanged([
      for (final v in widget.savedViews)
        if (v.name != name) v,
      SavedTableView(name: name, config: widget.view),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;

    if (widget.selectionCount > 0) {
      return _bar(c.accentSubtle, [
        Text(
          '${widget.selectionCount} sélectionné'
          '${widget.selectionCount > 1 ? 's' : ''}',
          style: t.bodyStrong.copyWith(color: c.accentText),
        ),
        const SizedBox(width: VSpace.x3),
        for (final action in widget.bulkActions) ...[
          if (action.destructive)
            VButton.danger(
              label: action.label,
              icon: action.icon,
              size: VButtonSize.sm,
              onPressed: action.onPressed,
            )
          else
            VButton(
              label: action.label,
              icon: action.icon,
              size: VButtonSize.sm,
              onPressed: action.onPressed,
            ),
          const SizedBox(width: VSpace.x2),
        ],
        const Spacer(),
        VButton.ghost(
          label: 'Désélectionner',
          shortcut: 'Échap',
          size: VButtonSize.sm,
          onPressed: widget.onClearSelection,
        ),
      ]);
    }

    final filterCount = widget.view.activeFilterCount;
    final viewName = _currentViewName;
    return _bar(c.background, [
      SizedBox(
        width: 260,
        child: VTextField(
          controller: _search,
          focusNode: widget.searchFocusNode,
          dense: true,
          hint: 'Rechercher…',
          prefixIcon: LucideIcons.search,
          onChanged: (v) =>
              widget.onViewChanged(widget.view.copyWith(search: v)),
        ),
      ),
      const SizedBox(width: VSpace.x2),
      VButton(
        label: filterCount == 0 ? 'Filtrer' : 'Filtres ($filterCount)',
        icon: LucideIcons.listFilter,
        size: VButtonSize.sm,
        onPressed: _editFilters,
      ),
      const SizedBox(width: VSpace.x2),
      MenuAnchor(
        menuChildren: [
          for (final col in widget.columns)
            CheckboxMenuButton(
              value: !widget.view.hiddenColumns.contains(col.id),
              onChanged: col.hideable
                  ? (visible) {
                      final hidden = Set<String>.of(widget.view.hiddenColumns);
                      visible! ? hidden.remove(col.id) : hidden.add(col.id);
                      widget.onViewChanged(
                        widget.view.copyWith(hiddenColumns: hidden),
                      );
                    }
                  : null,
              closeOnActivate: false,
              child: Text(col.label),
            ),
          const Divider(height: 9),
          MenuItemButton(
            leadingIcon: const Icon(LucideIcons.rotateCcw),
            onPressed: () => widget.onViewChanged(
              widget.view.copyWith(
                hiddenColumns: {},
                columnWidths: {},
                columnOrder: [],
              ),
            ),
            child: const Text('Réinitialiser les colonnes'),
          ),
        ],
        builder: (context, controller, _) => VButton(
          label: 'Colonnes',
          icon: LucideIcons.columns3,
          size: VButtonSize.sm,
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
        ),
      ),
      const SizedBox(width: VSpace.x2),
      MenuAnchor(
        menuChildren: [
          MenuItemButton(
            leadingIcon: const Icon(LucideIcons.layoutList),
            onPressed: () => widget.onViewChanged(const TableViewConfig()),
            child: const Text('Vue par défaut'),
          ),
          for (final view in widget.savedViews)
            MenuItemButton(
              leadingIcon: const Icon(LucideIcons.bookmark),
              trailingIcon: IconButton(
                icon: const Icon(LucideIcons.trash2, size: 14),
                tooltip: 'Supprimer la vue',
                visualDensity: VisualDensity.compact,
                onPressed: () => widget.onSavedViewsChanged([
                  for (final v in widget.savedViews)
                    if (v.name != view.name) v,
                ]),
              ),
              onPressed: () => widget.onViewChanged(view.config),
              child: Text(view.name),
            ),
          const Divider(height: 9),
          MenuItemButton(
            leadingIcon: const Icon(LucideIcons.bookmarkPlus),
            onPressed: _saveView,
            child: const Text('Enregistrer la vue actuelle…'),
          ),
        ],
        builder: (context, controller, _) => VButton.ghost(
          label: viewName ?? 'Vues',
          icon: LucideIcons.bookmark,
          trailingIcon: LucideIcons.chevronDown,
          size: VButtonSize.sm,
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
        ),
      ),
      const Spacer(),
      if (widget.resultCount != null)
        Padding(
          padding: const EdgeInsets.only(right: VSpace.x3),
          child: Text(
            '${widget.resultCount} élément${widget.resultCount == 1 ? '' : 's'}',
            style: t.small,
          ),
        ),
      ...widget.trailing,
    ]);
  }

  Widget _bar(Color color, List<Widget> children) => AnimatedContainer(
    duration: VMotion.fast,
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: VSpace.x4),
    decoration: BoxDecoration(
      color: color,
      border: Border(bottom: BorderSide(color: context.colors.border)),
    ),
    child: Row(children: children),
  );
}

class _FilterEditor<T> extends StatefulWidget {
  const _FilterEditor({required this.columns, required this.initial});

  final List<VColumn<T>> columns;
  final List<ColumnFilter> initial;

  @override
  State<_FilterEditor<T>> createState() => _FilterEditorState<T>();
}

class _FilterEditorState<T> extends State<_FilterEditor<T>> {
  late final List<ColumnFilter> _filters = [...widget.initial];
  late final List<TextEditingController> _values = [
    for (final f in widget.initial) TextEditingController(text: f.value),
  ];

  @override
  void dispose() {
    for (final c in _values) {
      c.dispose();
    }
    super.dispose();
  }

  void _add() => setState(() {
    _filters.add(ColumnFilter(columnId: widget.columns.first.id));
    _values.add(TextEditingController());
  });

  @override
  Widget build(BuildContext context) => VModal(
    title: 'Filtres',
    description: 'Toutes les conditions doivent être remplies.',
    icon: LucideIcons.listFilter,
    width: 620,
    actions: [
      VButton.ghost(
        label: 'Tout effacer',
        onPressed: () => Navigator.of(context).pop(const <ColumnFilter>[]),
      ),
      const Spacer(),
      VButton(label: 'Annuler', onPressed: () => Navigator.of(context).pop()),
      VButton.primary(
        label: 'Appliquer',
        onPressed: () => Navigator.of(context).pop([
          for (final (i, f) in _filters.indexed)
            f.copyWith(value: _values[i].text),
        ]),
      ),
    ],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (i, filter) in _filters.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: VSpace.x2),
            child: Row(
              children: [
                SizedBox(
                  width: 34,
                  child: Text(i == 0 ? 'Où' : 'et', style: context.text.small),
                ),
                VSelect<String>(
                  width: 160,
                  value: filter.columnId,
                  options: [
                    for (final c in widget.columns)
                      VSelectOption(c.id, c.label),
                  ],
                  onChanged: (v) => setState(
                    () => _filters[i] = filter.copyWith(columnId: v),
                  ),
                ),
                const SizedBox(width: VSpace.x2),
                VSelect<FilterOperator>(
                  width: 150,
                  value: filter.operator,
                  options: [
                    for (final op in FilterOperator.values)
                      VSelectOption(op, op.label),
                  ],
                  onChanged: (v) => setState(
                    () => _filters[i] = filter.copyWith(operator: v),
                  ),
                ),
                const SizedBox(width: VSpace.x2),
                Expanded(
                  child: filter.operator.needsValue
                      ? VTextField(controller: _values[i], hint: 'Valeur')
                      : const SizedBox.shrink(),
                ),
                VIconButton(
                  icon: LucideIcons.x,
                  tooltip: 'Retirer',
                  onPressed: () => setState(() {
                    _filters.removeAt(i);
                    _values.removeAt(i).dispose();
                  }),
                ),
              ],
            ),
          ),
        if (_filters.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: VSpace.x3),
            child: Text('Aucun filtre.', style: context.text.small),
          ),
        VButton.ghost(
          label: 'Ajouter une condition',
          icon: LucideIcons.plus,
          size: VButtonSize.sm,
          onPressed: widget.columns.isEmpty ? null : _add,
        ),
      ],
    ),
  );
}
