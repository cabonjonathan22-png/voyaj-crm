import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/features/crm/map/clusters.dart';

void main() {
  (double, double) point(double lat, double lng) => (lat, lng);

  List<MapCluster<(double, double)>> cluster(
    List<(double, double)> points,
    double zoom,
  ) => clusterPoints(
    points,
    zoom: zoom,
    latitude: (p) => p.$1,
    longitude: (p) => p.$2,
  );

  test('peu de points : aucun regroupement', () {
    final points = [point(44.35, 2.57), point(44.36, 2.58)];
    expect(cluster(points, 5), hasLength(2));
  });

  test('beaucoup de points : regroupés selon le zoom', () {
    // 400 communes autour de Rodez (≈ 0,4° de côté) et 1 à Paris.
    final points = [
      for (var i = 0; i < 400; i++)
        point(44.2 + (i % 20) * 0.02, 2.4 + (i ~/ 20) * 0.02),
      point(48.85, 2.35),
    ];
    final france = cluster(points, 5);
    expect(france.length, lessThan(10));
    expect(france.fold<int>(0, (n, c) => n + c.items.length), 401);
    final paris = france.firstWhere((c) => c.items.length == 1);
    expect(paris.latitude, 48.85);

    final region = cluster(points, 10);
    expect(region.length, greaterThan(france.length));
    expect(cluster(points, 13), hasLength(401));
  });
}
