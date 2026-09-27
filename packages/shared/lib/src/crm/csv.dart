/// Lecture de fichiers CSV (exports Excel français : séparateur `;`,
/// guillemets, retours à la ligne dans les cellules).
library;

/// Tableau lu : en-têtes et lignes (toutes de la même longueur que les
/// en-têtes).
final class CsvTable {
  const CsvTable(this.headers, this.rows, this.delimiter);

  final List<String> headers;
  final List<List<String>> rows;
  final String delimiter;
}

/// Devine le séparateur à partir de la première ligne (`;`, `,` ou
/// tabulation).
String detectCsvDelimiter(String text) {
  final firstLine = text.split(RegExp(r'\r?\n')).first;
  var best = ';';
  var bestCount = 0;
  for (final candidate in const [';', ',', '\t']) {
    final count = candidate.allMatches(firstLine).length;
    if (count > bestCount) {
      best = candidate;
      bestCount = count;
    }
  }
  return best;
}

/// Découpe [text] en lignes de cellules (RFC 4180, séparateur au choix).
List<List<String>> parseCsvRows(String text, {String? delimiter}) {
  final sep = delimiter ?? detectCsvDelimiter(text);
  final input = text.startsWith('﻿') ? text.substring(1) : text;
  final rows = <List<String>>[];
  var row = <String>[];
  final cell = StringBuffer();
  var inQuotes = false;
  var i = 0;

  void endCell() {
    row.add(cell.toString());
    cell.clear();
  }

  void endRow() {
    endCell();
    if (!(row.length == 1 && row.single.isEmpty)) rows.add(row);
    row = <String>[];
  }

  while (i < input.length) {
    final char = input[i];
    if (inQuotes) {
      if (char == '"') {
        if (i + 1 < input.length && input[i + 1] == '"') {
          cell.write('"');
          i++;
        } else {
          inQuotes = false;
        }
      } else {
        cell.write(char);
      }
    } else if (char == '"' && cell.isEmpty) {
      inQuotes = true;
    } else if (char == sep) {
      endCell();
    } else if (char == '\r' || char == '\n') {
      if (char == '\r' && i + 1 < input.length && input[i + 1] == '\n') i++;
      endRow();
    } else {
      cell.write(char);
    }
    i++;
  }
  if (cell.isNotEmpty || row.isNotEmpty) endRow();
  return rows;
}

/// Lit un CSV avec ligne d'en-têtes. Les lignes trop courtes sont
/// complétées, les cellules en trop ignorées ; les cellules sont nettoyées
/// des espaces superflus.
CsvTable parseCsv(String text, {String? delimiter}) {
  final sep = delimiter ?? detectCsvDelimiter(text);
  final all = parseCsvRows(text, delimiter: sep);
  if (all.isEmpty) return CsvTable(const [], const [], sep);
  final headers = [for (final h in all.first) h.trim()];
  return CsvTable(headers, [
    for (final raw in all.skip(1))
      [
        for (var c = 0; c < headers.length; c++)
          c < raw.length ? raw[c].trim() : '',
      ],
  ], sep);
}
