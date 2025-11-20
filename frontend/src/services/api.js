import axios from 'axios'

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8001/api',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
})

export const productService = {
  getAllProducts: () => api.get('/products'),
  getAvailableProducts: () => api.get('/products/available'),
  getProductById: (id) => api.get(`/products/${id}`)
}

export const orderService = {
  createOrder: (orderData) => api.post('/orders', orderData),
  getOrderById: (id) => api.get(`/orders/${id}`)
}

export default api
