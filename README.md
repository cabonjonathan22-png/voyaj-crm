# Voyaj CRM

CRM de prospection et de gestion pour **Voyaj** (covoiturage / mobilité partagée) :
collectivités (mairies, EPCI, départements, régions, AOM), festivals et partenaires.

- **Client** : application Flutter desktop (Windows d'abord ; macOS, Linux ensuite), fonctionne
  **hors ligne** et se synchronise avec le serveur.
- **Serveur** : Dart (shelf) + PostgreSQL, sur un PC Windows (service) ou dans le cloud (Docker).

> État : **Phases 1 à 4 terminées** : socle, CRM cœur (organisations, contacts, élus, pipelines
> Kanban, activités et tâches, fichiers joints, tags, champs personnalisés, segments, recherche
> globale, carte, import CSV, doublons) et **données publiques** (régions, départements, EPCI,
> communes, AOM, festivals, mise à jour chaque nuit) et **emails** (IMAP/SMTP, Gmail et
> Microsoft 365, modèles, séquences). Voir [docs/ROADMAP.md](docs/ROADMAP.md).

## Distribuer le client aux utilisateurs

Les utilisateurs reçoivent **un seul fichier** : `VoyajCRM-Setup-<version>.exe`.
Double-clic → « Installer » → l'application s'ouvre sur l'écran de connexion (adresse du serveur
déjà renseignée). Aucun droit administrateur, rien d'autre à installer.

Construire l'installeur (sur le poste de développement) :

```powershell
.\deploy\windows\build-client-installer.ps1 -ServerUrl "https://crm.votre-domaine.fr"
# → dist\VoyajCRM-Setup-0.1.0.exe
```

> L'installeur n'est pas encore signé : Windows SmartScreen affiche « Windows a protégé votre
> ordinateur » → « Informations complémentaires » → « Exécuter quand même ». Un certificat de
> signature de code supprime cet avertissement (voir la feuille de route).

Les comptes utilisateurs se créent dans le client : **Administration → Utilisateurs**.

## Installer le serveur

### Sur un PC Windows (service qui démarre avec Windows)

Prérequis : PostgreSQL 16+ et Dart/Flutter. Dans un PowerShell **administrateur** :

```powershell
.\deploy\windows\install-server.ps1 -DatabaseUrl "postgres://voyaj:motdepasse@localhost:5432/voyaj"
& "C:\Program Files\Voyaj Server\voyaj_server.exe" --env-file C:\ProgramData\Voyaj\config\.env `
    create-admin --email vous@exemple.fr --name "Votre nom"
```

La configuration (dont la **clé maître**, à sauvegarder) est dans `C:\ProgramData\Voyaj\config\.env`,
les journaux dans `C:\ProgramData\Voyaj\logs`, les fichiers joints dans `C:\ProgramData\Voyaj\data`
(à sauvegarder avec la base). Désinstallation : `uninstall-server.ps1`.

### Dans le cloud (serveur dédié / VPS, HTTPS automatique)

```bash
cd deploy/docker
cp .env.example .env        # domaine, mot de passe PostgreSQL, clé maître
docker compose up -d --build
docker compose run --rm server create-admin --email vous@exemple.fr --name "Votre nom"
```

Le même code tourne dans les deux cas ; seule la configuration change.

## Développement

Prérequis : Flutter 3.47+ (Dart 3.13+), Visual Studio 2022+ (charge C++), PostgreSQL, Melos
(`dart pub global activate melos 7.8.1`).

```powershell
flutter pub get                 # dépendances de tout le workspace
cp apps/server/.env.example apps/server/.env   # puis compléter (gen-key)
melos run server                # serveur sur http://localhost:8080
melos run client                # client Windows
melos run analyze               # analyse statique (zéro avertissement)
melos run test:dart --no-select # tests shared + serveur (intégration PostgreSQL)
melos run test:flutter          # tests client (écrans + synchro de bout en bout)
melos run gen                   # génération de code (freezed, json, drift)
```

Captures de tous les écrans : `VOYAJ_SCREENSHOTS=<dossier> flutter test test/screens_test.dart`
(dans `apps/client`).

## Documentation

- [CLAUDE.md](CLAUDE.md) — règles du projet, commandes, conventions.
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — packages, schéma de données, synchronisation, sécurité.
- [docs/ROADMAP.md](docs/ROADMAP.md) — phases, éléments reportés, décisions.

## Avertissement comptable

Le futur module de facturation et comptabilité (Phase 5 : Factur-X, FEC, TVA, numérotation,
archivage) **devra être validé par un expert-comptable** avant toute utilisation réelle.
