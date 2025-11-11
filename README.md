# 4L des Dômes - Site Web du Projet 4L Trophy

Site web présentant notre projet pour le 4L Trophy avec une boutique en ligne pour soutenir l'aventure.

## 🚀 Technologies

### Frontend
- **Vue.js 3** avec Composition API
- **Vite** pour le build
- **Pinia** pour la gestion d'état
- **Vue Router** pour la navigation
- **Axios** pour les appels API
- **AOS** (Animate On Scroll) pour les animations
- **Animate.css** pour les effets CSS

### Backend
- **Spring Boot 3.2.1** avec Java 21
- **Spring Security** avec JWT
- **Spring Data JPA** avec PostgreSQL
- **Hibernate** pour l'ORM
- **Maven** pour la gestion des dépendances
- **Lombok** pour réduire le code boilerplate

### Base de données
- **PostgreSQL 16**

### Infrastructure
- **Docker** et **Docker Compose**
- **Nginx** pour le serveur web frontend

## 📋 Prérequis

- Docker et Docker Compose
- Node.js 20+ (pour le développement local)
- Java 21 et Maven (pour le développement local)

## 🛠️ Installation et Démarrage

### Avec Docker (Recommandé)

1. Cloner le repository
```bash
git clone <repo-url>
cd La-4L-des-d-mes
```

2. Lancer tous les services avec Docker Compose
```bash
docker-compose up --build
```

3. Accéder à l'application
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8080/api
- **Base de données**: localhost:5432

### Développement Local

#### Backend
```bash
cd backend
mvn spring-boot:run
```

#### Frontend
```bash
cd frontend
npm install
npm run dev
```

Le frontend sera disponible sur http://localhost:5173

## 🏗️ Architecture

```
.
├── backend/                    # Application Spring Boot
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/fourltroph/
│   │   │   │   ├── config/         # Configuration (Security, CORS, DataInit)
│   │   │   │   ├── controller/     # REST Controllers
│   │   │   │   ├── dto/            # Data Transfer Objects
│   │   │   │   ├── entity/         # JPA Entities
│   │   │   │   ├── repository/     # Spring Data Repositories
│   │   │   │   └── service/        # Business Logic
│   │   │   └── resources/
│   │   │       └── application.yml
│   ├── Dockerfile
│   └── pom.xml
│
├── frontend/                   # Application Vue.js
│   ├── public/
│   │   └── logo.png
│   ├── src/
│   │   ├── components/         # Composants réutilisables
│   │   │   ├── Navbar.vue
│   │   │   └── Footer.vue
│   │   ├── views/              # Pages principales
│   │   │   ├── Home.vue
│   │   │   └── Shop.vue
│   │   ├── stores/             # Pinia stores
│   │   │   └── cart.js
│   │   ├── services/           # Services API
│   │   │   └── api.js
│   │   ├── router/             # Configuration Vue Router
│   │   ├── App.vue
│   │   ├── main.js
│   │   └── style.css
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── package.json
│   └── vite.config.js
│
└── docker-compose.yml
```

## 🔒 Sécurité

- **CORS** configuré pour autoriser uniquement les origines spécifiques
- **Spring Security** avec protection CSRF désactivée pour l'API REST
- **JWT** prêt pour l'authentification (infrastructure en place)
- **Validation** des données côté backend avec Bean Validation
- **PostgreSQL** avec credentials configurables via variables d'environnement
- **Transactions** gérées pour la cohérence des données

## 🛍️ Fonctionnalités

### Page d'Accueil
- Présentation du projet 4L Trophy
- Section "Notre Projet" avec 3 cartes descriptives
- Statistiques animées
- Call-to-action vers la boutique
- Animations fluides avec AOS

### Boutique
- Affichage des produits disponibles
- Gestion du panier avec Pinia
- Sélection de quantité par produit
- Formulaire de commande avec validation
- Confirmation de commande
- Gestion du stock en temps réel

### Backend API
- `GET /api/products` - Liste tous les produits
- `GET /api/products/available` - Produits en stock
- `GET /api/products/{id}` - Détails d'un produit
- `POST /api/orders` - Créer une commande
- `GET /api/orders/{id}` - Détails d'une commande

## 🗄️ Base de Données

### Entités
- **Product**: Produits (t-shirts) avec prix, taille, stock
- **Order**: Commandes avec informations client
- **OrderItem**: Lignes de commande

### Initialisation
Deux t-shirts sont automatiquement créés au démarrage:
- T-Shirt 4L Trophy - Édition Sable (29.99€)
- T-Shirt 4L Trophy - Édition Aventure (34.99€)

## 🎨 Design

- Design moderne avec dégradés colorés
- Animations fluides et engageantes
- Responsive design pour mobile et desktop
- Thème inspiré du désert et de l'aventure
- Palette de couleurs: Orange/Rouge (#FF6B35), Jaune (#F7931E), Violet (#667eea, #764ba2)

## 📝 Variables d'Environnement

### Backend
- `DB_HOST`: Hôte PostgreSQL (défaut: localhost)
- `DB_PORT`: Port PostgreSQL (défaut: 5432)
- `DB_NAME`: Nom de la base (défaut: fourltroph)
- `DB_USER`: Utilisateur PostgreSQL (défaut: fourltroph)
- `DB_PASSWORD`: Mot de passe (défaut: fourltroph2026)
- `JWT_SECRET`: Secret pour JWT
- `CORS_ORIGINS`: Origines autorisées pour CORS
- `SERVER_PORT`: Port du serveur (défaut: 8080)

### Frontend
- `VITE_API_URL`: URL de l'API backend (défaut: http://localhost:8080/api)

## 🚦 Commandes Utiles

### Docker
```bash
docker-compose up -d          # Démarrer en arrière-plan
docker-compose down           # Arrêter les services
docker-compose logs -f        # Voir les logs
docker-compose restart        # Redémarrer les services
```

### Frontend
```bash
npm run dev      # Mode développement
npm run build    # Build production
npm run preview  # Prévisualiser le build
```

### Backend
```bash
mvn clean install        # Compiler et installer
mvn spring-boot:run      # Lancer l'application
mvn test                 # Lancer les tests
```

## 📄 Licence

MIT - Voir le fichier LICENSE pour plus de détails

## 👥 Équipe

**4L des Dômes** - Équipe du 4L Trophy 2026

---

Fait avec ❤️ pour le 4L Trophy 2026