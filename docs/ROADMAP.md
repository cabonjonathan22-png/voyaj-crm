# Feuille de route — Voyaj CRM

## Phases

| Phase | Contenu | État |
|---|---|---|
| 1 — Socle | Monorepo, serveur + PostgreSQL, auth (rôles, 2FA, sessions), design system, shell, Ctrl+K, base locale chiffrée, synchro hors ligne (tags), service Windows, Docker, **installeur client** | ✅ Terminée |
| 2 — CRM cœur | Organisations, contacts, élus, pipelines Kanban, activités, tâches, tags appliqués, champs personnalisés, segments, recherche globale, carte, import CSV, doublons | À venir |
| 3 — Données publiques | `packages/fr_public_data`, import des collectivités, festivals, AOM, mises à jour planifiées | À venir |
| 4 — Emails | IMAP/SMTP, OAuth Gmail/Microsoft, boîte de réception, modèles, séquences | À venir |
| 5 — Facturation & compta | Devis/factures/avoirs, Factur-X, PA + Chorus Pro, FEC, TVA — **validation expert-comptable** | À venir |
| 6 — Connecteurs | Supabase, Firebase, MySQL, MongoDB, REST, webhooks, éditeur de mapping | À venir |
| 7 — Avancé | Tableaux de bord, BOAMP, agenda, signature, IA, API publique, sauvegardes, RGPD | À venir |

## Éléments reportés ou à compléter

### Déploiement et distribution
- **Hébergement du serveur accessible aux utilisateurs** : pour que des personnes hors de ce PC
  utilisent le client, le serveur doit être joignable (VPS + nom de domaine avec
  `deploy/docker`, recommandé). Le déploiement Docker n'a pas pu être testé sur le poste de
  développement (Docker absent).
- **Signature de code** de l'installeur (certificat OV/EV) pour supprimer l'avertissement SmartScreen.
- **Mise à jour automatique** du client (vérification de version au démarrage + téléchargement).
- Service Windows : exécuter sous un compte dédié plutôt que LocalSystem. Sur le poste de
  développement, PostgreSQL (portable) démarre à l'ouverture de session : pour un serveur de
  production sous Windows, installer PostgreSQL en service (installeur EDB).
- Runner **macOS** à générer sur un Mac (`flutter create --platforms macos .` dans
  `apps/client` : l'outil Flutter sous Windows échoue sur les icônes macOS) ; build Linux non testé.

### Client
- **Onglets** de travail (plusieurs fiches ouvertes) : à construire en Phase 2 avec les fiches
  organisations/contacts (les panneaux redimensionnables existent déjà).
- Réordonner les colonnes par glisser-déposer (la configuration `columnOrder` est prête).
- Traduire les libellés internes du design system (barre d'outils des tableaux, palette, aide
  des raccourcis) via ARB ; ajouter `app_en.arb`.
- Rafraîchir les permissions en temps réel (aujourd'hui : au démarrage et à la reconnexion).
- Si le coffre de l'OS est réinitialisé, la base locale est recréée : les modifications non
  envoyées sont perdues (cas rare) ; prévoir un export de secours.

### Serveur
- Limiteur de tentatives en mémoire : à déplacer en base (ou Redis) si plusieurs instances.
- Purge planifiée des sessions expirées, rétention de `change_log` et `sync_ops`.
- Unicité des noms de tags non imposée (détection des doublons prévue en Phase 2).

## Décisions (Phase 1)

| Décision | Raison |
|---|---|
| **shelf** plutôt que Serverpod | Un seul jeu de modèles (freezed, dans `shared`) et un moteur de synchro générique par champ, que l'ORM de Serverpod n'aurait pas simplifié. |
| **HLC** plutôt que l'horloge murale pour le LWW | Robuste aux horloges de PC décalées. |
| Jetons **opaques** hachés plutôt que JWT | Révocation immédiate, rien à signer, rien à divulguer. |
| **SQLite3 Multiple Ciphers** pour la base locale | Données personnelles sur des portables (RGPD). |
| Premier administrateur via la **CLI** (`create-admin`) | Pas d'écran d'initialisation exposé sur le réseau. |
| Mono-structure (pas de multi-tenant) | Un seul organisme : Voyaj. |
| **WinSW** pour le service Windows, **Inno Setup** pour l'installeur client | Outils libres, éprouvés, sans droits admin pour le client. |
| Runtime Visual C++ embarqué dans l'installeur | Les PC neufs ne l'ont pas toujours. |
| Mise à jour de Flutter 3.44 → 3.47 (Dart 3.13) | Bug du compilateur incrémental de Dart 3.12.2 empêchant `build_runner`, `dart test` et Melos. |
