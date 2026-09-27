import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../design_system/design_system.dart';

const _groups = <(String, List<(String, String)>)>[
  (
    'Général',
    [
      ('Ctrl K', 'Palette de commandes et recherche globale'),
      ('Ctrl B', 'Afficher / masquer la barre latérale'),
      ('Ctrl Maj L', 'Basculer thème clair / sombre'),
      ('F5', 'Synchroniser maintenant'),
      ('F1', 'Afficher cette aide'),
    ],
  ),
  (
    'Navigation',
    [
      ('Ctrl 0', 'Tableau de bord'),
      ('Ctrl 1', 'Organisations'),
      ('Ctrl 2', 'Contacts'),
      ('Ctrl 3', 'Pipelines'),
      ('Ctrl 4', 'Tâches'),
      ('Ctrl 5', 'Carte'),
      ('Ctrl 6', 'Emails'),
      ('Ctrl 7', 'Facturation'),
      ('Ctrl ,', 'Paramètres'),
      ('Ctrl W', "Fermer l'onglet de la fiche"),
    ],
  ),
  (
    'Listes',
    [
      ('Ctrl N', 'Nouvel élément'),
      ('Ctrl F', 'Rechercher dans la liste'),
      ('↑ ↓', 'Se déplacer'),
      ('Entrée', "Ouvrir l'élément"),
      ('Espace', 'Sélectionner'),
      ('Maj ↑ ↓', 'Étendre la sélection'),
      ('Ctrl A', 'Tout sélectionner'),
      ('Suppr', 'Supprimer la sélection'),
      ('Ctrl E', 'Modifier la fiche ouverte'),
      ('Échap', 'Fermer / désélectionner'),
    ],
  ),
];

Future<void> showShortcutsHelp(BuildContext context) => showVModal<void>(
  context,
  builder: (context) => VModal(
    title: 'Raccourcis clavier',
    icon: LucideIcons.keyboard,
    width: 520,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (title, items) in _groups) ...[
          Text(title, style: context.text.label),
          const SizedBox(height: VSpace.x2),
          for (final (keys, label) in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(child: Text(label, style: context.text.body)),
                  Kbd(keys),
                ],
              ),
            ),
          const SizedBox(height: VSpace.x4),
        ],
      ],
    ),
  ),
);
