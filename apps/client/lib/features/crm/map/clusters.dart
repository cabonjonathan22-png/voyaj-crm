import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// Groupe de points proches (marqueur de regroupement sur la carte).
@immutable
final class MapCluster<T> {
  const MapCluster(this.items, this.latitude, this.longitude);

  final List<T> items;

  /// Barycentre des points.
  final double latitude;
  final double longitude;
}

/// Seuil au-delà duquel les points sont regroupés.
const clusterThreshold = 300;

/// Regroupe [items] par cellules de grille dont la taille dépend du
/// niveau de zoom (environ 60 pixels à l'écran). En dessous de
/// [clusterThreshold] points ou à fort zoom, chaque point est seul.
List<MapCluster<T>> clusterPoints<T>(
  List<T> items, {
  required double zoom,
  required double Function(T item) latitude,
  required double Function(T item) longitude,
}) {
  if (items.length <= clusterThreshold || zoom >= 13) {
    return [
      for (final item in items)
        MapCluster([item], latitude(item), longitude(item)),
    ];
  }
  // 256 px = 360° au zoom 0 ; une cellule ≈ 60 px.
  final cell = 360 / math.pow(2, zoom) * 60 / 256;
  final cells = <(int, int), List<T>>{};
  for (final item in items) {
    final key = (
      (latitude(item) / cell).floor(),
      (longitude(item) / cell).floor(),
    );
    cells.putIfAbsent(key, () => []).add(item);
  }
  return [
    for (final group in cells.values)
      MapCluster(
        group,
        group.map(latitude).reduce((a, b) => a + b) / group.length,
        group.map(longitude).reduce((a, b) => a + b) / group.length,
      ),
  ];
}
