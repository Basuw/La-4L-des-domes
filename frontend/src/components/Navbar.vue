<template>
  <nav class="navbar">
    <div class="container">
      <div class="nav-content">
        <router-link to="/" class="logo">
          <img src="/logo.png" alt="4L des Dômes" class="logo-img">
          <span class="logo-text">4L des Dômes</span>
        </router-link>
        
        <div class="nav-links" :class="{ active: mobileMenuOpen }">
          <router-link to="/" @click="closeMobileMenu">Accueil</router-link>
          <router-link to="/boutique" @click="closeMobileMenu">Boutique</router-link>
          <router-link to="/panier" class="cart-link" @click="closeMobileMenu">
            <span>🛒</span>
            Panier
            <span v-if="cartItemCount > 0" class="cart-badge">{{ cartItemCount }}</span>
          </router-link>
        </div>
        
        <button class="mobile-menu-btn" @click="toggleMobileMenu">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useCartStore } from '../stores/cart'

const cartStore = useCartStore()
const mobileMenuOpen = ref(false)

const cartItemCount = computed(() => cartStore.itemCount)

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const closeMobileMenu = () => {
  mobileMenuOpen.value = false
}
</script>

<style scoped>
.navbar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  padding: 15px 0;
}

.nav-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  gap: 15px;
  text-decoration: none;
  transition: transform 0.3s ease;
}

.logo:hover {
  transform: scale(1.05);
}

.logo-img {
  height: 50px;
  width: 50px;
  object-fit: contain;
}

.logo-text {
  font-size: 24px;
  font-weight: 700;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.nav-links {
  display: flex;
  gap: 40px;
  align-items: center;
}

.nav-links a {
  text-decoration: none;
  color: var(--dark-color);
  font-weight: 600;
  font-size: 18px;
  position: relative;
  transition: color 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
}

.nav-links a:hover {
  color: var(--primary-color);
}

.nav-links a.router-link-active {
  color: var(--primary-color);
}

.nav-links a::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  width: 0;
  height: 3px;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  transition: width 0.3s ease;
}

.nav-links a:hover::after,
.nav-links a.router-link-active::after {
  width: 100%;
}

.cart-badge {
  background: var(--primary-color);
  color: white;
  border-radius: 50%;
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: 700;
}

.cart-link {
  padding: 10px 20px;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  color: white !important;
  border-radius: 50px;
  transition: all 0.3s ease;
}

.cart-link:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.cart-link::after {
  display: none;
}

.mobile-menu-btn {
  display: none;
  flex-direction: column;
  gap: 5px;
  background: none;
  border: none;
  cursor: pointer;
}

.mobile-menu-btn span {
  width: 25px;
  height: 3px;
  background: var(--dark-color);
  transition: all 0.3s ease;
}

@media (max-width: 768px) {
  .mobile-menu-btn {
    display: flex;
  }
  
  .nav-links {
    position: absolute;
    top: 80px;
    left: 0;
    right: 0;
    background: white;
    flex-direction: column;
    padding: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transform: translateY(-100%);
    opacity: 0;
    pointer-events: none;
    transition: all 0.3s ease;
  }
  
  .nav-links.active {
    transform: translateY(0);
    opacity: 1;
    pointer-events: all;
  }
}
</style>
