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
        <router-link to="/boutique" class="btn btn-primary animate__animated animate__pulse animate__infinite">
          Soutenez notre projet
        </router-link>
      </div>
      <div class="hero-image" data-aos="fade-left">
        <img src="/logo.png" alt="4L Trophy" class="hero-logo">
      </div>
    </section>

    <section class="about-section">
      <div class="container">
        <h2 class="section-title" data-aos="fade-up">Notre Projet</h2>
        
        <div class="about-content">
          <div class="about-card" data-aos="fade-right">
            <div class="card-icon">🏜️</div>
            <h3>L'Aventure</h3>
            <p>
              Le 4L Trophy est un raid humanitaire étudiant qui nous emmènera à travers 
              le désert marocain sur plus de 6000 km. Une aventure humaine extraordinaire 
              mêlant dépassement de soi et solidarité.
            </p>
          </div>
          
          <div class="about-card" data-aos="fade-up">
            <div class="card-icon">❤️</div>
            <h3>L'Humanitaire</h3>
            <p>
              Notre mission : apporter des fournitures scolaires et sportives aux enfants 
              défavorisés du Maroc. Chaque kilomètre parcouru contribue à améliorer leur 
              quotidien et leur donner accès à l'éducation.
            </p>
          </div>
          
          <div class="about-card" data-aos="fade-left">
            <div class="card-icon">🎯</div>
            <h3>Notre Équipe</h3>
            <p>
              Nous sommes deux étudiants passionnés, prêts à relever ce défi unique. 
              Cette expérience forge des liens indéfectibles et des souvenirs inoubliables 
              tout en œuvrant pour une noble cause.
            </p>
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
            <div class="stat-number">10</div>
            <div class="stat-label">Jours d'aventure</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">1000+</div>
            <div class="stat-label">Équipes participantes</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">∞</div>
            <div class="stat-label">Souvenirs</div>
          </div>
        </div>
      </div>
    </section>

    <section class="cta-section">
      <div class="container">
        <div class="cta-content" data-aos="flip-up">
          <h2>Soutenez Notre Projet !</h2>
          <p>
            Achetez nos t-shirts exclusifs et contribuez à financer notre aventure solidaire. 
            Chaque achat nous rapproche de notre objectif et aide les enfants du Maroc.
          </p>
          <router-link to="/boutique" class="btn btn-primary">
            Découvrir la boutique
          </router-link>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'

onMounted(() => {
  document.title = '4L des Dômes - Notre aventure au 4L Trophy'
})
</script>

<style scoped>
.home {
  min-height: 100vh;
}

.hero {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9)),
              url('/images/desert-bg.jpg') center/cover;
  min-height: 90vh;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 60px 20px;
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
  background: radial-gradient(circle at 20% 50%, rgba(255, 107, 53, 0.3), transparent 50%),
              radial-gradient(circle at 80% 50%, rgba(247, 147, 30, 0.3), transparent 50%);
  animation: pulse 4s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}

.hero-content {
  flex: 1;
  max-width: 600px;
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
  font-size: 24px;
  margin-bottom: 40px;
  color: rgba(255, 255, 255, 0.95);
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
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

.about-section {
  padding: 100px 20px;
  background: white;
}

.about-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 40px;
}

.about-card {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 40px;
  border-radius: 20px;
  text-align: center;
  transition: all 0.3s ease;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.about-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
}

.card-icon {
  font-size: 64px;
  margin-bottom: 20px;
}

.about-card h3 {
  font-size: 28px;
  margin-bottom: 15px;
  color: var(--dark-color);
}

.about-card p {
  font-size: 16px;
  line-height: 1.8;
  color: #555;
}

.stats-section {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  padding: 80px 20px;
  color: white;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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

.cta-section {
  padding: 100px 20px;
  background: white;
}

.cta-content {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
  padding: 60px 40px;
  border-radius: 20px;
  text-align: center;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
}

.cta-content h2 {
  font-size: 42px;
  margin-bottom: 20px;
}

.cta-content p {
  font-size: 18px;
  line-height: 1.8;
  margin-bottom: 30px;
  color: #555;
  max-width: 700px;
  margin-left: auto;
  margin-right: auto;
}

@media (max-width: 768px) {
  .hero {
    flex-direction: column;
    text-align: center;
    min-height: auto;
    padding: 40px 20px;
  }
  
  .hero h1 {
    font-size: 42px;
  }
  
  .hero-subtitle {
    font-size: 18px;
  }
  
  .hero-logo {
    width: 250px;
    height: 250px;
    margin-top: 30px;
  }
  
  .about-content {
    grid-template-columns: 1fr;
  }
  
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .cta-content h2 {
    font-size: 32px;
  }
}
</style>
