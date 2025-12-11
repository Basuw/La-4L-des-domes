#!/bin/bash
set -e

# Configuration
DB_HOST="postgres"
DB_PORT="5432"
DB_NAME="${POSTGRES_DB}"
DB_USER="${POSTGRES_USER}"
BACKUP_DIR="/backups"
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="${BACKUP_DIR}/fourltrophy-db-${DATE}.sql.gz"

# Créer le dossier de sauvegarde s'il n'existe pas
mkdir -p "${BACKUP_DIR}"

# Faire la sauvegarde avec pg_dump et compression gzip
echo "🔄 Démarrage de la sauvegarde de la base de données..."
PGPASSWORD="${POSTGRES_PASSWORD}" pg_dump -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -d "${DB_NAME}" | gzip > "${BACKUP_FILE}"

# Vérifier que la sauvegarde a réussi
if [ -f "${BACKUP_FILE}" ]; then
    BACKUP_SIZE=$(du -h "${BACKUP_FILE}" | cut -f1)
    echo "✅ Sauvegarde réussie : ${BACKUP_FILE} (${BACKUP_SIZE})"
else
    echo "❌ Erreur : la sauvegarde a échoué"
    exit 1
fi

# Rotation : garder uniquement les 30 derniers jours
echo "🗑️  Nettoyage des anciennes sauvegardes (> 30 jours)..."
find "${BACKUP_DIR}" -name "fourltrophy-db-*.sql.gz" -type f -mtime +30 -delete

# Afficher les sauvegardes disponibles
echo "📦 Sauvegardes disponibles :"
ls -lh "${BACKUP_DIR}"/fourltrophy-db-*.sql.gz 2>/dev/null || echo "Aucune sauvegarde trouvée"

echo "✨ Backup terminé avec succès !"
