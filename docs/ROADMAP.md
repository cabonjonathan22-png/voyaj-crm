# Feuille de route — Voyaj CRM

## Phases

| Phase | Contenu | État |
|---|---|---|
| 1 — Socle | Monorepo, serveur + PostgreSQL, auth (rôles, 2FA, sessions), design system, shell, Ctrl+K, base locale chiffrée, synchro hors ligne (tags), service Windows, Docker, **installeur client** | ✅ Terminée |
| 2 — CRM cœur | Organisations, contacts, élus, pipelines Kanban, activités, tâches, tags appliqués, champs personnalisés, segments, recherche globale, carte, import CSV, doublons, **fichiers joints**, **onglets de travail** | ✅ Terminée |
| 3 — Données publiques | `packages/fr_public_data`, import des collectivités (régions, départements, EPCI, communes), festivals, AOM, mises à jour planifiées | ✅ Terminée (à valider sur les API réelles, voir ci-dessous) |
| 4 — Emails | IMAP/SMTP, OAuth Gmail/Microsoft, boîte de réception, modèles, séquences | À venir |
| 5 — Facturation & compta | Devis/factures/avoirs, Factur-X, PA + Chorus Pro, FEC, TVA — **validation expert-comptable** | À venir |
| 6 — Connecteurs | Supabase, Firebase, MySQL, MongoDB, REST, webhooks, éditeur de mapping | À venir |
| 7 — Avancé | Tableaux de bord, BOAMP, agenda, signature, IA, API publique, sauvegardes, RGPD | À venir |

## Éléments reportés ou à compléter

### Déploiement et distribution
- **Hébergement** : serveur de test en ligne sur Google Cloud (Paris, `https://voyaj-crm.duckdns.org`, Docker + Caddy, sauvegarde quotidienne locale à la VM). Production prévue chez OVH : ajouter une copie des sauvegardes hors de la machine.
- **Signature de code** de l'installeur (certificat OV/EV) pour supprimer l'avertissement SmartScreen.
- **Mise à jour automatique** du client (vérification de version au démarrage + téléchargement).
- Service Windows : exécuter sous un compte dédié plutôt que LocalSystem. Sur le poste de
  développement, PostgreSQL (portable) démarre à l'ouverture de session : pour un serveur de
  production sous Windows, installer PostgreSQL en service (installeur EDB).
- Runner **macOS** à générer sur un Mac (`flutter create --platforms macos .` dans
  `apps/client` : l'outil Flutter sous Windows échoue sur les icônes macOS) ; build Linux non testé.

### Client
- Réordonner les colonnes par glisser-déposer (la configuration `columnOrder` est prête).
- Traduire les libellés internes du design system (barre d'outils des tableaux, palette, aide
  des raccourcis) via ARB ; ajouter `app_en.arb`.
- Rafraîchir les permissions en temps réel (aujourd'hui : au démarrage et à la reconnexion).
- Si le coffre de l'OS est réinitialisé, la base locale est recréée : les modifications non
  envoyées sont perdues (cas rare) ; prévoir un export de secours.

### CRM (après la Phase 2)
- **Responsable** (`owner_id`) : renseigné automatiquement avec l'utilisateur qui crée la fiche ;
  choix d'un autre responsable et filtre « mes fiches » à ajouter (liste des utilisateurs à
  mettre en cache localement : elle n'est aujourd'hui lisible qu'en ligne).
- **Import Excel** (`.xlsx`) : seul le CSV est pris en charge (Excel sait l'exporter).
- **Carte** : serveur de tuiles configurable (OpenStreetMap par défaut, usage modéré exigé par sa
  politique).
- **Doublons ignorés** : mémorisés par poste (clé locale) ; à partager si besoin.
- **Rappels** : notification dans l'application uniquement (pas de notification système Windows).
- Affaires : pas de liste tabulaire dédiée (Kanban, fiches et recherche globale).
- Tags : unicité des noms non imposée ; l'import réutilise les tags existants par nom normalisé.
- Fichiers joints : pas de purge des fichiers qui ne sont plus référencés ; pas de cache local
  (téléchargement à la demande, connexion requise).

### Données publiques (Phase 3)
- **À valider au premier import réel** : le développement s'est fait sans accès réseau à
  `geo.api.gouv.fr`, `transport.data.gouv.fr` et `data.culture.gouv.fr` (jeux d'essai écrits
  d'après la documentation des API). Les formats de geo.api.gouv.fr sont stables ; ceux des AOM
  (`/api/aoms/geojson`) et du Panorama des festivals (export JSON) sont lus avec des noms de
  champs tolérants : en cas d'échec, l'import s'arrête avec un message (« aucune donnée ») visible
  dans Administration → Données publiques. Adapter alors `packages/fr_public_data/lib/src/parsers.dart`.
- Contacts publics (maires, élus : Répertoire national des élus) : non importés — données
  personnelles, à décider avec le DPO (base légale, information des personnes).
- Contours géographiques (polygones des communes / EPCI) non importés.
- Un seul serveur exécute les imports (file en mémoire) ; plusieurs instances nécessiteraient un
  verrou en base.

### Serveur
- Limiteur de tentatives en mémoire : à déplacer en base (ou Redis) si plusieurs instances.
- Purge planifiée des sessions expirées, rétention de `change_log` et `sync_ops`.

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

## Décisions (Phase 2)

| Décision | Raison |
|---|---|
| Pont local **générique** piloté par `EntitySchema` (un seul `LocalEntity`, SQL construit à partir des noms du schéma) | 11 entités ajoutées sans code de synchronisation spécifique ; les tables Drift restent typées pour les lectures. |
| `RecordStore` : écriture locale + outbox dans une transaction, **seuls les champs modifiés** partent | Moins de conflits (fusion par champ côté serveur), validation par les règles partagées avant écriture. |
| Formulaires **déclaratifs** (`FormFieldDef`) | Même composant pour toutes les fiches, champs personnalisés ajoutés automatiquement. |
| Recherche, filtres, doublons et carte calculés **sur la base locale** | Fonctionne hors ligne, sans charge serveur ; volumes de la Phase 2 (milliers de fiches) compatibles. |
| Segments = critères d'une vue de tableau (recherche, filtres, tri) enregistrés comme entité synchronisée | Partagés avec l'équipe, réutilisent le moteur de filtres des tableaux. |
| Fusion de doublons : master complété, références (contacts, postes, affaires, activités, fichiers, tags, parent) reportées, doublons supprimés logiquement | Tout passe par la synchronisation et le journal d'audit ; aucune perte de lien. |
| Fichiers joints adressés par **SHA-256** sur disque (`VOYAJ_DATA_DIR`), métadonnées synchronisées (`attachments`) | Déduplication, contenu jamais modifié ; sauvegarde = base + dossier. |
| Pipelines par défaut (Collectivités, Festivals) créés à la demande depuis le client | Pas de données imposées par une migration ; étapes modifiables. |
| Carte **flutter_map** + OpenStreetMap | Libre, sans clé d'API. |
| Base locale v2 : curseur de synchro remis à zéro à la migration | Les postes existants reçoivent les données CRM déjà présentes sur le serveur. |

## Décisions (Phase 3)

| Décision | Raison |
|---|---|
| Imports exécutés **par le serveur** (à la demande ou chaque nuit, `VOYAJ_PUBLIC_DATA_HOUR`) | Une seule lecture des sources pour toute l'équipe, pas de dépendance réseau des postes, historique centralisé. |
| Écritures « système » par le moteur de synchronisation (`upsertFromSource`) | Les fiches importées se synchronisent comme les autres ; un journal d'audit **par import** (pas par fiche). |
| Fiches retrouvées par `source` + `source_ref`, sinon **rapprochées** d'une fiche saisie (code INSEE, SIREN, code département/région, même type) | Pas de doublon avec les communes déjà créées à la main ou par import CSV. |
| Un champ dont la dernière écriture vient d'un utilisateur n'est **jamais écrasé** ; une fiche supprimée n'est pas recréée | Les corrections de l'équipe priment sur la source. |
| Périmètre par **départements** (communes : 35 000 fiches sinon) | Volume adapté aux postes et à la carte. |
| Hiérarchie par `parent_id` : commune → EPCI → département → région | Réutilise le rattachement des organisations (fiche « Rattachement »). |
| Carte : regroupement des marqueurs par grille au-delà de 300 points | Lisible et fluide avec des milliers de communes, sans dépendance supplémentaire. |
