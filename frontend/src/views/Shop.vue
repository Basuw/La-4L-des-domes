<template>
  <div class="shop">
    <section class="shop-hero">
      <div class="container">
        <h1 class="animate__animated animate__fadeInDown">Boutique</h1>
        <p class="shop-subtitle">Soutenez notre projet en achetant nos t-shirts exclusifs</p>
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
                <img :src="product.imageUrl || '/images/tshirt-placeholder.jpg'" :alt="product.name">
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
              
              <div class="product-details">
                <span class="product-size">Taille: {{ product.size }}</span>
                <span class="product-price">{{ formatPrice(product.price) }}</span>
              </div>
              
              <div class="product-actions">
                <router-link :to="`/produit/${product.id}`" class="btn btn-secondary view-details-btn">
                  Voir les détails
                </router-link>
                
                <button 
                  @click="addToCart(product)" 
                  :disabled="product.stock === 0"
                  class="btn btn-primary add-to-cart-btn"
                >
                  <span v-if="product.stock > 0">Panier</span>
                  <span v-else>Indisponible</span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section v-if="cartStore.items.length > 0" class="cart-section">
      <div class="container">
        <h2 class="section-title" data-aos="fade-up">Votre Panier</h2>
        
        <div class="cart-content">
          <div class="cart-items">
            <div 
              v-for="item in cartStore.items" 
              :key="item.product.id" 
              class="cart-item"
              data-aos="fade-right"
            >
              <img :src="item.product.imageUrl || '/images/tshirt-placeholder.jpg'" :alt="item.product.name">
              <div class="cart-item-info">
                <h4>{{ item.product.name }}</h4>
                <p>Taille: {{ item.product.size }}</p>
                <p>Quantité: {{ item.quantity }}</p>
              </div>
              <div class="cart-item-price">
                {{ formatPrice(item.product.price * item.quantity) }}
              </div>
              <button @click="removeFromCart(item.product.id)" class="remove-btn">✕</button>
            </div>
          </div>
          
          <div class="cart-summary" data-aos="fade-left">
            <h3>Récapitulatif</h3>
            <div class="summary-line">
              <span>Sous-total</span>
              <span>{{ formatPrice(cartStore.totalAmount) }}</span>
            </div>
            <div class="summary-line">
              <span>Livraison</span>
              <span>Gratuite</span>
            </div>
            <div class="summary-line total">
              <span>Total</span>
              <span>{{ formatPrice(cartStore.totalAmount) }}</span>
            </div>
            
            <button @click="showCheckoutForm = true" class="btn btn-primary btn-block">
              Procéder au paiement
            </button>
          </div>
        </div>
      </div>
    </section>

    <div v-if="showCheckoutForm" class="modal" @click.self="showCheckoutForm = false">
      <div class="modal-content" data-aos="zoom-in">
        <button @click="showCheckoutForm = false" class="modal-close">✕</button>
        
        <h2>Finaliser votre commande</h2>
        
        <form @submit.prevent="submitOrder" class="checkout-form">
          <div class="form-group">
            <label>Nom complet *</label>
            <input v-model="orderForm.customerName" type="text" required>
          </div>
          
          <div class="form-group">
            <label>Email *</label>
            <input v-model="orderForm.customerEmail" type="email" required>
          </div>
          
          <div class="form-group">
            <label>Téléphone *</label>
            <input v-model="orderForm.customerPhone" type="tel" required>
          </div>
          
          <div class="form-group">
            <label>Adresse de livraison *</label>
            <textarea v-model="orderForm.shippingAddress" rows="3" required></textarea>
          </div>
          
          <div class="form-actions">
            <button type="button" @click="showCheckoutForm = false" class="btn btn-secondary">
              Annuler
            </button>
            <button type="submit" :disabled="submitting" class="btn btn-primary">
              <span v-if="!submitting">Confirmer la commande</span>
              <span v-else>Envoi en cours...</span>
            </button>
          </div>
        </form>
      </div>
    </div>

    <div v-if="orderSuccess" class="modal" @click.self="orderSuccess = false">
      <div class="modal-content success-modal" data-aos="zoom-in">
        <div class="success-icon">✓</div>
        <h2>Commande confirmée !</h2>
        <p>Merci pour votre soutien ! Vous recevrez un email de confirmation à {{ orderForm.customerEmail }}</p>
        <p class="order-number">Numéro de commande: #{{ lastOrderId }}</p>
        <button @click="closeSuccessModal" class="btn btn-primary">Fermer</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useCartStore } from '../stores/cart'
import { productService, orderService } from '../services/api'

const cartStore = useCartStore()
const products = ref([])
const loading = ref(true)
const error = ref(null)
const quantities = reactive({})
const showCheckoutForm = ref(false)
const submitting = ref(false)
const orderSuccess = ref(false)
const lastOrderId = ref(null)

const orderForm = reactive({
  customerName: '',
  customerEmail: '',
  customerPhone: '',
  shippingAddress: ''
})

const loadProducts = async () => {
  try {
    loading.value = true
    error.value = null
    const response = await productService.getAvailableProducts()
    products.value = response.data
    
    products.value.forEach(product => {
      quantities[product.id] = 1
    })
  } catch (err) {
    error.value = 'Erreur lors du chargement des produits. Veuillez réessayer.'
    console.error('Error loading products:', err)
  } finally {
    loading.value = false
  }
}

const getQuantity = (productId) => {
  return quantities[productId] || 1
}

const incrementQuantity = (productId) => {
  quantities[productId] = (quantities[productId] || 1) + 1
}

const decrementQuantity = (productId) => {
  if (quantities[productId] > 1) {
    quantities[productId]--
  }
}

const updateQuantityInput = (productId, event) => {
  const value = parseInt(event.target.value)
  if (value > 0) {
    quantities[productId] = value
  }
}

const addToCart = (product) => {
  const quantity = quantities[product.id] || 1
  cartStore.addToCart(product, quantity)
  
  const card = event.target.closest('.product-card')
  card.classList.add('added-to-cart')
  setTimeout(() => card.classList.remove('added-to-cart'), 500)
}

const removeFromCart = (productId) => {
  cartStore.removeFromCart(productId)
}

const formatPrice = (price) => {
  return new Intl.NumberFormat('fr-FR', {
    style: 'currency',
    currency: 'EUR'
  }).format(price)
}

const submitOrder = async () => {
  try {
    submitting.value = true
    
    const orderData = {
      customerName: orderForm.customerName,
      customerEmail: orderForm.customerEmail,
      customerPhone: orderForm.customerPhone,
      shippingAddress: orderForm.shippingAddress,
      items: cartStore.items.map(item => ({
        productId: item.product.id,
        quantity: item.quantity
      }))
    }
    
    const response = await orderService.createOrder(orderData)
    lastOrderId.value = response.data.id
    
    cartStore.clearCart()
    showCheckoutForm.value = false
    orderSuccess.value = true
    
    orderForm.customerName = ''
    orderForm.customerEmail = ''
    orderForm.customerPhone = ''
    orderForm.shippingAddress = ''
  } catch (err) {
    alert('Erreur lors de la commande. Veuillez réessayer.')
    console.error('Error submitting order:', err)
  } finally {
    submitting.value = false
  }
}

const closeSuccessModal = () => {
  orderSuccess.value = false
  loadProducts()
}

onMounted(() => {
  loadProducts()
  document.title = 'Boutique - 4L des Dômes'
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
  object-fit: cover;
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
  margin-bottom: 20px;
  font-size: 14px;
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

.cart-section {
  padding: 80px 20px;
  background: #f8f9fa;
}

.cart-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 40px;
  margin-top: 40px;
}

.cart-items {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.cart-item {
  background: white;
  padding: 20px;
  border-radius: 15px;
  display: flex;
  gap: 20px;
  align-items: center;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.cart-item img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 10px;
}

.cart-item-info {
  flex: 1;
}

.cart-item-info h4 {
  margin-bottom: 5px;
  color: var(--dark-color);
}

.cart-item-info p {
  color: #666;
  font-size: 14px;
  margin: 2px 0;
}

.cart-item-price {
  font-size: 22px;
  font-weight: 700;
  color: var(--primary-color);
}

.remove-btn {
  width: 35px;
  height: 35px;
  border: none;
  background: #e74c3c;
  color: white;
  border-radius: 50%;
  cursor: pointer;
  font-size: 18px;
  transition: all 0.3s ease;
}

.remove-btn:hover {
  background: #c0392b;
  transform: rotate(90deg);
}

.cart-summary {
  background: white;
  padding: 30px;
  border-radius: 15px;
  height: fit-content;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
}

.cart-summary h3 {
  margin-bottom: 25px;
  color: var(--dark-color);
}

.summary-line {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
  padding-bottom: 15px;
  border-bottom: 1px solid var(--light-color);
}

.summary-line.total {
  font-size: 24px;
  font-weight: 700;
  border-bottom: none;
  margin-top: 10px;
  color: var(--primary-color);
}

.btn-block {
  width: 100%;
  margin-top: 20px;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
  padding: 20px;
}

.modal-content {
  background: white;
  padding: 40px;
  border-radius: 20px;
  max-width: 600px;
  width: 100%;
  position: relative;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-close {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 40px;
  height: 40px;
  border: none;
  background: var(--light-color);
  border-radius: 50%;
  font-size: 24px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.modal-close:hover {
  background: var(--primary-color);
  color: white;
  transform: rotate(90deg);
}

.modal-content h2 {
  margin-bottom: 30px;
  color: var(--dark-color);
}

.checkout-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-weight: 600;
  color: var(--dark-color);
}

.form-group input,
.form-group textarea {
  padding: 12px 16px;
  border: 2px solid var(--light-color);
  border-radius: 10px;
  font-size: 16px;
  transition: border-color 0.3s ease;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: var(--primary-color);
}

.form-actions {
  display: flex;
  gap: 15px;
  margin-top: 10px;
}

.form-actions button {
  flex: 1;
}

.success-modal {
  text-align: center;
}

.success-icon {
  width: 80px;
  height: 80px;
  background: var(--success-color);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 48px;
  margin: 0 auto 20px;
  animation: successPop 0.5s ease;
}

@keyframes successPop {
  0% { transform: scale(0); }
  50% { transform: scale(1.1); }
  100% { transform: scale(1); }
}

.order-number {
  background: var(--light-color);
  padding: 15px;
  border-radius: 10px;
  margin: 20px 0;
  font-weight: 600;
}

@media (max-width: 968px) {
  .cart-content {
    grid-template-columns: 1fr;
  }
  
  .products-grid {
    grid-template-columns: 1fr;
  }
}
</style>
