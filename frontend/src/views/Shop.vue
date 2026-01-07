<template>
  <div class="shop">
    <section class="shop-hero">
      <div class="container">
        <h1 class="animate__animated animate__fadeInDown">Boutique</h1>
        <p class="shop-subtitle">Soutenez notre projet en achetant nos t-shirts exclusifs</p>
        
        <div class="countdown-timer" v-if="!isCountdownExpired">
          <div class="countdown-title">⏰ Fermeture de la boutique dans :</div>
          <div class="timer-container">
            <div class="time-block">
              <div class="time-value">{{ days }}</div>
              <div class="time-label">Jours</div>
            </div>
            <div class="time-separator">:</div>
            <div class="time-block">
              <div class="time-value">{{ hours }}</div>
              <div class="time-label">Heures</div>
            </div>
            <div class="time-separator">:</div>
            <div class="time-block">
              <div class="time-value">{{ minutes }}</div>
              <div class="time-label">Minutes</div>
            </div>
            <div class="time-separator">:</div>
            <div class="time-block">
              <div class="time-value">{{ seconds }}</div>
              <div class="time-label">Secondes</div>
            </div>
          </div>
          <p class="countdown-message">🚨 Après cette date, la boutique sera fermée et il ne sera plus possible d'acheter nos produits</p>
        </div>
        
        <div class="countdown-expired" v-else>
          <h2>🔒 Boutique Fermée</h2>
          <p>La période de vente est terminée. Merci pour votre soutien !</p>
        </div>
      </div>
    </section>

    <section class="products-section">
      <div class="container">
        <div v-if="loading" class="loading">
          <div class="spinner"></div>
          <p>Chargement des produits...</p>
        </div>

        <div v-else-if="error" class="error">
          <p>{{ error }}</p>
          <button @click="loadProducts" class="btn btn-primary">Réessayer</button>
        </div>

        <div v-else class="products-grid">
          <div 
            v-for="product in products" 
            :key="product.id" 
            class="product-card"
            data-aos="fade-up"
          >
            <router-link :to="`/produit/${product.id}`" class="product-image-link">
              <div class="product-image">
                <img :src="product.colors[0].frontImage" :alt="product.name">
                <div class="view-details-overlay">
                  <span class="view-icon">👁️</span>
                  <span>Voir les détails</span>
                </div>
                <div v-if="product.stock < 10 && product.stock > 0" class="stock-badge">
                  Plus que {{ product.stock }} en stock !
                </div>
                <div v-else-if="product.stock === 0" class="stock-badge out-of-stock">
                  Rupture de stock
                </div>
              </div>
            </router-link>
            
            <div class="product-info">
              <router-link :to="`/produit/${product.id}`" class="product-title-link">
                <h3>{{ product.name }}</h3>
              </router-link>
              <p class="product-description">{{ product.description }}</p>
              
              <div class="color-preview">
                <span class="color-label">Couleurs disponibles :</span>
                <div class="color-swatches">
                  <div 
                    v-for="color in product.colors" 
                    :key="color.name"
                    class="color-swatch"
                    :style="{ 
                      backgroundColor: color.hex,
                      border: color.hex === '#FFFFFF' ? '2px solid #ddd' : 'none'
                    }"
                    :title="color.label"
                  ></div>
                </div>
              </div>

              <div class="product-details">
                <span class="product-price">{{ formatPrice(product.price) }}</span>
              </div>
              
              <div class="product-actions">
                <router-link :to="`/produit/${product.id}`" class="btn btn-secondary view-details-btn">
                  Voir les détails
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useCartStore } from '../stores/cart'
import { productService } from '../services/api'

const cartStore = useCartStore()
const products = ref([])
const loading = ref(true)
const error = ref(null)

// Countdown timer
const countdownDate = new Date('January 15, 2026 18:00:00').getTime()
const days = ref(0)
const hours = ref(0)
const minutes = ref(0)
const seconds = ref(0)
const isCountdownExpired = ref(false)

let countdownInterval = null

const updateCountdown = () => {
  const now = new Date().getTime()
  const distance = countdownDate - now

  if (distance < 0) {
    isCountdownExpired.value = true
    if (countdownInterval) {
      clearInterval(countdownInterval)
    }
    return
  }

  days.value = Math.floor(distance / (1000 * 60 * 60 * 24))
  hours.value = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
  minutes.value = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
  seconds.value = Math.floor((distance % (1000 * 60)) / 1000)
}

const formatPrice = (price) => {
  return new Intl.NumberFormat('fr-FR', {
    style: 'currency',
    currency: 'EUR'
  }).format(price)
}

const loadProducts = async () => {
  try {
    loading.value = true
    error.value = null
    const response = await productService.getAllProducts()
    products.value = response.data
  } catch (err) {
    error.value = 'Impossible de charger les produits. Veuillez réessayer.'
    console.error('Erreur lors du chargement des produits:', err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  document.title = 'Boutique - 4L des Dômes'
  loadProducts()
  
  // Start countdown
  updateCountdown()
  countdownInterval = setInterval(updateCountdown, 1000)
})

onUnmounted(() => {
  if (countdownInterval) {
    clearInterval(countdownInterval)
  }
})
</script>

<style scoped>
.shop {
  min-height: 100vh;
}

.shop-hero {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9));
  padding: 80px 20px 60px;
  color: white;
  text-align: center;
}

.shop-hero h1 {
  font-size: 56px;
  color: white;
  margin-bottom: 15px;
}

.shop-subtitle {
  font-size: 20px;
  opacity: 0.9;
  margin-bottom: 40px;
}

.countdown-timer {
  margin-top: 40px;
  padding: 40px;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  border-radius: 25px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  max-width: 800px;
  margin-left: auto;
  margin-right: auto;
}

.countdown-title {
  font-size: 32px;
  font-weight: 900;
  color: white;
  margin-bottom: 30px;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.timer-container {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px;
}

.time-block {
  background: white;
  border-radius: 15px;
  padding: 20px;
  min-width: 100px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  transition: transform 0.3s ease;
}

.time-block:hover {
  transform: translateY(-5px);
}

.time-value {
  font-size: 48px;
  font-weight: 900;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1;
}

.time-label {
  font-size: 14px;
  font-weight: 700;
  color: #666;
  margin-top: 10px;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.time-separator {
  font-size: 48px;
  font-weight: 900;
  color: white;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.countdown-message {
  margin-top: 25px;
  font-size: 16px;
  font-weight: 600;
  color: white;
  text-align: center;
  background: rgba(231, 76, 60, 0.2);
  padding: 15px 20px;
  border-radius: 12px;
  border: 2px solid rgba(231, 76, 60, 0.4);
}

.countdown-expired {
  margin-top: 40px;
  padding: 40px;
  background: rgba(231, 76, 60, 0.2);
  backdrop-filter: blur(10px);
  border-radius: 25px;
  border: 2px solid rgba(231, 76, 60, 0.4);
  text-align: center;
}

.countdown-expired h2 {
  font-size: 36px;
  color: white;
  margin-bottom: 15px;
}

.countdown-expired p {
  font-size: 18px;
  color: white;
  opacity: 0.9;
}

.products-section {
  padding: 80px 20px;
  background: white;
}

.loading,
.error {
  text-align: center;
  padding: 60px 20px;
}

.spinner {
  width: 50px;
  height: 50px;
  border: 4px solid var(--light-color);
  border-top-color: var(--primary-color);
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 20px;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 40px;
}

.product-card {
  background: white;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.product-card.added-to-cart {
  animation: addedBounce 0.5s ease;
}

@keyframes addedBounce {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.product-image {
  position: relative;
  height: 300px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  transition: transform 0.3s ease;
}

.product-image-link {
  display: block;
  position: relative;
  text-decoration: none;
}

.view-details-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(102, 126, 234, 0.95);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 10px;
  opacity: 0;
  transition: opacity 0.3s ease;
  color: white;
  font-weight: 700;
  font-size: 18px;
}

.view-icon {
  font-size: 48px;
}

.product-card:hover .view-details-overlay {
  opacity: 1;
}

.product-card:hover .product-image img {
  transform: scale(1.1);
}

.stock-badge {
  position: absolute;
  top: 15px;
  right: 15px;
  background: var(--secondary-color);
  color: white;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 700;
}

.stock-badge.out-of-stock {
  background: #e74c3c;
}

.product-info {
  padding: 25px;
}

.product-info h3 {
  font-size: 22px;
  margin-bottom: 10px;
  color: var(--dark-color);
}

.product-title-link {
  text-decoration: none;
  color: inherit;
  transition: color 0.3s ease;
}

.product-title-link:hover {
  color: var(--primary-color);
}

.product-description {
  color: #666;
  line-height: 1.6;
  margin-bottom: 15px;
  font-size: 14px;
}

.color-preview {
  margin-bottom: 15px;
  padding: 12px 0;
}

.color-label {
  font-size: 13px;
  font-weight: 600;
  color: #555;
  display: block;
  margin-bottom: 8px;
}

.color-swatches {
  display: flex;
  gap: 10px;
}

.color-swatch {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.color-swatch:hover {
  transform: scale(1.15);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
}

.product-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 2px solid var(--light-color);
}

.product-size {
  font-weight: 600;
  color: #555;
}

.product-price {
  font-size: 28px;
  font-weight: 900;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.product-actions {
  display: flex;
  gap: 15px;
  align-items: center;
}

.view-details-btn {
  flex: 1;
  text-align: center;
  text-decoration: none;
  display: inline-block;
}

.add-to-cart-btn {
  width: 80px;
  padding: 12px 0;
}

.add-to-cart-btn {
  width: 80px;
  padding: 12px 0;
}

.quantity-selector {
  display: flex;
  align-items: center;
  gap: 8px;
  background: var(--light-color);
  border-radius: 50px;
  padding: 5px;
}

@media (max-width: 968px) {
  .shop-hero {
    padding: 60px 20px 40px;
  }

  .shop-hero h1 {
    font-size: 42px;
  }

  .shop-subtitle {
    font-size: 18px;
  }

  .products-section {
    padding: 60px 20px;
  }

  .products-grid {
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
  }
}

@media (max-width: 768px) {
  .shop-hero h1 {
    font-size: 36px;
  }

  .products-grid {
    grid-template-columns: 1fr;
  }

  .product-card {
    border-radius: 15px;
  }

  .product-info {
    padding: 20px;
  }

  .product-info h3 {
    font-size: 20px;
  }
}

@media (max-width: 480px) {
  .shop-hero {
    padding: 40px 15px 30px;
  }

  .shop-hero h1 {
    font-size: 32px;
  }

  .shop-subtitle {
    font-size: 16px;
  }

  .products-section {
    padding: 40px 15px;
  }
}

@media (max-width: 768px) {
}
</style>
