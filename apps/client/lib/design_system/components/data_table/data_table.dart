import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../theme/app_theme.dart';
import '../../tokens/dimensions.dart';
import '../context_menu.dart';
import 'table_view_config.dart';

/// Définition d'une colonne.
@immutable
final class VColumn<T> {
  const VColumn({
    required this.id,
    required this.label,
    required this.cell,
    this.width = 160,
    this.minWidth = 64,
    this.flex = false,
    this.sortValue,
    this.filterValue,
    this.alignEnd = false,
    this.hideable = true,
  });

  final String id;
  final String label;
  final Widget Function(BuildContext context, T row) cell;

  /// Largeur par défaut.
  final double width;
  final double minWidth;

  /// La colonne absorbe l'espace restant.
  final bool flex;

  /// Valeur de tri (colonne triable si non nulle).
  final Comparable<Object>? Function(T row)? sortValue;

  /// Texte utilisé par la recherche et les filtres (colonne filtrable si
  /// non nul).
  final String? Function(T row)? filterValue;
  final bool alignEnd;
  final bool hideable;
}

/// Applique recherche, filtres (ET) et tri à [rows].
List<T> applyTableView<T>(
  List<T> rows,
  List<VColumn<T>> columns,
  TableViewConfig view,
) {
  final byId = {for (final c in columns) c.id: c};
  final search = view.search.trim().toLowerCase();
  final filters = [
    for (final f in view.filters)
      if (f.isActive && byId[f.columnId]?.filterValue != null) f,
  ];
  final searchable = [
    for (final c in columns)
      if (c.filterValue != null) c.filterValue!,
  ];

  final result = rows.where((row) {
    if (search.isNotEmpty &&
        !searchable.any(
          (value) => (value(row) ?? '').toLowerCase().contains(search),
        )) {
      return false;
    }
    return filters.every(
      (f) => f.operator.test(byId[f.columnId]!.filterValue!(row), f.value),
    );
  }).toList();

  final sortColumn = byId[view.sortColumn];
  if (sortColumn?.sortValue != null) {
    final key = sortColumn!.sortValue!;
    result.sort((a, b) {
      final va = key(a);
      final vb = key(b);
      final int cmp;
      if (va == null && vb == null) {
        cmp = 0;
      } else if (va == null) {
        cmp = 1;
      } else if (vb == null) {
        cmp = -1;
      } else {
        cmp = va.compareTo(vb);
      }
      return view.sortAscending ? cmp : -cmp;
    });
  }
  return result;
}

/// Colonnes visibles dans l'ordre de la vue.
List<VColumn<T>> orderedVisibleColumns<T>(
  List<VColumn<T>> columns,
  TableViewConfig view,
) {
  final ordered = [...columns]
    ..sort((a, b) {
      final ia = view.columnOrder.indexOf(a.id);
      final ib = view.columnOrder.indexOf(b.id);
      if (ia < 0 && ib < 0) return columns.indexOf(a) - columns.indexOf(b);
      if (ia < 0) return 1;
      if (ib < 0) return -1;
      return ia - ib;
    });
  return [
    for (final c in ordered)
      if (!view.hiddenColumns.contains(c.id)) c,
  ];
}

/// Tableau de données virtualisé.
///
/// Seules les lignes visibles sont construites (milliers de lignes sans
/// ralentissement). Clavier : ↑/↓ déplacent la ligne active, Entrée l'ouvre,
/// Espace la sélectionne, Ctrl+A sélectionne tout, Échap vide la sélection.
class VDataTable<T> extends StatefulWidget {
  const VDataTable({
    super.key,
    required this.rows,
    required this.columns,
    required this.rowId,
    required this.view,
    required this.onViewChanged,
    this.selection = const {},
    this.onSelectionChanged,
    this.activeRowId,
    this.onRowActivated,
    this.rowMenu,
    this.empty,
  });

  /// Lignes déjà filtrées et triées ([applyTableView]).
  final List<T> rows;
  final List<VColumn<T>> columns;
  final String Function(T row) rowId;
  final TableViewConfig view;
  final ValueChanged<TableViewConfig> onViewChanged;
  final Set<String> selection;
  final ValueChanged<Set<String>>? onSelectionChanged;
  final String? activeRowId;
  final ValueChanged<T>? onRowActivated;
  final List<VMenuItem> Function(T row)? rowMenu;
  final Widget? empty;

  @override
  State<VDataTable<T>> createState() => _VDataTableState<T>();
}

class _VDataTableState<T> extends State<VDataTable<T>> {
  static const _checkboxWidth = 40.0;

  final _focus = FocusNode(debugLabel: 'VDataTable');
  final _vertical = ScrollController();
  final _horizontal = ScrollController();
  int? _cursor;
  int? _anchor;
  int? _hovered;

  bool get _selectable => widget.onSelectionChanged != null;

  @override
  void dispose() {
    _focus.dispose();
    _vertical.dispose();
    _horizontal.dispose();
    super.dispose();
  }

  double _widthOf(VColumn<T> c) => widget.view.columnWidths[c.id] ?? c.width;

  void _select(int index, {required bool toggle, required bool range}) {
    if (!_selectable) return;
    final id = widget.rowId(widget.rows[index]);
    final next = Set<String>.of(widget.selection);
    if (range && _anchor != null) {
      final from = math.min(_anchor!, index);
      final to = math.max(_anchor!, index);
      for (var i = from; i <= to; i++) {
        next.add(widget.rowId(widget.rows[i]));
      }
    } else if (toggle) {
      next.contains(id) ? next.remove(id) : next.add(id);
      _anchor = index;
    } else {
      next
        ..clear()
        ..add(id);
      _anchor = index;
    }
    widget.onSelectionChanged!(next);
  }

  void _moveCursor(int delta, {required bool extend}) {
    if (widget.rows.isEmpty) return;
    final current =
        _cursor ??
        widget.rows.indexWhere((r) => widget.rowId(r) == widget.activeRowId);
    final next = (current < 0 ? 0 : current + delta).clamp(
      0,
      widget.rows.length - 1,
    );
    setState(() => _cursor = next);
    if (extend) _select(next, toggle: false, range: true);
    _ensureVisible(next);
  }

  void _ensureVisible(int index) {
    if (!_vertical.hasClients) return;
    final top = index * VSize.tableRow;
    final bottom = top + VSize.tableRow;
    final view = _vertical.position.viewportDimension;
    if (top < _vertical.offset) {
      _vertical.jumpTo(top);
    } else if (bottom > _vertical.offset + view) {
      _vertical.jumpTo(bottom - view);
    }
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final keys = HardwareKeyboard.instance;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        _moveCursor(1, extend: keys.isShiftPressed);
      case LogicalKeyboardKey.arrowUp:
        _moveCursor(-1, extend: keys.isShiftPressed);
      case LogicalKeyboardKey.pageDown:
        _moveCursor(10, extend: keys.isShiftPressed);
      case LogicalKeyboardKey.pageUp:
        _moveCursor(-10, extend: keys.isShiftPressed);
      case LogicalKeyboardKey.home:
        _moveCursor(-widget.rows.length, extend: false);
      case LogicalKeyboardKey.end:
        _moveCursor(widget.rows.length, extend: false);
      case LogicalKeyboardKey.enter || LogicalKeyboardKey.numpadEnter:
        if (_cursor != null && _cursor! < widget.rows.length) {
          widget.onRowActivated?.call(widget.rows[_cursor!]);
        }
      case LogicalKeyboardKey.space:
        if (_cursor != null && _cursor! < widget.rows.length) {
          _select(_cursor!, toggle: true, range: false);
        }
      case LogicalKeyboardKey.keyA when keys.isControlPressed:
        if (_selectable) {
          widget.onSelectionChanged!({
            for (final r in widget.rows) widget.rowId(r),
          });
        }
      case LogicalKeyboardKey.escape when widget.selection.isNotEmpty:
        widget.onSelectionChanged?.call({});
      default:
        return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final columns = orderedVisibleColumns(widget.columns, widget.view);

    return Focus(
      focusNode: _focus,
      onKeyEvent: _onKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fixed =
              (_selectable ? _checkboxWidth : 0) +
              columns.fold<double>(0, (sum, col) => sum + _widthOf(col));
          final extra = math.max(0.0, constraints.maxWidth - fixed);
          final flexCount = columns.where((col) => col.flex).length;
          double widthFor(VColumn<T> col) =>
              _widthOf(col) +
              (col.flex && flexCount > 0 ? extra / flexCount : 0);
          final totalWidth = math.max(constraints.maxWidth, fixed);

          final table = SizedBox(
            width: totalWidth,
            child: Column(
              children: [
                _Header<T>(
                  columns: columns,
                  widthFor: widthFor,
                  view: widget.view,
                  onViewChanged: widget.onViewChanged,
                  checkbox: _selectable
                      ? _HeaderCheckbox(
                          total: widget.rows.length,
                          selected: widget.rows
                              .where(
                                (r) =>
                                    widget.selection.contains(widget.rowId(r)),
                              )
                              .length,
                          onChanged: (all) => widget.onSelectionChanged!(
                            all
                                ? {for (final r in widget.rows) widget.rowId(r)}
                                : {},
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: widget.rows.isEmpty
                      ? (widget.empty ?? const SizedBox.shrink())
                      : Scrollbar(
                          controller: _vertical,
                          child: ListView.builder(
                            controller: _vertical,
                            itemExtent: VSize.tableRow,
                            itemCount: widget.rows.length,
                            itemBuilder: (context, index) =>
                                _buildRow(context, index, columns, widthFor),
                          ),
                        ),
                ),
              ],
            ),
          );

          return ColoredBox(
            color: c.background,
            child: fixed > constraints.maxWidth
                ? Scrollbar(
                    controller: _horizontal,
                    child: SingleChildScrollView(
                      controller: _horizontal,
                      scrollDirection: Axis.horizontal,
                      child: table,
                    ),
                  )
                : table,
          );
        },
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    int index,
    List<VColumn<T>> columns,
    double Function(VColumn<T>) widthFor,
  ) {
    final c = context.colors;
    final row = widget.rows[index];
    final id = widget.rowId(row);
    final selected = widget.selection.contains(id);
    final active = id == widget.activeRowId;
    final cursor = _cursor == index && _focus.hasFocus;

    final content = MouseRegion(
      onEnter: (_) => setState(() => _hovered = index),
      onExit: (_) => setState(() {
        if (_hovered == index) _hovered = null;
      }),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _focus.requestFocus();
          setState(() => _cursor = index);
          final keys = HardwareKeyboard.instance;
          if (keys.isShiftPressed || keys.isControlPressed) {
            _select(
              index,
              toggle: keys.isControlPressed,
              range: keys.isShiftPressed,
            );
          } else {
            _anchor = index;
            widget.onRowActivated?.call(row);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: selected || active
                ? c.surfaceSelected
                : _hovered == index
                ? c.surfaceHover
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(color: c.borderSubtle),
              left: BorderSide(
                color: active ? c.accent : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          foregroundDecoration: cursor
              ? BoxDecoration(border: Border.all(color: c.focusRing))
              : null,
          child: Row(
            children: [
              if (_selectable)
                SizedBox(
                  width: _checkboxWidth - 2,
                  child: Checkbox(
                    value: selected,
                    onChanged: (_) =>
                        _select(index, toggle: true, range: false),
                  ),
                ),
              for (final col in columns)
                SizedBox(
                  width: widthFor(col),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: VSpace.x3),
                    child: Align(
                      alignment: col.alignEnd
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: DefaultTextStyle.merge(
                        style: context.text.body,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        child: col.cell(context, row),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    if (widget.rowMenu == null) return content;
    return VContextMenuRegion(
      onOpen: () => setState(() => _cursor = index),
      items: () => widget.rowMenu!(row),
      child: content,
    );
  }
}

class _Header<T> extends StatelessWidget {
  const _Header({
    required this.columns,
    required this.widthFor,
    required this.view,
    required this.onViewChanged,
    required this.checkbox,
  });

  final List<VColumn<T>> columns;
  final double Function(VColumn<T>) widthFor;
  final TableViewConfig view;
  final ValueChanged<TableViewConfig> onViewChanged;
  final Widget? checkbox;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      height: VSize.tableHeader,
      decoration: BoxDecoration(
        color: c.backgroundSubtle,
        border: Border(bottom: BorderSide(color: c.border)),
      ),
      child: Row(
        children: [
          if (checkbox != null) SizedBox(width: 38, child: checkbox),
          for (final col in columns)
            _HeaderCell<T>(
              column: col,
              width: widthFor(col),
              sorted: view.sortColumn == col.id,
              ascending: view.sortAscending,
              onSort: col.sortValue == null
                  ? null
                  : () => onViewChanged(view.toggleSort(col.id)),
              onResize: (width) => onViewChanged(
                view.copyWith(
                  columnWidths: {...view.columnWidths, col.id: width},
                ),
              ),
              baseWidth: view.columnWidths[col.id] ?? col.width,
            ),
        ],
      ),
    );
  }
}

class _HeaderCell<T> extends StatefulWidget {
  const _HeaderCell({
    required this.column,
    required this.width,
    required this.baseWidth,
    required this.sorted,
    required this.ascending,
    required this.onSort,
    required this.onResize,
  });

  final VColumn<T> column;
  final double width;
  final double baseWidth;
  final bool sorted;
  final bool ascending;
  final VoidCallback? onSort;
  final ValueChanged<double> onResize;

  @override
  State<_HeaderCell<T>> createState() => _HeaderCellState<T>();
}

class _HeaderCellState<T> extends State<_HeaderCell<T>> {
  bool _hovered = false;
  double? _dragWidth;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final col = widget.column;
    return SizedBox(
      width: widget.width,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: widget.onSort,
                child: MouseRegion(
                  cursor: widget.onSort == null
                      ? SystemMouseCursors.basic
                      : SystemMouseCursors.click,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: VSpace.x3),
                    child: Row(
                      mainAxisAlignment: col.alignEnd
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            col.label,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.label.copyWith(
                              color: widget.sorted ? c.text : c.textMuted,
                            ),
                          ),
                        ),
                        if (widget.sorted ||
                            (_hovered && widget.onSort != null))
                          Padding(
                            padding: const EdgeInsets.only(left: VSpace.x1),
                            child: Icon(
                              widget.sorted && !widget.ascending
                                  ? LucideIcons.arrowDown
                                  : LucideIcons.arrowUp,
                              size: 12,
                              color: widget.sorted ? c.text : c.textSubtle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 6,
              bottom: 6,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (_) => _dragWidth = widget.baseWidth,
                  onHorizontalDragUpdate: (d) {
                    _dragWidth = math.max(
                      col.minWidth,
                      (_dragWidth ?? widget.baseWidth) + d.delta.dx,
                    );
                    widget.onResize(_dragWidth!);
                  },
                  child: SizedBox(
                    width: 7,
                    child: Center(
                      child: Container(
                        width: 1,
                        color: _hovered ? c.borderStrong : Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCheckbox extends StatelessWidget {
  const _HeaderCheckbox({
    required this.total,
    required this.selected,
    required this.onChanged,
  });

  final int total;
  final int selected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Checkbox(
    tristate: true,
    value: selected == 0
        ? false
        : selected == total
        ? true
        : null,
    onChanged: total == 0 ? null : (_) => onChanged(selected < total),
  );
}
