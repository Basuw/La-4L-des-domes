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
              v-for="(item, index) in cartStore.items" 
              :key="`${item.product.id}-${item.color.name}-${item.size}`" 
              class="cart-item"
              data-aos="fade-right"
            >
              <img :src="item.color.frontImage" :alt="item.product.name">
              <div class="cart-item-info">
                <h4>{{ item.product.name }}</h4>
                <div class="item-details">
                  <div class="color-info">
                    <span class="color-circle" :style="{ backgroundColor: item.color.hex }"></span>
                    <span>{{ item.color.label }}</span>
                  </div>
                  <div class="size-info">
                    <span>Taille: {{ item.size }}</span>
                  </div>
                </div>
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
              <button @click="removeFromCart(index)" class="remove-btn" title="Supprimer">✕</button>
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
            <button type="submit" :disabled="submitting" class="btn btn-primary">
              <span v-if="!submitting">Valider les informations</span>
              <span v-else>Vérification...</span>
            </button>
            <button type="button" @click="showCheckoutForm = false" class="btn btn-secondary">
              Annuler
            </button>
          </div>
        </form>
      </div>
    </div>

    <div v-if="showPaymentRedirect" class="modal">
      <div class="modal-content success-modal" data-aos="zoom-in">
        <div class="success-icon">💳</div>
        <h2>Récapitulatif de votre commande</h2>
        <div class="order-summary-details">
          <p><strong>Nom :</strong> {{ orderForm.customerName }}</p>
          <p><strong>Email :</strong> {{ orderForm.customerEmail }}</p>
          <p><strong>Téléphone :</strong> {{ orderForm.customerPhone }}</p>
          <p><strong>Adresse :</strong> {{ orderForm.shippingAddress }}</p>
          <p><strong>Montant total :</strong> {{ formatPrice(cartStore.totalAmount) }}</p>
        </div>
        <div class="delivery-info">
          <p><strong>📦 Informations de livraison :</strong></p>
          <p>Les commandes partiront en production début janvier.</p>
          <p>La livraison est prévue pour <strong>fin janvier / début février</strong>.</p>
          <p>Vous serez tenu au courant par email de l'avancement de votre commande.</p>
        </div>
        <p class="payment-info">En cliquant sur "Procéder au paiement", vous serez redirigé vers HelloAsso pour procéder au paiement et votre commande sera enregistrée.</p>
        <p class="payment-warning">Merci de choisir un montant <strong>supérieur ou égal à {{ formatPrice(cartStore.totalAmount) }}</strong></p>
        <div class="modal-actions">
          <button @click="showPaymentRedirect = false; showCheckoutForm = true" class="btn btn-secondary">Modifier</button>
          <button @click="confirmAndRedirectToPayment" :disabled="submitting" class="btn btn-primary">
            <span v-if="!submitting">Procéder au paiement</span>
            <span v-else>Enregistrement...</span>
          </button>
        </div>
      </div>
    </div>

    <div v-if="orderSuccess" class="modal">
      <div class="modal-content success-modal" data-aos="zoom-in">
        <div class="success-icon">✓</div>
        <h2>Commande bien prise en compte !</h2>
        <p>Merci pour votre soutien ! Vous recevrez un email de confirmation.</p>
        <div class="delivery-info">
          <p><strong>📦 Informations de livraison :</strong></p>
          <p>Les commandes partiront en production début janvier.</p>
          <p>La livraison est prévue pour <strong>fin janvier / début février</strong>.</p>
          <p>Vous serez tenu au courant par email de l'avancement de votre commande.</p>
        </div>
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
const showPaymentRedirect = ref(false)
const lastOrderId = ref(null)

const orderForm = reactive({
  customerName: '',
  customerEmail: '',
  customerPhone: '',
  shippingAddress: ''
})

const incrementQuantity = (item) => {
  const index = cartStore.items.indexOf(item)
  cartStore.updateQuantity(index, item.quantity + 1)
}

const decrementQuantity = (item) => {
  if (item.quantity > 1) {
    const index = cartStore.items.indexOf(item)
    cartStore.updateQuantity(index, item.quantity - 1)
  }
}

const removeFromCart = (index) => {
  cartStore.removeFromCart(index)
}

const formatPrice = (price) => {
  return new Intl.NumberFormat('fr-FR', {
    style: 'currency',
    currency: 'EUR'
  }).format(price)
}

const submitOrder = async () => {
  // Validation simple du formulaire
  submitting.value = true
  
  // Simuler une petite vérification
  await new Promise(resolve => setTimeout(resolve, 300))
  
  submitting.value = false
  showCheckoutForm.value = false
  showPaymentRedirect.value = true
}

const confirmAndRedirectToPayment = async () => {
  try {
    submitting.value = true
    
    const orderData = {
      customerName: orderForm.customerName,
      customerEmail: orderForm.customerEmail,
      customerPhone: orderForm.customerPhone,
      shippingAddress: orderForm.shippingAddress,
      items: cartStore.items.map(item => ({
        productId: item.product.id,
        quantity: item.quantity,
        size: item.size,
        color: item.color.name
      }))
    }
    
    const response = await orderService.createOrder(orderData)
    lastOrderId.value = response.data.id
    
    const helloAssoUrl = 'https://www.helloasso.com/associations/la-4l-des-domes/formulaires/1'
    
    // Tenter d'ouvrir dans un nouvel onglet
    const newWindow = window.open(helloAssoUrl, '_blank')
    
    // Si le navigateur bloque l'ouverture (ex: Instagram), rediriger directement
    if (!newWindow || newWindow.closed || typeof newWindow.closed === 'undefined') {
      // Afficher d'abord le modal de succès
      showPaymentRedirect.value = false
      orderSuccess.value = true
      
      // Attendre 1 seconde pour que l'utilisateur voie le modal
      setTimeout(() => {
        window.location.href = helloAssoUrl
      }, 1000)
    } else {
      // L'ouverture a réussi, afficher le modal normalement
      showPaymentRedirect.value = false
      orderSuccess.value = true
    }
  } catch (err) {
    alert('Erreur lors de l\'enregistrement de la commande. Veuillez réessayer.')
    console.error('Error submitting order:', err)
    showPaymentRedirect.value = false
    showCheckoutForm.value = true
  } finally {
    submitting.value = false
  }
}

const closeSuccessModal = () => {
  orderSuccess.value = false
  cartStore.clearCart()
  orderForm.customerName = ''
  orderForm.customerEmail = ''
  orderForm.customerPhone = ''
  orderForm.shippingAddress = ''
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

.item-details {
  display: flex;
  gap: 20px;
  margin: 5px 0;
}

.color-info,
.size-info {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #666;
  font-weight: 600;
}

.color-circle {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border: 2px solid #ddd;
  display: inline-block;
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

.payment-info {
  font-size: 16px;
  color: #666;
  margin: 15px 0 10px;
}

.payment-warning {
  background: #fff3cd;
  border: 2px solid #ffc107;
  padding: 15px;
  border-radius: 10px;
  margin: 15px 0 25px;
  font-size: 15px;
  color: #856404;
}

.payment-warning strong {
  color: var(--primary-color);
  font-size: 18px;
}

.delivery-info {
  background: #e3f2fd;
  border-left: 4px solid #2196F3;
  padding: 15px;
  border-radius: 8px;
  margin: 20px 0;
  text-align: left;
}

.delivery-info p {
  margin: 8px 0;
  font-size: 14px;
  color: #333;
}

.delivery-info p:first-child {
  font-size: 16px;
  margin-bottom: 12px;
}

.order-summary-details {
  text-align: left;
  background: var(--light-color);
  padding: 20px;
  border-radius: 10px;
  margin: 20px 0;
}

.order-summary-details p {
  margin: 10px 0;
  font-size: 16px;
  color: var(--dark-color);
}

.order-summary-details strong {
  display: inline-block;
  min-width: 120px;
  color: #666;
}

.modal-actions {
  display: flex;
  gap: 15px;
  justify-content: center;
  margin-top: 20px;
}

.modal-actions button {
  flex: 1;
  max-width: 200px;
}

@media (max-width: 968px) {
  .cart-hero {
    padding: 60px 20px 40px;
  }

  .cart-hero h1 {
    font-size: 42px;
  }

  .cart-subtitle {
    font-size: 18px;
  }

  .cart-content-section {
    padding: 60px 20px;
  }

  .cart-content {
    grid-template-columns: 1fr;
    gap: 30px;
  }

  .cart-summary {
    position: static;
  }

  .section-title {
    font-size: 24px;
  }

  .cart-item {
    grid-template-columns: 100px 1fr 35px;
    gap: 20px;
    padding: 20px;
  }

  .cart-item img {
    width: 100px;
    height: 100px;
  }

  .cart-item-info h4 {
    font-size: 18px;
  }

  .quantity-controls {
    gap: 12px;
    padding: 6px 12px;
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
    font-size: 18px;
  }

  .modal-content {
    padding: 30px;
    max-width: 90%;
  }

  .form-actions {
    flex-direction: column;
  }

  .form-actions button {
    width: 100%;
  }
}

@media (max-width: 768px) {
  .cart-hero h1 {
    font-size: 36px;
  }

  .cart-item {
    grid-template-columns: 80px 1fr 30px;
    gap: 15px;
    padding: 18px;
  }

  .cart-item img {
    width: 80px;
    height: 80px;
  }

  .cart-item-info h4 {
    font-size: 16px;
  }

  .quantity-controls {
    gap: 10px;
  }

  .qty-btn {
    width: 28px;
    height: 28px;
    font-size: 16px;
  }

  .remove-btn {
    width: 30px;
    height: 30px;
    font-size: 16px;
  }

  .cart-summary h3 {
    font-size: 20px;
  }

  .summary-line {
    font-size: 14px;
  }

  .summary-line.total {
    font-size: 24px;
  }

  .btn-block {
    padding: 14px;
    font-size: 16px;
  }
}

@media (max-width: 480px) {
  .cart-hero {
    padding: 40px 15px 30px;
  }

  .cart-hero h1 {
    font-size: 32px;
  }

  .cart-subtitle {
    font-size: 16px;
  }

  .cart-content-section {
    padding: 40px 15px;
  }

  .cart-item {
    grid-template-columns: 70px 1fr 28px;
    gap: 12px;
    padding: 15px;
  }

  .cart-item img {
    width: 70px;
    height: 70px;
  }

  .cart-item-info h4 {
    font-size: 15px;
  }

  .item-size,
  .item-price-mobile {
    font-size: 13px;
  }

  .modal-content {
    padding: 25px 20px;
  }

  .modal-content h2 {
    font-size: 22px;
  }

  .success-icon {
    width: 60px;
    height: 60px;
    font-size: 36px;
  }
}
</style>
