#!/usr/bin/env bash
# Sauvegarde quotidienne de la base PostgreSQL du déploiement Docker.
# Installation (cron, tous les jours à 3 h) :
#   (crontab -l 2>/dev/null; echo "0 3 * * * $HOME/voyaj/deploy/docker/backup.sh") | crontab -
# Restauration :
#   gunzip -c <fichier>.sql.gz | sudo docker compose exec -T postgres psql -U voyaj -d voyaj
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-$HOME/backups}"
KEEP_DAYS="${KEEP_DAYS:-14}"
cd "$(dirname "$0")"

mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"
file="$BACKUP_DIR/voyaj-$(date +%Y%m%d-%H%M%S).sql.gz"
sudo docker compose exec -T postgres pg_dump -U voyaj -d voyaj --no-owner | gzip > "$file"
chmod 600 "$file"
find "$BACKUP_DIR" -name 'voyaj-*.sql.gz' -mtime "+$KEEP_DAYS" -delete
echo "Sauvegarde : $file ($(du -h "$file" | cut -f1))"
