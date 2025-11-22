<template>
  <div class="product-detail">
    <div v-if="loading" class="loading-container">
      <div class="spinner"></div>
      <p>Chargement du produit...</p>
    </div>

    <div v-else-if="error" class="error-container">
      <p>{{ error }}</p>
      <router-link to="/boutique" class="btn btn-primary">Retour à la boutique</router-link>
    </div>

    <div v-else class="detail-container">
      <div class="breadcrumb" data-aos="fade-down">
        <router-link to="/">Accueil</router-link>
        <span class="separator">›</span>
        <router-link to="/boutique">Boutique</router-link>
        <span class="separator">›</span>
        <span class="current">{{ product.name }}</span>
      </div>

      <div class="product-content">
        <div class="product-viewer" data-aos="fade-right">
          <div class="viewer-container">
            <div class="tshirt-3d" :class="{ 'is-rotating': autoRotate }">
              <div class="tshirt-wrapper" :style="{ transform: `rotateY(${rotation}deg)` }">
                <div class="tshirt-side front">
                  <img :src="frontImage" :alt="`${product.name} - Face`">
                </div>
                <div class="tshirt-side back">
                  <img :src="backImage" :alt="`${product.name} - Dos`">
                </div>
              </div>
            </div>

            <div class="viewer-controls">
              <button @click="showFront" :class="{ active: rotation === 0 }" class="view-btn">
                <span class="icon">👕</span>
                <span>Face</span>
              </button>
              <button @click="showBack" :class="{ active: rotation === 180 }" class="view-btn">
                <span class="icon">🔄</span>
                <span>Dos</span>
              </button>
              <button @click="toggleAutoRotate" :class="{ active: autoRotate }" class="view-btn">
                <span class="icon">🔁</span>
                <span>Auto</span>
              </button>
            </div>

            <div class="rotation-slider">
              <input 
                type="range" 
                v-model="rotation" 
                min="0" 
                max="360" 
                @input="stopAutoRotate"
                class="slider"
              >
              <div class="slider-labels">
                <span>Face</span>
                <span>Rotation manuelle</span>
                <span>Dos</span>
              </div>
            </div>
          </div>


        </div>

        <div class="product-info" data-aos="fade-left">
          <h1 class="product-title">{{ product.name }}</h1>
          
          <div class="product-price-section">
            <div class="price">{{ formatPrice(product.price) }}</div>
            <div class="stock-info" :class="stockClass">
              <span class="stock-icon">●</span>
              <span>{{ stockText }}</span>
            </div>
          </div>

          <p class="product-description">{{ product.description }}</p>

          <div class="size-selector">
            <label class="selector-label">
              <span class="icon">📏</span>
              Taille
            </label>
            <div class="size-options">
              <button 
                v-for="size in sizes" 
                :key="size"
                @click="selectedSize = size"
                :class="{ active: selectedSize === size }"
                class="size-btn"
              >
                {{ size }}
              </button>
            </div>
            <p v-if="!selectedSize" class="size-hint">Veuillez sélectionner une taille</p>
          </div>

          <div class="quantity-section">
            <label class="selector-label">
              <span class="icon">🔢</span>
              Quantité
            </label>
            <div class="quantity-selector">
              <button @click="decrementQuantity" :disabled="quantity <= 1" class="qty-btn">
                <span>−</span>
              </button>
              <input 
                type="number" 
                v-model.number="quantity" 
                min="1" 
                :max="product.stock"
                class="qty-input"
              >
              <button @click="incrementQuantity" :disabled="quantity >= product.stock" class="qty-btn">
                <span>+</span>
              </button>
            </div>
          </div>

          <button 
            @click="addToCart" 
            :disabled="!selectedSize || product.stock === 0"
            class="btn btn-primary add-to-cart-main"
          >
            <span class="btn-icon">🛒</span>
            <span v-if="product.stock > 0">Ajouter au panier</span>
            <span v-else>Rupture de stock</span>
          </button>

          <div class="product-specs">
            <h3 class="specs-title">
              <span class="icon">ℹ️</span>
              Caractéristiques techniques
            </h3>
            
            <div class="spec-item">
              <span class="spec-label">Grammage</span>
              <span class="spec-value">190 g/m² Couleurs, 185 g/m² Blanc</span>
            </div>
            
            <div class="spec-item">
              <span class="spec-label">Composition</span>
              <span class="spec-value">100% Coton jersey pré-rétréci à fil de chaîne continue ring-spun</span>
            </div>
            
            <div class="spec-item">
              <span class="spec-label">Coupe</span>
              <span class="spec-value">Coupe droite et encolure ronde imprimée en coton/Lycra®</span>
            </div>
            
            <div class="spec-item">
              <span class="spec-label">Entretien</span>
              <span class="spec-value">Lavage machine 40° et repassage sur l'envers. Évitez le sèche-linge.</span>
            </div>
          </div>

          <div class="product-benefits">
            <div class="benefit-item">
              <span class="benefit-icon">🚚</span>
              <div>
                <strong>Livraison gratuite</strong>
                <p>Pour toute commande</p>
              </div>
            </div>
            <div class="benefit-item">
              <span class="benefit-icon">❤️</span>
              <div>
                <strong>Solidaire</strong>
                <p>Soutenez notre projet</p>
              </div>
            </div>
            <div class="benefit-item">
              <span class="benefit-icon">🌱</span>
              <div>
                <strong>Éco-responsable</strong>
                <p>Coton bio certifié</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="success-toast" :class="{ show: showSuccessToast }">
        <span class="toast-icon">✓</span>
        <span>Produit ajouté au panier !</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useCartStore } from '../stores/cart'
import { productService } from '../services/api'

const route = useRoute()
const router = useRouter()
const cartStore = useCartStore()

const product = ref(null)
const loading = ref(true)
const error = ref(null)
const selectedSize = ref('')
const quantity = ref(1)
const rotation = ref(0)
const autoRotate = ref(true)
const showSuccessToast = ref(false)
const frontImage = ref('/t-shirt/front-t-shirt-landscape-no-background.png')
const backImage = ref('/t-shirt/back-t-shirt-landscape-no-background.png')

const sizes = ['XS', 'S', 'M', 'L', 'XL']
let rotationInterval = null

const loadProduct = async () => {
  try {
    loading.value = true
    error.value = null
    const response = await productService.getProductById(route.params.id)
    product.value = response.data
    
    if (product.value.name.toLowerCase().includes('landscape')) {
      frontImage.value = '/t-shirt/front-t-shirt-landscape-no-background.png'
      backImage.value = '/t-shirt/back-t-shirt-landscape-no-background.png'
    } else if (product.value.name.toLowerCase().includes('sponsor')) {
      frontImage.value = '/t-shirt/front-t-shirt-sponsor-no-background.png'
      backImage.value = '/t-shirt/back-t-shirt-sponsor-no-background.png'
    }
  } catch (err) {
    error.value = 'Produit introuvable'
    console.error('Error loading product:', err)
  } finally {
    loading.value = false
  }
}

const stockClass = computed(() => {
  if (product.value.stock === 0) return 'out-of-stock'
  if (product.value.stock < 10) return 'low-stock'
  return 'in-stock'
})

const stockText = computed(() => {
  if (product.value.stock === 0) return 'Rupture de stock'
  if (product.value.stock < 10) return `Plus que ${product.value.stock} en stock`
  return 'En stock'
})

const formatPrice = (price) => {
  return new Intl.NumberFormat('fr-FR', {
    style: 'currency',
    currency: 'EUR'
  }).format(price)
}

const showFront = () => {
  rotation.value = 0
  stopAutoRotate()
}

const showBack = () => {
  rotation.value = 180
  stopAutoRotate()
}

const toggleAutoRotate = () => {
  autoRotate.value = !autoRotate.value
  if (autoRotate.value) {
    startAutoRotate()
  } else {
    stopAutoRotate()
  }
}

const startAutoRotate = () => {
  rotationInterval = setInterval(() => {
    rotation.value = (rotation.value + 1) % 360
  }, 30)
}

const stopAutoRotate = () => {
  autoRotate.value = false
  if (rotationInterval) {
    clearInterval(rotationInterval)
    rotationInterval = null
  }
}

const incrementQuantity = () => {
  if (quantity.value < product.value.stock) {
    quantity.value++
  }
}

const decrementQuantity = () => {
  if (quantity.value > 1) {
    quantity.value--
  }
}

const addToCart = () => {
  if (!selectedSize.value) {
    alert('Veuillez sélectionner une taille')
    return
  }
  
  const productWithSize = {
    ...product.value,
    name: `${product.value.name} - Taille ${selectedSize.value}`
  }
  
  cartStore.addToCart(productWithSize, quantity.value)
  
  showSuccessToast.value = true
  setTimeout(() => {
    showSuccessToast.value = false
  }, 3000)
}

onMounted(() => {
  loadProduct()
  document.title = 'Détails du produit - 4L des Dômes'
  startAutoRotate()
})

onUnmounted(() => {
  stopAutoRotate()
})
</script>

<style scoped>
.product-detail {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 40px 20px 80px;
}

.loading-container,
.error-container {
  text-align: center;
  padding: 100px 20px;
}

.spinner {
  width: 60px;
  height: 60px;
  border: 5px solid var(--light-color);
  border-top-color: var(--primary-color);
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 20px;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.detail-container {
  max-width: 1400px;
  margin: 0 auto;
}

.breadcrumb {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 40px;
  font-size: 14px;
}

.breadcrumb a {
  color: var(--dark-color);
  text-decoration: none;
  transition: color 0.3s ease;
}

.breadcrumb a:hover {
  color: var(--primary-color);
}

.breadcrumb .separator {
  color: #999;
}

.breadcrumb .current {
  color: var(--primary-color);
  font-weight: 600;
}

.product-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  background: white;
  border-radius: 30px;
  padding: 50px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
}

.product-viewer {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.viewer-container {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 20px;
  padding: 40px;
  box-shadow: 0 10px 40px rgba(102, 126, 234, 0.3);
}

.tshirt-3d {
  perspective: 1200px;
  height: 500px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 30px;
}

.tshirt-wrapper {
  width: 100%;
  height: 100%;
  position: relative;
  transform-style: preserve-3d;
  transition: transform 0.8s cubic-bezier(0.4, 0.0, 0.2, 1);
}

.tshirt-3d.is-rotating .tshirt-wrapper {
  transition: none;
}

.tshirt-side {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 15px;
  overflow: hidden;
  background: rgba(255, 255, 255, 0.1);
}

.tshirt-side img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  filter: drop-shadow(0 10px 30px rgba(0, 0, 0, 0.3));
  transition: transform 0.3s ease;
}

.tshirt-side:hover img {
  transform: scale(1.05);
}

.tshirt-side.back {
  transform: rotateY(180deg);
}

.viewer-controls {
  display: flex;
  gap: 15px;
  justify-content: center;
  margin-bottom: 20px;
}

.view-btn {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  border: 2px solid rgba(255, 255, 255, 0.3);
  color: white;
  padding: 12px 24px;
  border-radius: 50px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.view-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.view-btn.active {
  background: white;
  color: var(--primary-color);
  border-color: white;
}

.view-btn .icon {
  font-size: 20px;
}

.rotation-slider {
  padding: 0 10px;
}

.slider {
  width: 100%;
  height: 8px;
  border-radius: 5px;
  background: rgba(255, 255, 255, 0.2);
  outline: none;
  -webkit-appearance: none;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: white;
  cursor: pointer;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
  transition: transform 0.2s ease;
}

.slider::-webkit-slider-thumb:hover {
  transform: scale(1.2);
}

.slider::-moz-range-thumb {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: white;
  cursor: pointer;
  border: none;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.slider-labels {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
  color: rgba(255, 255, 255, 0.8);
  font-size: 12px;
  font-weight: 600;
}

.product-info {
  display: flex;
  flex-direction: column;
  gap: 25px;
}

.product-title {
  font-size: 36px;
  color: var(--dark-color);
  margin: 0;
  line-height: 1.2;
}

.product-price-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 20px;
  border-bottom: 2px solid var(--light-color);
}

.price {
  font-size: 42px;
  font-weight: 900;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.stock-info {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
  padding: 8px 16px;
  border-radius: 20px;
}

.stock-icon {
  font-size: 12px;
}

.stock-info.in-stock {
  color: var(--success-color);
  background: rgba(39, 174, 96, 0.1);
}

.stock-info.in-stock .stock-icon {
  color: var(--success-color);
}

.stock-info.low-stock {
  color: var(--secondary-color);
  background: rgba(247, 147, 30, 0.1);
}

.stock-info.low-stock .stock-icon {
  color: var(--secondary-color);
}

.stock-info.out-of-stock {
  color: #e74c3c;
  background: rgba(231, 76, 60, 0.1);
}

.stock-info.out-of-stock .stock-icon {
  color: #e74c3c;
}

.product-description {
  font-size: 16px;
  line-height: 1.8;
  color: #666;
}

.selector-label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 700;
  font-size: 18px;
  color: var(--dark-color);
  margin-bottom: 12px;
}

.selector-label .icon {
  font-size: 22px;
}

.size-selector {
  padding: 20px;
  background: var(--light-color);
  border-radius: 15px;
}

.size-options {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.size-btn {
  width: 60px;
  height: 60px;
  border: 2px solid #ddd;
  background: white;
  border-radius: 12px;
  font-size: 18px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  color: var(--dark-color);
}

.size-btn:hover {
  border-color: var(--primary-color);
  transform: translateY(-2px);
}

.size-btn.active {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  border-color: var(--primary-color);
  color: white;
  transform: scale(1.1);
}

.size-hint {
  margin-top: 10px;
  font-size: 13px;
  color: #999;
  font-style: italic;
}

.quantity-section {
  padding: 20px;
  background: var(--light-color);
  border-radius: 15px;
}

.quantity-selector {
  display: flex;
  align-items: center;
  gap: 15px;
  width: fit-content;
}

.qty-btn {
  width: 50px;
  height: 50px;
  border: 2px solid var(--primary-color);
  background: white;
  border-radius: 12px;
  cursor: pointer;
  font-size: 24px;
  font-weight: 700;
  color: var(--primary-color);
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.qty-btn:hover:not(:disabled) {
  background: var(--primary-color);
  color: white;
  transform: scale(1.1);
}

.qty-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.qty-input {
  width: 80px;
  height: 50px;
  text-align: center;
  border: 2px solid #ddd;
  border-radius: 12px;
  font-size: 20px;
  font-weight: 700;
  background: white;
}

.add-to-cart-main {
  width: 100%;
  padding: 20px;
  font-size: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin-top: 10px;
}

.add-to-cart-main:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-icon {
  font-size: 24px;
}

.product-specs {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  padding: 25px;
  border-radius: 15px;
  margin-top: 10px;
}

.specs-title {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 20px;
  margin-bottom: 20px;
  color: var(--dark-color);
}

.specs-title .icon {
  font-size: 24px;
}

.spec-item {
  display: flex;
  justify-content: space-between;
  padding: 12px 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
  gap: 20px;
}

.spec-item:last-child {
  border-bottom: none;
}

.spec-label {
  font-weight: 700;
  color: var(--dark-color);
  min-width: 120px;
}

.spec-value {
  color: #666;
  text-align: right;
  flex: 1;
}

.product-benefits {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 15px;
  margin-top: 10px;
}

.benefit-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 15px;
  background: white;
  border: 2px solid var(--light-color);
  border-radius: 12px;
  transition: all 0.3s ease;
}

.benefit-item:hover {
  border-color: var(--primary-color);
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(255, 107, 53, 0.2);
}

.benefit-icon {
  font-size: 32px;
}

.benefit-item strong {
  display: block;
  color: var(--dark-color);
  font-size: 14px;
  margin-bottom: 2px;
}

.benefit-item p {
  font-size: 12px;
  color: #999;
  margin: 0;
}

.success-toast {
  position: fixed;
  bottom: -100px;
  left: 50%;
  transform: translateX(-50%);
  background: var(--success-color);
  color: white;
  padding: 20px 40px;
  border-radius: 50px;
  display: flex;
  align-items: center;
  gap: 12px;
  font-weight: 700;
  font-size: 18px;
  box-shadow: 0 10px 40px rgba(39, 174, 96, 0.4);
  transition: bottom 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
  z-index: 10000;
}

.success-toast.show {
  bottom: 40px;
}

.toast-icon {
  width: 30px;
  height: 30px;
  background: white;
  color: var(--success-color);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: 900;
}

@media (max-width: 1024px) {
  .product-content {
    grid-template-columns: 1fr;
    padding: 35px;
    gap: 40px;
  }
  
  .product-benefits {
    grid-template-columns: repeat(3, 1fr);
  }
  
  .tshirt-3d {
    height: 450px;
  }
}

@media (max-width: 968px) {
  .product-detail {
    padding: 30px 20px 70px;
  }

  .breadcrumb {
    font-size: 13px;
    margin-bottom: 30px;
  }

  .product-content {
    padding: 30px;
    gap: 35px;
  }

  .product-title {
    font-size: 30px;
  }

  .price {
    font-size: 36px;
  }

  .tshirt-3d {
    height: 400px;
  }

  .viewer-container {
    padding: 30px;
  }

  .viewer-controls {
    flex-wrap: wrap;
  }

  .view-btn {
    flex: 1;
    min-width: 100px;
    justify-content: center;
  }

  .product-benefits {
    grid-template-columns: 1fr;
  }

  .benefit-item {
    justify-content: center;
  }

  .spec-item {
    flex-direction: column;
    gap: 8px;
  }

  .spec-label {
    min-width: auto;
  }

  .spec-value {
    text-align: left;
  }
}

@media (max-width: 768px) {
  .product-detail {
    padding: 20px 15px 60px;
  }
  
  .breadcrumb {
    font-size: 12px;
    flex-wrap: wrap;
  }

  .product-content {
    padding: 25px 20px;
    border-radius: 20px;
  }
  
  .product-title {
    font-size: 26px;
  }

  .product-price-section {
    flex-direction: column;
    align-items: flex-start;
    gap: 15px;
  }
  
  .price {
    font-size: 32px;
  }
  
  .tshirt-3d {
    height: 350px;
  }
  
  .viewer-container {
    padding: 20px;
  }

  .view-btn {
    padding: 10px 18px;
    font-size: 14px;
  }

  .view-btn .icon {
    font-size: 18px;
  }
  
  .size-btn {
    width: 50px;
    height: 50px;
    font-size: 16px;
  }

  .qty-btn {
    width: 45px;
    height: 45px;
    font-size: 20px;
  }

  .qty-input {
    width: 70px;
    height: 45px;
    font-size: 18px;
  }

  .add-to-cart-main {
    padding: 16px;
    font-size: 18px;
  }

  .selector-label {
    font-size: 16px;
  }

  .selector-label .icon {
    font-size: 20px;
  }

  .product-specs {
    padding: 20px;
  }

  .specs-title {
    font-size: 18px;
  }

  .benefit-icon {
    font-size: 28px;
  }

  .benefit-item strong {
    font-size: 13px;
  }

  .benefit-item p {
    font-size: 11px;
  }
}

@media (max-width: 480px) {
  .product-detail {
    padding: 15px 10px 50px;
  }

  .product-content {
    padding: 20px 15px;
    border-radius: 15px;
  }

  .product-title {
    font-size: 22px;
  }

  .price {
    font-size: 28px;
  }

  .tshirt-3d {
    height: 280px;
  }

  .viewer-container {
    padding: 15px;
  }

  .view-btn {
    padding: 8px 14px;
    font-size: 13px;
    gap: 6px;
  }

  .view-btn .icon {
    font-size: 16px;
  }

  .slider-labels {
    font-size: 10px;
  }

  .size-selector,
  .quantity-section {
    padding: 15px;
  }

  .size-btn {
    width: 45px;
    height: 45px;
    font-size: 15px;
  }

  .qty-btn {
    width: 40px;
    height: 40px;
    font-size: 18px;
  }

  .qty-input {
    width: 60px;
    height: 40px;
    font-size: 16px;
  }

  .add-to-cart-main {
    padding: 14px;
    font-size: 16px;
  }

  .btn-icon {
    font-size: 20px;
  }

  .product-specs {
    padding: 18px;
  }

  .specs-title {
    font-size: 16px;
  }

  .spec-item {
    font-size: 13px;
  }

  .success-toast {
    padding: 15px 30px;
    font-size: 16px;
  }

  .toast-icon {
    width: 25px;
    height: 25px;
    font-size: 18px;
  }
}
</style>
