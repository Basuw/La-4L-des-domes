<template>
  <div class="cart-page">
    <section class="cart-hero">
      <div class="container">
        <h1 class="animate__animated animate__fadeInDown">Mon Panier</h1>
        <p class="cart-subtitle">Finalisez votre commande</p>
      </div>
    </section>

    <section class="cart-content-section">
      <div class="container">
        <div v-if="cartStore.items.length === 0" class="empty-cart">
          <div class="empty-icon">🛒</div>
          <h2>Votre panier est vide</h2>
          <p>Découvrez nos t-shirts exclusifs et soutenez notre projet !</p>
          <router-link to="/boutique" class="btn btn-primary">
            Retour à la boutique
          </router-link>
        </div>

        <div v-else class="cart-content">
          <div class="cart-items">
            <h2 class="section-title" data-aos="fade-up">Articles ({{ cartStore.items.length }})</h2>
            
            <div 
              v-for="item in cartStore.items" 
              :key="item.product.id" 
              class="cart-item"
              data-aos="fade-right"
            >
              <img :src="item.product.imageUrl || '/images/tshirt-placeholder.jpg'" :alt="item.product.name">
              <div class="cart-item-info">
                <h4>{{ item.product.name }}</h4>
                <p class="item-size">Taille: {{ item.size }}</p>
                <p class="item-price-mobile">{{ formatPrice(item.product.price) }}</p>
                
                <div class="quantity-controls">
                  <button @click="decrementQuantity(item)" class="qty-btn">-</button>
                  <span class="quantity">{{ item.quantity }}</span>
                  <button @click="incrementQuantity(item)" class="qty-btn">+</button>
                </div>
              </div>
              <div class="cart-item-price">
                <div class="unit-price">{{ formatPrice(item.product.price) }} × {{ item.quantity }}</div>
                <div class="total-price">{{ formatPrice(item.product.price * item.quantity) }}</div>
              </div>
              <button @click="removeFromCart(item.product.id, item.size)" class="remove-btn" title="Supprimer">✕</button>
            </div>
          </div>
          
          <div class="cart-summary" data-aos="fade-left">
            <h3>Récapitulatif de la commande</h3>
            
            <div class="summary-details">
              <div class="summary-line">
                <span>Sous-total</span>
                <span>{{ formatPrice(cartStore.totalAmount) }}</span>
              </div>
              <div class="summary-line">
                <span>Livraison</span>
                <span class="free">Gratuite</span>
              </div>
              <div class="summary-line total">
                <span>Total</span>
                <span>{{ formatPrice(cartStore.totalAmount) }}</span>
              </div>
            </div>
            
            <button @click="showCheckoutForm = true" class="btn btn-primary btn-block">
              Procéder au paiement
            </button>

            <div class="secure-payment">
              <span class="secure-icon">🔒</span>
              <span>Paiement sécurisé</span>
            </div>

            <router-link to="/boutique" class="continue-shopping">
              ← Continuer mes achats
            </router-link>
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
import { useRouter } from 'vue-router'
import { useCartStore } from '../stores/cart'
import { orderService } from '../services/api'

const router = useRouter()
const cartStore = useCartStore()
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

const incrementQuantity = (item) => {
  cartStore.updateQuantity(item.product.id, item.size, item.quantity + 1)
}

const decrementQuantity = (item) => {
  if (item.quantity > 1) {
    cartStore.updateQuantity(item.product.id, item.size, item.quantity - 1)
  }
}

const removeFromCart = (productId, size) => {
  cartStore.removeFromCart(productId, size)
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
  router.push('/boutique')
}

onMounted(() => {
  document.title = 'Mon Panier - 4L des Dômes'
})
</script>

<style scoped>
.cart-page {
  min-height: 100vh;
  background: #f8f9fa;
}

.cart-hero {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9));
  padding: 80px 20px 60px;
  color: white;
  text-align: center;
}

.cart-hero h1 {
  font-size: 56px;
  color: white;
  margin-bottom: 15px;
}

.cart-subtitle {
  font-size: 20px;
  opacity: 0.9;
}

.cart-content-section {
  padding: 80px 20px;
}

.empty-cart {
  text-align: center;
  padding: 80px 20px;
  background: white;
  border-radius: 20px;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
}

.empty-icon {
  font-size: 100px;
  margin-bottom: 30px;
  opacity: 0.3;
}

.empty-cart h2 {
  font-size: 32px;
  color: var(--dark-color);
  margin-bottom: 15px;
}

.empty-cart p {
  font-size: 18px;
  color: #666;
  margin-bottom: 30px;
}

.cart-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 40px;
}

.cart-items {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.section-title {
  font-size: 28px;
  color: var(--dark-color);
  margin-bottom: 20px;
}

.cart-item {
  background: white;
  padding: 25px;
  border-radius: 15px;
  display: grid;
  grid-template-columns: 120px 1fr auto 40px;
  gap: 25px;
  align-items: center;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}

.cart-item:hover {
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.cart-item img {
  width: 120px;
  height: 120px;
  object-fit: contain;
  border-radius: 10px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 10px;
}

.cart-item-info {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.cart-item-info h4 {
  font-size: 20px;
  color: var(--dark-color);
  margin: 0;
}

.item-size {
  color: #666;
  font-size: 14px;
  font-weight: 600;
  margin: 0;
}

.item-price-mobile {
  display: none;
  color: var(--primary-color);
  font-weight: 700;
  font-size: 18px;
  margin: 0;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 15px;
  background: var(--light-color);
  border-radius: 50px;
  padding: 8px 15px;
  width: fit-content;
}

.qty-btn {
  width: 32px;
  height: 32px;
  border: none;
  background: white;
  border-radius: 50%;
  cursor: pointer;
  font-size: 18px;
  font-weight: 700;
  color: var(--primary-color);
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.qty-btn:hover {
  background: var(--primary-color);
  color: white;
  transform: scale(1.1);
}

.quantity {
  font-size: 18px;
  font-weight: 700;
  color: var(--dark-color);
  min-width: 30px;
  text-align: center;
}

.cart-item-price {
  text-align: right;
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.unit-price {
  font-size: 14px;
  color: #666;
}

.total-price {
  font-size: 24px;
  font-weight: 900;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.remove-btn {
  width: 40px;
  height: 40px;
  border: none;
  background: #e74c3c;
  color: white;
  border-radius: 50%;
  cursor: pointer;
  font-size: 20px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.remove-btn:hover {
  background: #c0392b;
  transform: rotate(90deg) scale(1.1);
}

.cart-summary {
  background: white;
  padding: 30px;
  border-radius: 15px;
  height: fit-content;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 100px;
}

.cart-summary h3 {
  margin-bottom: 25px;
  color: var(--dark-color);
  font-size: 24px;
}

.summary-details {
  border-top: 2px solid var(--light-color);
  border-bottom: 2px solid var(--light-color);
  padding: 20px 0;
  margin-bottom: 25px;
}

.summary-line {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
  font-size: 16px;
}

.summary-line:last-child {
  margin-bottom: 0;
}

.summary-line .free {
  color: var(--success-color);
  font-weight: 700;
}

.summary-line.total {
  font-size: 28px;
  font-weight: 900;
  color: var(--primary-color);
  margin-top: 15px;
  padding-top: 15px;
  border-top: 2px solid var(--light-color);
}

.btn-block {
  width: 100%;
  padding: 16px;
  font-size: 18px;
  font-weight: 700;
}

.secure-payment {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-top: 20px;
  color: #666;
  font-size: 14px;
}

.secure-icon {
  font-size: 16px;
}

.continue-shopping {
  display: block;
  text-align: center;
  margin-top: 20px;
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
}

.continue-shopping:hover {
  color: var(--secondary-color);
  transform: translateX(-5px);
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

  .cart-summary {
    position: static;
  }

  .cart-item {
    grid-template-columns: 80px 1fr 30px;
    gap: 15px;
    padding: 20px;
  }

  .cart-item img {
    width: 80px;
    height: 80px;
  }

  .cart-item-price {
    display: none;
  }

  .item-price-mobile {
    display: block;
  }

  .remove-btn {
    width: 35px;
    height: 35px;
    font-size: 16px;
  }

  .cart-hero h1 {
    font-size: 40px;
  }
}
</style>
