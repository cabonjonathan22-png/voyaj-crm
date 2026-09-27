/// Retire les accents et met en minuscules (recherche tolérante).
String normalizeForSearch(String input) {
  const from = 'àâäáãåçéèêëíìîïñóòôöõúùûüýÿœæ';
  const to = 'aaaaaaceeeeiiiinooooouuuuyyoa';
  final buffer = StringBuffer();
  for (final char in input.toLowerCase().split('')) {
    final index = from.indexOf(char);
    buffer.write(index >= 0 ? to[index] : char);
  }
  return buffer.toString();
}

/// Score de correspondance approximative de [query] dans [text] (plus élevé
/// = meilleur ; `null` = aucune correspondance).
///
/// Les caractères de la requête doivent apparaître dans l'ordre. Bonus pour
/// les correspondances contiguës, en début de mot et en début de texte.
int? fuzzyScore(String query, String text) {
  final q = normalizeForSearch(query.trim());
  if (q.isEmpty) return 0;
  final t = normalizeForSearch(text);

  final direct = t.indexOf(q);
  if (direct >= 0) {
    return 1000 - direct * 10 - (t.length - q.length) + (direct == 0 ? 500 : 0);
  }

  var score = 0;
  var ti = 0;
  var previous = -2;
  for (final char in q.split('')) {
    if (char == ' ') continue;
    final found = t.indexOf(char, ti);
    if (found < 0) return null;
    final wordStart = found == 0 || ' -_/'.contains(t[found - 1]);
    score += found == previous + 1 ? 15 : 1;
    if (wordStart) score += 10;
    previous = found;
    ti = found + 1;
  }
  return score - t.length ~/ 4;
}
