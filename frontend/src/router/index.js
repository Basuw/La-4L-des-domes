import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Shop from '../views/Shop.vue'
import ProductDetail from '../views/ProductDetail.vue'
import Cart from '../views/Cart.vue'
import LegalNotice from '../views/LegalNotice.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/boutique',
    name: 'Shop',
    component: Shop
  },
  {
    path: '/produit/:id',
    name: 'ProductDetail',
    component: ProductDetail
  },
  {
    path: '/panier',
    name: 'Cart',
    component: Cart
  },
  {
    path: '/mentions-legales',
    name: 'LegalNotice',
    component: LegalNotice
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
