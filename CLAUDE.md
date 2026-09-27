# CLAUDE.md — Voyaj CRM

Règles de travail pour ce dépôt. Langue du projet : **français** (UI, docs, messages de commit,
commentaires). Identifiants de code en anglais.

## Méthode

- Travail **phase par phase** (voir `docs/ROADMAP.md`). En fin de phase : le code compile,
  `melos run analyze` est propre, tous les tests passent, la doc est à jour, puis résumé.
- Commits atomiques et explicites (français, préfixe `feat:`/`fix:`/`chore:`/`docs:`).
- **Pas de code mort, pas de TODO dans le code** : tout élément non terminé va dans
  `docs/ROADMAP.md`.
- L'utilisateur préfère que les décisions techniques soient prises et documentées (ROADMAP,
  section « Décisions ») plutôt que de lui poser des questions.

## Structure

```
apps/client/        Flutter desktop (Riverpod, go_router, Drift chiffré)
apps/server/        Serveur Dart (shelf, PostgreSQL, WebSocket)
packages/shared/    Modèles freezed, protocole de synchro, HLC, fusion, permissions, validation
deploy/docker/      Dockerfile, docker-compose (serveur + Postgres + Caddy)
deploy/windows/     Service Windows (WinSW) et installeur client (Inno Setup)
docs/               ARCHITECTURE.md, ROADMAP.md
```

Packages prévus, créés dans leur phase : `packages/fr_public_data` (3), `packages/invoicing` (5),
`packages/connectors` (6).

## Commandes

| Action | Commande |
|---|---|
| Dépendances | `flutter pub get` (racine) |
| Analyse | `melos run analyze` |
| Tests Dart | `melos run test:dart --no-select` |
| Tests Flutter | `melos run test:flutter` |
| Génération de code | `melos run gen` (ou `dart run build_runner build` dans le package) |
| Serveur (dev) | `melos run server` (lit `apps/server/.env`) |
| Client (dev) | `melos run client` |
| Installeur client | `deploy/windows/build-client-installer.ps1 -ServerUrl <url>` |

Les tests d'intégration (serveur et client) utilisent `TEST_DATABASE_URL` (base **vidée** à chaque
exécution), lu dans l'environnement ou `apps/server/.env`.

## Environnement de développement (poste Windows actuel)

- PostgreSQL 18 portable : `%LOCALAPPDATA%\Voyaj\pgsql`, données `%LOCALAPPDATA%\Voyaj\pgdata`,
  démarré à l'ouverture de session (tâche planifiée « Voyaj PostgreSQL (dev) »).
  Bases `voyaj` et `voyaj_test`, rôle `voyaj` (mot de passe dans
  `%LOCALAPPDATA%\Voyaj\pg_voyaj_password.txt`).
- Inno Setup 6 : `%LOCALAPPDATA%\Programs\Inno Setup 6`.
- Melos **7.8.1** (la 8.x est incompatible avec drift_dev : conflit `cli_util`).

## Conventions et pièges

- `packages/shared` et `apps/client` ciblent le langage **Dart 3.12** (`sdk: ^3.12.0`) : freezed 3
  génère des paramètres `final` refusés en 3.13, et freezed 4 est incompatible avec `flutter_test`
  dans le même workspace. Le serveur cible 3.13 (paramètres nommés privés).
- JSON en `snake_case` partout (`build.yaml`), dates ISO 8601 UTC.
- Toute entité synchronisée : schéma dans `shared/lib/src/sync/entities.dart`, table serveur
  (migration) avec les colonnes de `SyncColumns` + `seq`, table Drift + `LocalEntity` côté client.
- Migrations serveur : jamais modifier une migration appliquée (checksum vérifié) ; en ajouter une.
- Le serveur construit son SQL uniquement à partir des noms déclarés dans `EntitySchema`
  (liste blanche) ; toujours des paramètres nommés (`@param`).
- UI : uniquement les composants et tokens de `apps/client/lib/design_system/` (pas de couleur
  brute). Textes de l'UI dans `lib/l10n/app_fr.arb` (`context.l10n`).
- PowerShell 5.1 : ne pas éditer de fichiers texte via `Get-Content`/`Set-Content` (encodage) ;
  les scripts `.ps1` accentués doivent être en UTF-8 **avec BOM**.
- Aucun secret dans le code : `.env` (non versionné) ou variables d'environnement.
