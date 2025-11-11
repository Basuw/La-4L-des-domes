<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-section">
          <h3>4L des Dômes</h3>
          <p>Notre aventure solidaire au 4L Trophy 2026</p>
        </div>
        
        <div class="footer-section">
          <h4>Contact</h4>
          <p>Email: contact@4ldesdomes.fr</p>
          <p>Tél: +33 6 XX XX XX XX</p>
        </div>
        
        <div class="footer-section">
          <h4>Suivez-nous</h4>
          <div class="social-links">
            <a href="#" class="social-link">Facebook</a>
            <a href="#" class="social-link">Instagram</a>
            <a href="#" class="social-link">Twitter</a>
          </div>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2026 4L des Dômes - Tous droits réservés</p>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.footer {
  background: linear-gradient(135deg, #2C3E50, #34495e);
  color: white;
  padding: 60px 0 20px;
  margin-top: 100px;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px;
  margin-bottom: 40px;
}

.footer-section h3 {
  color: var(--secondary-color);
  margin-bottom: 15px;
}

.footer-section h4 {
  color: var(--light-color);
  margin-bottom: 15px;
  font-size: 18px;
}

.footer-section p {
  color: rgba(255, 255, 255, 0.8);
  line-height: 1.8;
}

.social-links {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.social-link {
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  transition: color 0.3s ease;
}

.social-link:hover {
  color: var(--secondary-color);
}

.footer-bottom {
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding-top: 20px;
  text-align: center;
}

.footer-bottom p {
  color: rgba(255, 255, 255, 0.6);
  font-size: 14px;
}

@media (max-width: 768px) {
  .footer {
    padding: 40px 0 20px;
  }
  
  .footer-content {
    grid-template-columns: 1fr;
    gap: 30px;
  }
}
</style>
