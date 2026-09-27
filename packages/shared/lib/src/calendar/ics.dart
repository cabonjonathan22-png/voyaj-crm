import 'dart:convert';

import 'package:meta/meta.dart';

/// Événement d'agenda (iCalendar, RFC 5545).
@immutable
final class IcsEvent {
  const IcsEvent({
    required this.uid,
    required this.start,
    required this.end,
    required this.summary,
    this.description,
    this.location,
    this.updatedAt,
    this.completed = false,
  });

  final String uid;
  final DateTime start;
  final DateTime end;
  final String summary;
  final String? description;
  final String? location;
  final DateTime? updatedAt;

  /// Tâche terminée (affichée comme annulée par certains agendas : on
  /// l'indique dans le titre).
  final bool completed;
}

String _stamp(DateTime d) {
  final u = d.toUtc();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${u.year.toString().padLeft(4, '0')}${two(u.month)}${two(u.day)}'
      'T${two(u.hour)}${two(u.minute)}${two(u.second)}Z';
}

/// Échappe un texte (virgules, points-virgules, barres obliques inverses,
/// retours à la ligne).
String escapeIcsText(String text) => text
    .replaceAll(r'\', r'\\')
    .replaceAll(';', r'\;')
    .replaceAll(',', r'\,')
    .replaceAll(RegExp(r'\r\n|\r|\n'), r'\n');

/// Replie une ligne à 75 octets (continuation par une espace), sans couper
/// un caractère UTF-8.
String foldIcsLine(String line) {
  final out = StringBuffer();
  var width = 0;
  for (final rune in line.runes) {
    final char = String.fromCharCode(rune);
    final size = utf8.encode(char).length;
    if (width + size > 75) {
      out.write('\r\n ');
      width = 1;
    }
    out.write(char);
    width += size;
  }
  return out.toString();
}

/// Calendrier iCalendar complet (lignes CRLF).
String buildIcs({
  required String name,
  required List<IcsEvent> events,
  DateTime? now,
}) {
  final stamp = _stamp(now ?? DateTime.now());
  final lines = [
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//Voyaj//Voyaj CRM//FR',
    'CALSCALE:GREGORIAN',
    'METHOD:PUBLISH',
    'X-WR-CALNAME:${escapeIcsText(name)}',
    'X-PUBLISHED-TTL:PT15M',
    for (final e in events) ...[
      'BEGIN:VEVENT',
      'UID:${e.uid}',
      'DTSTAMP:$stamp',
      'DTSTART:${_stamp(e.start)}',
      'DTEND:${_stamp(e.end.isAfter(e.start) ? e.end : e.start.add(const Duration(minutes: 30)))}',
      'SUMMARY:${escapeIcsText(e.completed ? '✓ ${e.summary}' : e.summary)}',
      if (e.description != null && e.description!.trim().isNotEmpty)
        'DESCRIPTION:${escapeIcsText(e.description!.trim())}',
      if (e.location != null && e.location!.trim().isNotEmpty)
        'LOCATION:${escapeIcsText(e.location!.trim())}',
      if (e.updatedAt != null) 'LAST-MODIFIED:${_stamp(e.updatedAt!)}',
      'END:VEVENT',
    ],
    'END:VCALENDAR',
  ];
  return '${lines.map(foldIcsLine).join('\r\n')}\r\n';
}
