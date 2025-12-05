#!/bin/bash

set -e

echo "🚀 Déploiement La 4L des Dômes"

# Vérifier que Docker est installé
if ! command -v docker &> /dev/null; then
    echo "❌ Docker non installé"
    exit 1
fi

# Vérifier que le fichier .env existe
if [ ! -f .env ]; then
    echo "❌ Fichier .env manquant"
    exit 1
fi

# Créer le réseau partagé s'il n'existe pas
echo "🌐 Vérification du réseau Docker partagé..."
docker network inspect shared-network >/dev/null 2>&1 || {
    echo "⚠️  Le réseau 'shared-network' n'existe pas. Création..."
    docker network create shared-network
}
echo "✅ Réseau Docker partagé disponible"

# Démarrer les services
echo "🔄 Démarrage de la base de données..."
docker compose up -d postgres
sleep 15

echo "🔄 Démarrage du backend..."
docker compose up -d backend
sleep 10

echo "🔄 Démarrage du frontend..."
docker compose up -d frontend
sleep 5

echo ""
echo "🎉 Déploiement terminé !"
echo ""
echo "📋 Services disponibles :"
echo "   Frontend: http://localhost:${FRONTEND_PORT:-3000}"
echo "   Backend:  Accessible via le réseau Docker partagé sur le port ${SERVER_PORT:-8001}"
echo "   Database: Accessible via le réseau Docker partagé sur le port 5432"
echo ""
echo "✅ Les services sont connectés au réseau 'shared-network' et accessibles par Nginx"
