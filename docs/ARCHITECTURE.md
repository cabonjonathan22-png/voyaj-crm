# Architecture — Voyaj CRM

## Vue d'ensemble

```mermaid
flowchart LR
  subgraph Poste["Poste utilisateur (Windows)"]
    UI["Client Flutter<br/>Riverpod · go_router"]
    DB[("SQLite chiffrée<br/>Drift + SQLite3MC")]
    OB["Outbox"]
    UI --> DB
    UI --> OB
  end
  subgraph Serveur["Serveur (PC Windows ou cloud)"]
    API["API REST /api/v1<br/>shelf"]
    WS["WebSocket /ws"]
    PG[("PostgreSQL")]
    API --> PG
  end
  OB -- "push (HTTPS)" --> API
  API -- "pull" --> DB
  WS -- "« changements disponibles »" --> UI
  Caddy["Caddy (HTTPS)"] -.cloud.-> API
```

## Packages

```mermaid
flowchart TB
  shared["packages/shared<br/>modèles freezed · HLC · fusion LWW<br/>protocole · permissions · validation"]
  client["apps/client"] --> shared
  server["apps/server"] --> shared
  client -. "tests uniquement" .-> server
```

| Package | Rôle |
|---|---|
| `voyaj_shared` | Seule source des modèles et règles partagées : `Tag`, DTO d'auth, protocole de synchro, `EntitySchema` (liste blanche des champs), `Hlc`, `mergeFields`, `Permission`/`SystemRole`, validation. |
| `voyaj_server` | CLI `voyaj_server` (`serve`, `migrate`, `create-admin`, `gen-key`, `audit-verify`), API REST, WebSocket, services (auth, utilisateurs, synchro, audit). |
| `fr_public_data` | Lecture des données publiques (geo.api.gouv.fr, transport.data.gouv.fr, data.culture.gouv.fr) et conversion en organisations : régions, départements, EPCI, communes, AOM, festivals. |
| `voyaj_client` | Application desktop : design system, shell, base locale, moteur de synchro, écrans. |

## Synchronisation

### Principes

- **Identifiants** UUID v7 générés côté client (création hors ligne sans collision).
- **Horloge logique hybride (HLC)** par poste, persistée : arbitre les conflits sans dépendre de
  l'exactitude des horloges des PC. Une horloge distante en avance de plus d'une minute est refusée.
- **Last-write-wins par champ** : chaque enregistrement porte `field_meta` = pour chaque champ, le
  HLC, la version et l'auteur de la dernière écriture.
- **Suppression logique** : `deleted_at` est un champ synchronisé comme les autres.
- **Journal des conflits** : quand deux écritures concurrentes (aucune n'avait vu l'autre) touchent
  le même champ avec des valeurs différentes, la plus récente gagne et le conflit est enregistré
  (`sync_conflicts`), consultable dans l'écran Synchronisation.

### Flux

```mermaid
sequenceDiagram
  participant A as Poste A
  participant S as Serveur
  participant B as Poste B
  A->>A: écriture locale + opération outbox (1 transaction)
  A->>S: POST /sync/push (op_id, base_version, hlc, champs)
  S->>S: verrou d'écriture, idempotence (sync_ops), fusion par champ,<br/>validation, seq = nextval, change_log, conflits, audit
  S-->>A: résultat + état serveur de l'enregistrement
  S-->>B: WebSocket { type: changes, cursor }
  B->>S: GET /sync/pull?cursor=N
  S-->>B: enregistrements modifiés (seq > N)
  B->>B: applique l'état serveur puis réapplique ses champs encore en attente
```

- Les écritures sont **sérialisées** par un verrou transactionnel : les numéros de séquence sont
  validés dans l'ordre, un client ne peut pas « sauter » un changement.
- Opérations refusées (`invalid`, `forbidden`) : retirées de l'outbox, inscrites dans
  `sync_errors` (visible dans l'écran Synchronisation), l'état serveur est rétabli localement.
- Reconnexion WebSocket avec délai croissant (1 s → 30 s) ; synchronisation de secours chaque minute.

## Schéma PostgreSQL (migration 0001)

| Table | Contenu |
|---|---|
| `users` | email (citext unique), nom, hash Argon2id, statut, secrets TOTP **chiffrés** (AES-256-GCM), dernier pas TOTP (anti-rejeu) |
| `user_recovery_codes` | codes de secours 2FA (hachés, usage unique) |
| `roles`, `role_permissions`, `user_roles` | RBAC `ressource.action` ; rôles système synchronisés avec le code au démarrage |
| `sessions` | poste, jetons d'accès / de rafraîchissement **hachés**, jeton précédent (détection de vol), expiration, révocation |
| `auth_challenges` | étape « code 2FA attendu » (5 min, 5 essais) |
| `audit_log` | journal en ajout seul, chaîné SHA-256 ; triggers refusant UPDATE/DELETE/TRUNCATE |
| `sync_ops` | opérations déjà traitées (idempotence) |
| `change_log` | historique de toutes les modifications (seq, champs, HLC, auteur, poste) |
| `sync_conflicts` | conflits (valeurs gagnante/perdante, HLC, auteurs, revue) |
| `tags` | entité synchronisée : `id, name, color, description` + `version, seq, field_meta, created_*, updated_*, deleted_at` |

## Schéma PostgreSQL (migration 0002 — CRM)

Toutes les tables ci-dessous sont des entités synchronisées (mêmes colonnes techniques que `tags`).
Pas de clé étrangère entre entités synchronisées : l'ordre d'arrivée des opérations hors ligne
n'est pas garanti, le client gère les références orphelines.

| Table | Contenu |
|---|---|
| `organisations` | nom, type (commune, EPCI, AOM, festival…), statut commercial, SIREN/SIRET/INSEE, population, organisation parente, département, région, adresse, coordonnées GPS, contact, champs personnalisés, provenance (`source`, `source_ref`, `collected_at`) |
| `contacts` | civilité, prénom, nom, email, téléphones, organisation, fonction, service, notes, « ne pas contacter », champs personnalisés, provenance |
| `positions` | postes et mandats (historique) : contact, organisation, fonction, mandat électif (maire, adjoint…), délégation, dates |
| `pipelines`, `pipeline_stages` | pipelines commerciaux et leurs étapes (ordre, probabilité, couleur, issue : en cours / gagnée / perdue) |
| `deals` | affaires : pipeline, étape, organisation, contact, montant (centimes), probabilité, clôture prévue, statut |
| `activities` | notes, appels, rendez-vous, tâches, emails : rattachements, dates, échéance, rappel, fait le |
| `attachments` | fichiers joints (métadonnées) rattachés à une fiche |
| `taggings` | tags appliqués (tag, entité, enregistrement) |
| `custom_fields` | définitions des champs personnalisés par entité (clé, libellé, type, choix) |
| `segments` | filtres enregistrés partagés (entité, critères JSON) |
| `files` | contenu des fichiers joints (non synchronisé) : empreinte SHA-256, taille, type |

## Schéma PostgreSQL (migration 0003 — données publiques)

| Table | Contenu |
|---|---|
| `public_data_sources` | configuration par source : import quotidien activé, périmètre (codes de départements) |
| `public_data_runs` | historique des imports : déclenchement (manuel / planifié), état, compteurs (lus, créés, mis à jour, inchangés, refusés), erreur |

Base locale Drift (client, schéma v2) : une table par entité synchronisée (mêmes colonnes,
`version` = dernière version serveur connue), `outbox`, `sync_errors`, `key_values` (préférences,
curseur, HLC, poste, vues de tableaux, onglets de travail).

## Sécurité

- **Mots de passe** : Argon2id (19 Mio, 2 itérations par défaut), 12 caractères minimum,
  rehachage automatique si les paramètres sont renforcés.
- **Jetons** opaques (256 bits), stockés hachés ; accès 15 min, rafraîchissement 30 jours avec
  **rotation** ; réutilisation d'un ancien jeton hors délai de grâce → session révoquée.
- **Sessions révocables** immédiatement (vérifiées à chaque requête ; WebSocket fermé).
- **2FA TOTP** (RFC 6238, fenêtre ±30 s, anti-rejeu) + 10 codes de secours.
- **Limitation** des tentatives de connexion (10 / 15 min par email+IP) et de 2FA (5 par étape).
- **TLS obligatoire** hors localhost (certificat direct ou reverse proxy HTTPS).
- **Secrets au repos** chiffrés par la clé maître `VOYAJ_MASTER_KEY` (jamais dans le code).
- **Client** : base locale chiffrée (SQLite3 Multiple Ciphers), clé et jetons dans le coffre de
  l'OS (DPAPI sous Windows) ; données locales effacées si un autre utilisateur se connecte.
- **Journal d'audit** inaltérable (`voyaj_server audit-verify`).

## API (v1)

| Méthode | Chemin | Rôle |
|---|---|---|
| GET | `/health` | état et version |
| POST | `/api/v1/auth/login`, `/auth/mfa`, `/auth/refresh`, `/auth/logout` | connexion |
| GET | `/api/v1/auth/me`, `/auth/sessions` | profil, sessions |
| DELETE | `/api/v1/auth/sessions/{id}` | révoquer une session |
| POST | `/api/v1/auth/password`, `/auth/totp/setup`, `/totp/confirm`, `/totp/disable`, `/totp/recovery-codes` | compte et 2FA |
| GET/POST/PATCH | `/api/v1/users`, `/users/{id}`, POST `/users/{id}/revoke-sessions` | utilisateurs |
| GET/POST/PUT/DELETE | `/api/v1/roles`, `/roles/{id}` | rôles |
| POST / GET | `/api/v1/sync/push`, `/sync/pull?cursor=` | synchronisation |
| POST / GET | `/api/v1/files`, `/files/{sha256}` | fichiers joints (25 Mo max, corps brut) |
| GET / PUT / POST | `/api/v1/public-data`, `/public-data/{source}`, `/public-data/{source}/run`, `/public-data/runs` | données publiques : état, configuration, lancement (202, en arrière-plan), historique |
| GET / POST | `/api/v1/sync/conflicts`, `/sync/conflicts/{id}/review` | conflits |
| GET | `/api/v1/audit?limit=&before=` | journal d'audit |
| WS | `/ws` | notifications temps réel (1er message : authentification) |

## Client : organisation du code

```
lib/app/            bootstrap, providers Riverpod, routeur, shell, palette de commandes
lib/core/           client API (renouvellement des jetons), coffre, formats
lib/data/           base Drift, moteur de synchro, horloge, pont local générique, RecordStore
lib/design_system/  tokens, thème, composants, tableau de données
lib/features/crm/   organisations, contacts, élus, pipelines, activités, carte, import, doublons
lib/features/       auth, tags, sync, settings, admin, dev (catalogue en debug)
lib/l10n/           fichiers ARB (fr)
```

## Client : CRM (Phase 2)

- **Écritures** : `RecordStore` valide l'enregistrement complet avec les règles partagées
  (`voyaj_shared`), écrit la table locale et l'opération d'outbox dans une transaction, puis
  déclenche la synchronisation. `RecordStore.write` regroupe plusieurs écritures (import, fusion).
- **Pont local générique** (`LocalEntity`) : les colonnes locales portent les noms des champs du
  schéma ; conversions par type (dates ISO UTC, dates calendaires `AAAA-MM-JJ` en texte, JSON en
  texte, booléens).
- **Lectures** : `StreamProvider` Riverpod sur les tables Drift (réactifs aux synchronisations).
- **Formulaires** déclaratifs (`FormFieldDef` → `RecordFormModal`), champs personnalisés ajoutés
  automatiquement, erreurs de validation affichées par champ.
- **Fiches** à onglets (aperçu, contacts / postes, affaires, activités, fichiers) ; chaque fiche
  ouverte devient un **onglet de travail** (barre au-dessus du contenu, Ctrl+W pour fermer,
  mémorisés par poste).
- **Recherche globale** (Ctrl+K) : index local (organisations, contacts, affaires, tags) en
  minuscules sans accents, tous les mots doivent correspondre.
- **Import CSV** : détection du séparateur et de l'encodage (UTF-8 / Windows-1252), correspondance
  automatique des colonnes, conversion des valeurs (types, statuts, régions, nombres), doublons
  ignorés, tags et organisations manquants créés, provenance RGPD sur chaque fiche.
- **Doublons** : clés de rapprochement (SIRET, SIREN ou INSEE par type, nom normalisé + lieu ;
  email, mobile, nom + organisation), regroupement transitif, fusion synchronisée.

## Données publiques (Phase 3)

```mermaid
flowchart LR
  G["geo.api.gouv.fr<br/>régions · départements · EPCI · communes"] --> P
  T["transport.data.gouv.fr<br/>AOM"] --> P
  C["data.culture.gouv.fr<br/>festivals"] --> P
  P["fr_public_data<br/>PublicRecord"] --> S["PublicDataService<br/>(file, planification)"]
  S --> U["SyncService.upsertFromSource<br/>rapprochement · parents · fusion"]
  U --> O[("organisations")]
  O -- "pull" --> Postes
```

- Ordre : régions → départements → EPCI → communes (les parents existent avant les enfants) →
  AOM → festivals.
- Rapprochement : `source` + `source_ref` (code INSEE, SIREN…), sinon fiche de même type avec le
  même code (`matchField`) si elle ne provient pas déjà d'une autre source publique.
- Mise à jour : seuls les champs modifiés dans la source et **non modifiés par un utilisateur**
  (`field_meta` : dernière écriture sans utilisateur) sont écrits ; `collected_at` est actualisé.
- Création : statut « À prospecter ». Les fiches supprimées ne sont pas recréées.
