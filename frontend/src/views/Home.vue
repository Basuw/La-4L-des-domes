<script setup>
import { onMounted } from 'vue'
import logoImg from '/logo.png?url'
import ppImg from '/img/pp.png?url'

onMounted(() => {
  document.title = '4L des Dômes - Notre aventure au 4L Trophy 2026'
})
</script>

<template>
  <div class="home">
    <section class="hero">
      <div class="hero-content" data-aos="fade-up">
        <h1 class="animate__animated animate__fadeInDown">
          4L des Dômes
        </h1>
        <p class="hero-subtitle animate__animated animate__fadeInUp">
          Notre aventure solidaire au 4L Trophy 2026
        </p>
        <div class="hero-dates">
          📅 18 février - 1er mars 2026
        </div>
        <div class="hero-actions">
          <router-link to="/boutique" class="btn btn-primary animate__animated animate__pulse animate__infinite">
            Soutenez notre projet
          </router-link>
          <a href="https://linktr.ee/la4ldesdomes" target="_blank" rel="noopener noreferrer" class="btn btn-linktree">
            🌳 Nous suivre
          </a>
        </div>
      </div>
      <div class="hero-image" data-aos="fade-left">
        <img :src="logoImg" alt="4L Trophy" class="hero-logo">
      </div>
    </section>

    <section class="team-section">
      <div class="container">
        <h2 class="section-title" data-aos="fade-up">👨‍🔧 Qui sommes-nous ?</h2>
        
        <div class="team-content">
          <div class="team-photo" data-aos="fade-right">
            <img :src="ppImg" alt="Antoine et Bastien - 4L des Dômes">
            <div class="photo-overlay">
              <div class="overlay-text">Antoine & Bastien</div>
            </div>
          </div>
          
          <div class="team-description" data-aos="fade-left">
            <p class="intro-text">
              Nous sommes deux étudiants de Clermont-Ferrand en dernière année d'école d'ingénieur 
              en informatique à l'ISIMA. Animés par l'envie de vivre une aventure unique et de relever 
              un défi à la fois technique, humain et solidaire, nous avons créé l'association pour 
              partir au Maroc.
            </p>
            
            <div class="member-cards">
              <div class="member-card">
                <div class="member-icon">🏎️</div>
                <h4>Antoine Imbert</h4>
                <p class="member-age">23 ans</p>
                <p>
                  Passionné par l'automobile et la mécanique (karting, drift, préparation de véhicules). 
                  Pratique quotidiennement la capoeira.
                </p>
              </div>
              
              <div class="member-card">
                <div class="member-icon">🚒</div>
                <h4>Bastien Jacquelin</h4>
                <p class="member-age">21 ans</p>
                <p>
                  Passionné par le sport mécanique (notamment le Dakar). Sapeur-pompier volontaire 
                  dans le Puy-de-Dôme, formé à la rigueur et l'esprit d'équipe.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="project-section">
      <div class="container">
        <h2 class="section-title" data-aos="fade-up">🏁 Le Projet : La 4L des Dômes</h2>
        
        <div class="project-grid">
          <div class="project-card large-card" data-aos="zoom-in">
            <div class="card-header">
              <div class="card-icon-large">🌍</div>
              <h3>L'Aventure 4L Trophy 2026</h3>
            </div>
            <div class="card-body">
              <p class="highlight-text">
                Le 4L Trophy est le plus grand raid étudiant humanitaire d'Europe.
              </p>
              <div class="info-grid">
                <div class="info-item">
                  <span class="info-label">📅 Dates</span>
                  <span class="info-value">18 février - 1er mars 2026</span>
                </div>
                <div class="info-item">
                  <span class="info-label">🚗 Équipages</span>
                  <span class="info-value">~1100 Renault 4L</span>
                </div>
                <div class="info-item">
                  <span class="info-label">📍 Parcours</span>
                  <span class="info-value">🇫🇷 France → 🇪🇸 Espagne → 🇲🇦 Maroc</span>
                </div>
                <div class="info-item">
                  <span class="info-label">🗺️ Distance</span>
                  <span class="info-value">~6000 km en 11 jours</span>
                </div>
              </div>
              <div class="objective-box">
                <strong>🎯 L'Objectif :</strong> Ce n'est pas une course de vitesse, mais d'orientation ! 
                Le vainqueur est celui qui effectue le moins de kilomètres en respectant le tracé du 
                roadbook. Seule la boussole est autorisée pour s'orienter.
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="solidarity-section">
      <div class="container">
        <h2 class="section-title" data-aos="fade-up">🤝 Notre Mission Solidaire</h2>
        <p class="section-subtitle" data-aos="fade-up">
          L'ADN du 4L Trophy : <strong>ACTION - PARTAGE - SOLIDARITÉ</strong>
        </p>
        
        <div class="solidarity-content">
          <div class="solidarity-card" data-aos="flip-left">
            <div class="solidarity-icon">📚</div>
            <h3>Enfants du Désert</h3>
            <p>
              Notre mission principale est l'acheminement de <strong>fournitures scolaires et sportives</strong> 
              pour les enfants de la Province d'Errachidia au Maroc.
            </p>
            <div class="impact-badge">
              26 salles de classe construites grâce aux Trophistes
            </div>
          </div>
          
          <div class="solidarity-card" data-aos="flip-right">
            <div class="solidarity-icon">🌱</div>
            <h3>Cap Eco Solidaire</h3>
            <p>
              Soutien de projets <strong>environnementaux et solidaires</strong>, comme le financement 
              d'ouvrages de collecte et valorisation des eaux de ruissellement dans les montagnes du Moyen Atlas.
            </p>
            <div class="impact-badge">
              Protection de l'environnement marocain
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="stats-section" data-aos="zoom-in">
      <div class="container">
        <div class="stats-grid">
          <div class="stat-item">
            <div class="stat-number">6000</div>
            <div class="stat-label">Kilomètres</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">11</div>
            <div class="stat-label">Jours d'aventure</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">1100</div>
            <div class="stat-label">Équipages</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">11 287€</div>
            <div class="stat-label">Budget à atteindre</div>
          </div>
        </div>
      </div>
    </section>

    <section class="support-section">
      <div class="container">
        <h2 class="section-title" data-aos="fade-up">💰 Soutenez la 4L des Dômes</h2>
        
        <div class="support-intro" data-aos="fade-up">
          <p>
            Pour concrétiser cette aventure humaine et solidaire, nous devons collecter un 
            <strong>budget prévisionnel total de 11 287 €</strong> (avant revente de la 4L).
          </p>
          <p>
            Votre soutien est essentiel et peut se faire de deux manières :
          </p>
        </div>
        
        <div class="support-options">
          <div class="support-card" data-aos="zoom-in">
            <div class="support-icon">👕</div>
            <h3>Soutien via la boutique</h3>
            <p>
              Achat de merchandising : Chaque achat sur notre boutique éphémère nous aide à financer 
              les postes de dépenses majeurs (inscription au raid, pièces mécaniques, assurance).
            </p>
            <router-link to="/boutique" class="btn btn-primary">
              Acheter nos t-shirts
            </router-link>
          </div>
          
          <div class="support-card featured" data-aos="zoom-in">
            <div class="support-icon">💝</div>
            <h3>Dons directs</h3>
            <p>
              Les dons libres nous permettent d'atteindre notre objectif et d'assurer la sécurité 
              et la conformité de notre véhicule.
            </p>
            <a href="https://www.helloasso.com/associations/la-4l-des-domes/formulaires/1" target="_blank" rel="noopener noreferrer" class="btn btn-linktree">
              💝 Faire un don
            </a>
          </div>
        </div>
      </div>
    </section>

    <section class="follow-section">
      <div class="container">
        <div class="follow-content" data-aos="flip-up">
          <h2>📲 Où nous suivre ?</h2>
          <p>
            Suivez notre préparation mécanique, notre recherche de sponsors, notre départ 
            et notre aventure dans le désert !
          </p>
          <div class="follow-links">
            <a href="https://www.instagram.com/la4ldesdomes" target="_blank" rel="noopener noreferrer" class="follow-btn instagram-btn">
              <span class="instagram-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                  <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                  <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                </svg>
              </span>
              <span>@la4ldesdomes</span>
            </a>
            <a href="https://linktr.ee/la4ldesdomes" target="_blank" rel="noopener noreferrer" class="follow-btn linktree-btn">
              <span class="follow-emoji">🌳</span>
              <span>Notre Linktree</span>
            </a>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.home {
  min-height: 100vh;
}

.hero {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.95), rgba(118, 75, 162, 0.95));
  min-height: 90vh;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 60px 40px;
  color: white;
  position: relative;
  overflow: hidden;
}

.hero::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: url('/img/4l.png');
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  opacity: 0.1;
  filter: grayscale(100%) brightness(1.8);
  pointer-events: none;
  z-index: 1;
}

.hero::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(circle at 20% 50%, rgba(255, 107, 53, 0.3), transparent 50%),
              radial-gradient(circle at 80% 50%, rgba(247, 147, 30, 0.3), transparent 50%);
  animation: pulse 4s ease-in-out infinite;
  z-index: 1;
}

@keyframes pulse {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}

.hero-content {
  flex: 1;
  max-width: 650px;
  z-index: 2;
}

.hero h1 {
  font-size: 72px;
  font-weight: 900;
  margin-bottom: 20px;
  color: white;
  text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.3);
  line-height: 1.2;
}

.hero-subtitle {
  font-size: 26px;
  margin-bottom: 20px;
  color: rgba(255, 255, 255, 0.95);
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
}

.hero-dates {
  font-size: 20px;
  font-weight: 700;
  margin-bottom: 30px;
  padding: 12px 24px;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  border-radius: 50px;
  display: inline-block;
}

.hero-actions {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.btn-linktree {
  background: linear-gradient(135deg, #43E97B 0%, #38F9D7 100%);
  color: white;
  font-size: 18px;
  font-weight: 700;
  padding: 16px 32px;
  border-radius: 50px;
  text-decoration: none;
  transition: all 0.3s ease;
  box-shadow: 0 8px 20px rgba(67, 233, 123, 0.4);
  border: none;
}

.btn-linktree:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 30px rgba(67, 233, 123, 0.6);
}

.hero-image {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2;
}

.hero-logo {
  width: 400px;
  height: 400px;
  object-fit: contain;
  filter: drop-shadow(0 10px 30px rgba(0, 0, 0, 0.3));
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-20px); }
}

.team-section {
  padding: 100px 20px;
  background: white;
}

.team-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
  margin-top: 60px;
}

.team-photo {
  position: relative;
  border-radius: 30px;
  overflow: hidden;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
  transition: transform 0.3s ease;
}

.team-photo:hover {
  transform: scale(1.02);
}

.team-photo img {
  width: 100%;
  height: auto;
  display: block;
}

.photo-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
  padding: 30px;
}

.overlay-text {
  color: white;
  font-size: 32px;
  font-weight: 900;
  text-align: center;
}

.team-description {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.intro-text {
  font-size: 18px;
  line-height: 1.8;
  color: #555;
}

.member-cards {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.member-card {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 30px;
  border-radius: 20px;
  transition: all 0.3s ease;
}

.member-card:hover {
  transform: translateX(10px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.member-icon {
  font-size: 48px;
  margin-bottom: 15px;
}

.member-card h4 {
  font-size: 24px;
  color: var(--dark-color);
  margin-bottom: 5px;
}

.member-age {
  color: var(--primary-color);
  font-weight: 700;
  margin-bottom: 10px;
}

.member-card p {
  line-height: 1.7;
  color: #555;
}

.project-section {
  padding: 100px 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
}

.project-grid {
  margin-top: 60px;
}

.large-card {
  background: white;
  border-radius: 30px;
  overflow: hidden;
  box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
}

.card-header {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  padding: 40px;
  text-align: center;
  color: white;
}

.card-icon-large {
  font-size: 80px;
  margin-bottom: 20px;
}

.card-header h3 {
  font-size: 36px;
  color: white;
}

.card-body {
  padding: 40px;
}

.highlight-text {
  font-size: 20px;
  font-weight: 700;
  color: var(--dark-color);
  text-align: center;
  margin-bottom: 30px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  margin-bottom: 30px;
}

.info-item {
  background: linear-gradient(135deg, #f5f7fa 0%, #e0e7ef 100%);
  padding: 20px;
  border-radius: 15px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.info-label {
  font-size: 14px;
  font-weight: 600;
  color: #666;
}

.info-value {
  font-size: 18px;
  font-weight: 700;
  color: var(--dark-color);
}

.objective-box {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
  padding: 25px;
  border-radius: 15px;
  border-left: 5px solid var(--primary-color);
  line-height: 1.8;
  font-size: 16px;
}

.solidarity-section {
  padding: 100px 20px;
  background: white;
}

.section-subtitle {
  text-align: center;
  font-size: 20px;
  margin-top: 10px;
  margin-bottom: 60px;
  color: #555;
}

.solidarity-content {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 40px;
  margin-top: 60px;
}

.solidarity-card {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  padding: 40px;
  border-radius: 25px;
  text-align: center;
  border: 2px solid transparent;
  transition: all 0.3s ease;
}

.solidarity-card:hover {
  border-color: var(--primary-color);
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
}

.solidarity-icon {
  font-size: 80px;
  margin-bottom: 20px;
}

.solidarity-card h3 {
  font-size: 28px;
  color: var(--dark-color);
  margin-bottom: 20px;
}

.solidarity-card p {
  font-size: 16px;
  line-height: 1.8;
  color: #555;
  margin-bottom: 20px;
}

.impact-badge {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  color: white;
  padding: 12px 20px;
  border-radius: 50px;
  font-weight: 700;
  font-size: 14px;
  display: inline-block;
}

.stats-section {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  padding: 80px 20px;
  color: white;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 40px;
  text-align: center;
}

.stat-number {
  font-size: 56px;
  font-weight: 900;
  margin-bottom: 10px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
}

.stat-label {
  font-size: 18px;
  font-weight: 600;
  opacity: 0.9;
}

.support-section {
  padding: 100px 20px;
  background: #f8f9fa;
}

.support-intro {
  text-align: center;
  max-width: 800px;
  margin: 30px auto 60px;
  font-size: 18px;
  line-height: 1.8;
  color: #555;
}

.support-intro strong {
  color: var(--primary-color);
}

.support-options {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 40px;
  margin-top: 60px;
}

.support-card {
  background: white;
  padding: 50px;
  border-radius: 25px;
  text-align: center;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.support-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
}

.support-card.featured {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
  border: 3px solid var(--primary-color);
}

.support-icon {
  font-size: 80px;
  margin-bottom: 25px;
}

.support-card h3 {
  font-size: 28px;
  color: var(--dark-color);
  margin-bottom: 20px;
}

.support-card p {
  font-size: 16px;
  line-height: 1.8;
  color: #555;
  margin-bottom: 30px;
}

.follow-section {
  padding: 80px 20px;
  background: linear-gradient(135deg, var(--dark-color), #1a1a2e);
}

.follow-content {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  padding: 60px 40px;
  border-radius: 25px;
  text-align: center;
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.1);
}

.follow-content h2 {
  font-size: 42px;
  margin-bottom: 20px;
  color: white;
}

.follow-content p {
  font-size: 18px;
  line-height: 1.8;
  margin-bottom: 40px;
  opacity: 0.9;
}

.follow-links {
  display: flex;
  justify-content: center;
  gap: 20px;
  flex-wrap: wrap;
}

.follow-btn {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  padding: 16px 32px;
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 18px;
  transition: all 0.3s ease;
}

.instagram-btn {
  background: linear-gradient(135deg, #833AB4 0%, #FD1D1D 50%, #F77737 100%);
  box-shadow: 0 8px 20px rgba(131, 58, 180, 0.4);
}

.instagram-btn:hover {
  transform: scale(1.05);
  box-shadow: 0 12px 30px rgba(131, 58, 180, 0.6);
}

.instagram-icon {
  display: flex;
  align-items: center;
  justify-content: center;
}

.instagram-icon svg {
  width: 28px;
  height: 28px;
}

.linktree-btn {
  background: linear-gradient(135deg, #43E97B 0%, #38F9D7 100%);
  box-shadow: 0 8px 20px rgba(67, 233, 123, 0.4);
}

.linktree-btn:hover {
  transform: scale(1.05);
  box-shadow: 0 12px 30px rgba(67, 233, 123, 0.6);
}

.follow-emoji {
  font-size: 32px;
}

@media (max-width: 968px) {
  .hero {
    flex-direction: column;
    text-align: center;
    min-height: auto;
    padding: 40px 20px;
  }
  
  .hero h1 {
    font-size: 48px;
  }
  
  .hero-subtitle {
    font-size: 20px;
  }
  
  .hero-dates {
    font-size: 18px;
    padding: 10px 20px;
  }
  
  .hero-actions {
    justify-content: center;
    flex-direction: column;
    width: 100%;
  }
  
  .hero-actions .btn,
  .hero-actions .btn-linktree {
    width: 100%;
    max-width: 300px;
    font-size: 16px;
    padding: 14px 28px;
  }
  
  .hero-logo {
    width: 250px;
    height: 250px;
    margin-top: 30px;
  }
  
  .team-content {
    grid-template-columns: 1fr;
    gap: 40px;
  }
  
  .team-section,
  .project-section,
  .solidarity-section,
  .support-section {
    padding: 60px 20px;
  }
  
  .intro-text {
    font-size: 16px;
  }
  
  .member-card {
    padding: 25px;
  }
  
  .member-icon {
    font-size: 40px;
  }
  
  .card-icon-large {
    font-size: 60px;
  }
  
  .card-header h3 {
    font-size: 28px;
  }
  
  .card-body {
    padding: 30px 25px;
  }
  
  .info-grid {
    grid-template-columns: 1fr;
  }
  
  .solidarity-content {
    grid-template-columns: 1fr;
    gap: 30px;
  }
  
  .solidarity-icon {
    font-size: 60px;
  }
  
  .solidarity-card h3 {
    font-size: 24px;
  }
  
  .stats-section {
    padding: 60px 20px;
  }
  
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 30px;
  }
  
  .stat-number {
    font-size: 42px;
  }
  
  .stat-label {
    font-size: 16px;
  }
  
  .support-options {
    grid-template-columns: 1fr;
    gap: 30px;
  }
  
  .support-card {
    padding: 40px 30px;
  }
  
  .support-icon {
    font-size: 60px;
  }
  
  .follow-content {
    padding: 40px 30px;
  }
  
  .follow-content h2 {
    font-size: 32px;
  }
  
  .follow-content p {
    font-size: 16px;
  }
}

@media (max-width: 480px) {
  .hero h1 {
    font-size: 36px;
  }
  
  .hero-subtitle {
    font-size: 18px;
  }
  
  .hero-dates {
    font-size: 16px;
  }
  
  .hero-logo {
    width: 200px;
    height: 200px;
  }
  
  .team-section,
  .project-section,
  .solidarity-section,
  .support-section {
    padding: 40px 15px;
  }
  
  .overlay-text {
    font-size: 24px;
  }
  
  .member-card {
    padding: 20px;
  }
  
  .member-card h4 {
    font-size: 20px;
  }
  
  .card-header {
    padding: 30px 20px;
  }
  
  .card-header h3 {
    font-size: 24px;
  }
  
  .card-body {
    padding: 25px 20px;
  }
  
  .stats-grid {
    grid-template-columns: 1fr;
    gap: 25px;
  }
  
  .stat-number {
    font-size: 36px;
  }
  
  .support-card {
    padding: 30px 25px;
  }
  
  .support-card h3 {
    font-size: 24px;
  }
  
  .follow-section {
    padding: 60px 15px;
  }
  
  .follow-content {
    padding: 30px 20px;
  }
  
  .follow-content h2 {
    font-size: 28px;
  }
  
  .follow-btn {
    font-size: 16px;
    padding: 14px 28px;
  }
}
</style>
