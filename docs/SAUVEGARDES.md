# Sauvegardes — Voyaj CRM

## Ce qui est sauvegardé

- **Base PostgreSQL** : `pg_dump --format=custom` → `voyaj-AAAAMMJJ-HHMMSS.dump` ;
- **Fichiers joints** : copie incrémentale de `VOYAJ_DATA_DIR/files` dans `files/` (un fichier
  n'est copié qu'une fois : son nom est son empreinte SHA-256) ;
- un manifeste `voyaj-….json` (date, taille, version du schéma).

La clé maître (`VOYAJ_MASTER_KEY`) n'est **pas** dans la sauvegarde : conservez-la à part
(coffre de mots de passe). Sans elle, les secrets chiffrés (comptes email, Chorus Pro,
connecteurs, 2FA) sont illisibles.

## Configuration

| Variable | Défaut | Rôle |
|---|---|---|
| `VOYAJ_BACKUP_DIR` | `<VOYAJ_DATA_DIR>/backups` | dossier des sauvegardes (idéalement un autre disque) |
| `VOYAJ_BACKUP_HOUR` | `2` | heure de la sauvegarde quotidienne, `off` pour désactiver |
| `VOYAJ_BACKUP_KEEP_DAYS` | `14` | durée de conservation des dumps |
| `VOYAJ_PG_DUMP` | `pg_dump` | chemin de `pg_dump` (même version majeure que le serveur) |

Sauvegarde immédiate : *Administration › RGPD et sauvegardes › Sauvegarder maintenant*, ou en
ligne de commande `voyaj_server backup`.

**Recopiez le dossier hors du serveur** chaque jour (autre site, stockage chiffré : rclone,
Backblaze, NAS…).

## Restauration

1. Arrêter le service Voyaj.
2. Restaurer la base :
   ```
   pg_restore --clean --if-exists --no-owner -d "postgres://voyaj:***@localhost:5432/voyaj" voyaj-AAAAMMJJ-HHMMSS.dump
   ```
3. Recopier le dossier `files/` de la sauvegarde dans `VOYAJ_DATA_DIR/files`.
4. Redémarrer le service avec la **même** `VOYAJ_MASTER_KEY`.
5. Les postes clients se resynchronisent seuls ; les saisies faites hors ligne depuis la
   sauvegarde sont renvoyées automatiquement.
