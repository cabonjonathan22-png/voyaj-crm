import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/// Opérateurs de filtre.
enum FilterOperator {
  contains('contient'),
  notContains('ne contient pas'),
  equals('est'),
  notEquals("n'est pas"),
  isEmpty('est vide'),
  isNotEmpty("n'est pas vide");

  const FilterOperator(this.label);

  final String label;

  bool get needsValue => this != isEmpty && this != isNotEmpty;

  bool test(String? cell, String value) {
    final text = (cell ?? '').toLowerCase().trim();
    final needle = value.toLowerCase().trim();
    return switch (this) {
      contains => text.contains(needle),
      notContains => !text.contains(needle),
      equals => text == needle,
      notEquals => text != needle,
      isEmpty => text.isEmpty,
      isNotEmpty => text.isNotEmpty,
    };
  }
}

/// Condition de filtre sur une colonne.
@immutable
final class ColumnFilter {
  const ColumnFilter({
    required this.columnId,
    this.operator = FilterOperator.contains,
    this.value = '',
  });

  factory ColumnFilter.fromJson(Map<String, dynamic> json) => ColumnFilter(
    columnId: json['column'] as String,
    operator: FilterOperator.values.byName(json['op'] as String),
    value: json['value'] as String? ?? '',
  );

  final String columnId;
  final FilterOperator operator;
  final String value;

  /// Un filtre sans valeur (en cours de saisie) ne filtre rien.
  bool get isActive => !operator.needsValue || value.trim().isNotEmpty;

  ColumnFilter copyWith({
    String? columnId,
    FilterOperator? operator,
    String? value,
  }) => ColumnFilter(
    columnId: columnId ?? this.columnId,
    operator: operator ?? this.operator,
    value: value ?? this.value,
  );

  Map<String, dynamic> toJson() => {
    'column': columnId,
    'op': operator.name,
    'value': value,
  };

  @override
  bool operator ==(Object other) =>
      other is ColumnFilter &&
      other.columnId == columnId &&
      other.operator == operator &&
      other.value == value;

  @override
  int get hashCode => Object.hash(columnId, operator, value);
}

/// Configuration d'affichage d'un tableau : tri, filtres (combinés en ET),
/// recherche, colonnes masquées, ordre et largeurs. Sérialisable pour les
/// vues enregistrées.
@immutable
final class TableViewConfig {
  const TableViewConfig({
    this.sortColumn,
    this.sortAscending = true,
    this.search = '',
    this.filters = const [],
    this.hiddenColumns = const {},
    this.columnOrder = const [],
    this.columnWidths = const {},
  });

  factory TableViewConfig.fromJson(
    Map<String, dynamic> json,
  ) => TableViewConfig(
    sortColumn: json['sort'] as String?,
    sortAscending: json['asc'] as bool? ?? true,
    search: json['search'] as String? ?? '',
    filters: [
      for (final f in json['filters'] as List<dynamic>? ?? const [])
        ColumnFilter.fromJson(f as Map<String, dynamic>),
    ],
    hiddenColumns: {
      for (final c in json['hidden'] as List<dynamic>? ?? const []) c as String,
    },
    columnOrder: [
      for (final c in json['order'] as List<dynamic>? ?? const []) c as String,
    ],
    columnWidths: {
      for (final MapEntry(:key, :value)
          in (json['widths'] as Map<String, dynamic>? ?? const {}).entries)
        key: (value as num).toDouble(),
    },
  );

  final String? sortColumn;
  final bool sortAscending;
  final String search;
  final List<ColumnFilter> filters;
  final Set<String> hiddenColumns;
  final List<String> columnOrder;
  final Map<String, double> columnWidths;

  int get activeFilterCount => filters.where((f) => f.isActive).length;

  TableViewConfig copyWith({
    String? Function()? sortColumn,
    bool? sortAscending,
    String? search,
    List<ColumnFilter>? filters,
    Set<String>? hiddenColumns,
    List<String>? columnOrder,
    Map<String, double>? columnWidths,
  }) => TableViewConfig(
    sortColumn: sortColumn != null ? sortColumn() : this.sortColumn,
    sortAscending: sortAscending ?? this.sortAscending,
    search: search ?? this.search,
    filters: filters ?? this.filters,
    hiddenColumns: hiddenColumns ?? this.hiddenColumns,
    columnOrder: columnOrder ?? this.columnOrder,
    columnWidths: columnWidths ?? this.columnWidths,
  );

  /// Tri cyclique : croissant → décroissant → aucun.
  TableViewConfig toggleSort(String columnId) {
    if (sortColumn != columnId) {
      return copyWith(sortColumn: () => columnId, sortAscending: true);
    }
    if (sortAscending) return copyWith(sortAscending: false);
    return copyWith(sortColumn: () => null, sortAscending: true);
  }

  Map<String, dynamic> toJson() => {
    'sort': sortColumn,
    'asc': sortAscending,
    'search': search,
    'filters': [for (final f in filters) f.toJson()],
    'hidden': hiddenColumns.toList()..sort(),
    'order': columnOrder,
    'widths': columnWidths,
  };

  static const _eq = DeepCollectionEquality();

  @override
  bool operator ==(Object other) =>
      other is TableViewConfig && _eq.equals(toJson(), other.toJson());

  @override
  int get hashCode => _eq.hash(toJson());
}

/// Vue enregistrée (nommée) d'un tableau.
@immutable
final class SavedTableView {
  const SavedTableView({required this.name, required this.config});

  factory SavedTableView.fromJson(Map<String, dynamic> json) => SavedTableView(
    name: json['name'] as String,
    config: TableViewConfig.fromJson(json['config'] as Map<String, dynamic>),
  );

  final String name;
  final TableViewConfig config;

  Map<String, dynamic> toJson() => {'name': name, 'config': config.toJson()};
}
