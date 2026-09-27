import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/features/agenda/agenda_page.dart';

void main() {
  test('grille du mois : commence le lundi', () {
    // 1er septembre 2026 : un mardi.
    expect(gridStart(DateTime(2026, 9)), DateTime(2026, 8, 31));
    // 1er juin 2026 : un lundi.
    expect(gridStart(DateTime(2026, 6)), DateTime(2026, 6));
  });
}
