import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  test('calendrier iCalendar : échappement, UTC, repli des lignes', () {
    final ics = buildIcs(
      name: 'Voyaj — Camille',
      now: DateTime.utc(2026, 9, 27, 8),
      events: [
        IcsEvent(
          uid: 'a1@voyaj',
          start: DateTime.utc(2026, 10, 1, 9, 30),
          end: DateTime.utc(2026, 10, 1, 9, 30),
          summary: 'Rendez-vous; Mairie, Rodez',
          description: 'Ligne 1\nLigne 2 ${'é' * 60}',
        ),
      ],
    );
    final lines = ics.split('\r\n');
    expect(lines.first, 'BEGIN:VCALENDAR');
    expect(ics, contains('DTSTART:20261001T093000Z'));
    // Durée nulle : 30 minutes par défaut.
    expect(ics, contains('DTEND:20261001T100000Z'));
    expect(ics, contains(r'SUMMARY:Rendez-vous\; Mairie\, Rodez'));
    expect(ics, contains(r'DESCRIPTION:Ligne 1\nLigne 2'));
    for (final line in lines) {
      expect(line.codeUnits.length, lessThanOrEqualTo(75 * 2));
    }
    expect(lines.where((l) => l.startsWith(' ')), isNotEmpty);
    expect(ics, endsWith('END:VCALENDAR\r\n'));
  });
}
