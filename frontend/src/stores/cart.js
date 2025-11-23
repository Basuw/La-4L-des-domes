import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useCartStore = defineStore('cart', () => {
  const items = ref([])

  const addToCart = (product, color, size, quantity = 1) => {
    const existingItem = items.value.find(item => 
      item.product.id === product.id && 
      item.color.name === color.name && 
      item.size === size
    )
    
    if (existingItem) {
      existingItem.quantity += quantity
    } else {
      items.value.push({ product, color, size, quantity })
    }
  }

  const removeFromCart = (index) => {
    items.value.splice(index, 1)
  }

  const updateQuantity = (index, quantity) => {
    if (items.value[index] && quantity > 0) {
      items.value[index].quantity = quantity
    }
  }

  const clearCart = () => {
    items.value = []
  }

  const totalAmount = computed(() => {
    return items.value.reduce((total, item) => {
      return total + (item.product.price * item.quantity)
    }, 0)
  })

  const itemCount = computed(() => {
    return items.value.reduce((count, item) => count + item.quantity, 0)
  })

  return {
    items,
    addToCart,
    removeFromCart,
    updateQuantity,
    clearCart,
    totalAmount,
    itemCount
  }
})
