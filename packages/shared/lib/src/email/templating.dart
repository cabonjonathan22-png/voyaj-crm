/// Modèles d'emails : variables `{{contact.first_name}}`…
library;

/// Variables disponibles dans les modèles (clé → description).
const templateVariables = {
  'contact.civility': 'Civilité du contact',
  'contact.first_name': 'Prénom du contact',
  'contact.last_name': 'Nom du contact',
  'contact.job_title': 'Fonction du contact',
  'organisation.name': "Nom de l'organisation",
  'organisation.city': "Ville de l'organisation",
  'user.name': "Nom de l'expéditeur",
};

final _placeholder = RegExp(r'\{\{\s*([a-z_.]+)\s*\}\}');

/// Remplace les variables par leur valeur (vide si inconnue ou absente).
String renderTemplate(String template, Map<String, String?> values) => template
    .replaceAllMapped(_placeholder, (m) => values[m.group(1)!]?.trim() ?? '');

/// Variables utilisées par [template] et inconnues.
Set<String> unknownVariables(String template) => {
  for (final m in _placeholder.allMatches(template))
    if (!templateVariables.containsKey(m.group(1))) m.group(1)!,
};
