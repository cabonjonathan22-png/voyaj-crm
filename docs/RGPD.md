# RGPD — Voyaj CRM

Voyaj CRM traite des données personnelles (contacts et élus des collectivités, partenaires,
utilisateurs). Ce document décrit ce que l'outil permet ; la conformité reste de la
responsabilité de l'entreprise (responsable de traitement). **À faire valider par votre
référent RGPD / DPO.**

## Registre des traitements (base)

| Traitement | Finalité | Base légale | Personnes | Données | Durée de conservation |
|---|---|---|---|---|---|
| Prospection et suivi commercial des collectivités | développement commercial B2B / B2G | intérêt légitime | contacts, élus, agents | identité, fonction, coordonnées professionnelles, échanges | 3 ans après le dernier contact (prospects), durée de la relation + 3 ans (clients) |
| Facturation | obligations comptables | obligation légale | clients | identité, coordonnées, factures, paiements | 10 ans (Code de commerce, art. L123-22) |
| Comptes utilisateurs et sécurité | sécurité du SI, traçabilité | intérêt légitime / obligation de sécurité | utilisateurs | identité, sessions, journal d'audit | durée du compte ; journal d'audit : durée de conservation à définir (1 an conseillé) |
| Données publiques importées | connaissance des collectivités | intérêt légitime (données publiées) | élus (données publiques) | nom, mandat | tant que publiées par la source |

## Fonctions de l'outil

- **Provenance** : chaque fiche importée garde sa source (`source`, `source_ref`) et sa date de
  collecte (`collected_at`).
- **Opposition** : champ « Ne pas contacter » (exclut des séquences d'emails).
- **Droit d'accès / portabilité** : fiche contact › bouton « Données personnelles » ›
  *Exporter ses données* (JSON : fiche, mandats, activités, emails, affaires, factures, tags).
- **Droit à l'effacement** : *Anonymiser* efface nom, coordonnées, notes, champs
  personnalisés, contenu des activités, emails et historique des modifications ; la fiche
  anonyme reste pour les statistiques. Suppression simple possible également.
- **Durées de conservation** : *Administration › RGPD et sauvegardes* liste les contacts sans
  contact depuis 12, 24 ou 36 mois, pour relance, anonymisation ou suppression.
- **Traçabilité** : exports et anonymisations sont inscrits au journal d'audit (inaltérable) ;
  il ne contient que des noms de champs, jamais de valeurs.
- **Sécurité** : base locale chiffrée (SQLCipher), secrets chiffrés au repos (AES-256-GCM),
  2FA, sessions révocables, TLS obligatoire hors poste local.

## Points d'attention

- Les emails des séquences doivent comporter une information et un moyen d'opposition
  (lien ou mention « répondez STOP ») : à intégrer dans vos modèles.
- Les sauvegardes contiennent des données personnelles : conservation limitée (14 jours par
  défaut), stockage chiffré hors site.
- Les données anonymisées restent dans les sauvegardes jusqu'à leur expiration.
