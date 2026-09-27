#!/usr/bin/env bash
# Sauvegarde quotidienne du déploiement Docker : base PostgreSQL et fichiers
# joints (volume `files`).
# Installation (cron, tous les jours à 3 h) :
#   (crontab -l 2>/dev/null; echo "0 3 * * * $HOME/voyaj/deploy/docker/backup.sh") | crontab -
# Restauration :
#   gunzip -c <fichier>.sql.gz | sudo docker compose exec -T postgres psql -U voyaj -d voyaj
#   sudo docker run --rm -i -v voyaj_files:/data alpine tar -xzf - -C /data < <fichier>-files.tar.gz
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-$HOME/backups}"
KEEP_DAYS="${KEEP_DAYS:-14}"
cd "$(dirname "$0")"

mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"
file="$BACKUP_DIR/voyaj-$(date +%Y%m%d-%H%M%S).sql.gz"
sudo docker compose exec -T postgres pg_dump -U voyaj -d voyaj --no-owner | gzip > "$file"
chmod 600 "$file"
files="${file%.sql.gz}-files.tar.gz"
sudo docker run --rm -v voyaj_files:/data:ro alpine tar -czf - -C /data . > "$files"
chmod 600 "$files"
find "$BACKUP_DIR" -name 'voyaj-*.gz' -mtime "+$KEEP_DAYS" -delete
echo "Sauvegarde : $file ($(du -h "$file" | cut -f1)), $files ($(du -h "$files" | cut -f1))"
