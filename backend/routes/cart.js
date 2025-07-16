const express = require('express');
const Cart = require('../models/Cart');
const auth = require('../middleware/auth');
const router = express.Router();

// POST /api/cart/add - Add item to cart
router.post('/add', auth, async (req, res) => {
  try {
    const { productId, name, price, quantity, image } = req.body;
    
    // Validate required fields
    if (!productId || !name || !price || !quantity || !image) {
      return res.status(400).json({ 
        message: 'All fields are required: productId, name, price, quantity, image' 
      });
    }
    
    // Validate data types
    if (isNaN(price) || isNaN(quantity)) {
      return res.status(400).json({ 
        message: 'Price and quantity must be numbers' 
      });
    }
    
    const userId = req.user.userId;
    
    // Find existing cart or create new one
    let cart = await Cart.findOne({ userId });
    if (!cart) {
      cart = new Cart({ userId, items: [] });
    }
    
    // Check if item already exists
    const existingItem = cart.items.find(item => item.productId === productId);
    
    if (existingItem) {
      // Update quantity if item exists
      existingItem.quantity += parseInt(quantity);
    } else {
      // Add new item
      cart.items.push({
        productId,
        name,
        price: parseFloat(price),
        quantity: parseInt(quantity),
        image
      });
    }
    
    // Save cart
    await cart.save();
    
    res.status(200).json({ 
      message: 'Item added to cart successfully',
      cartId: cart._id,
      itemCount: cart.items.length
    });
    
  } catch (error) {
    console.error('Add to cart error:', error);
    res.status(500).json({ 
      message: 'Server error while adding item to cart',
      error: error.message 
    });
  }
});

// GET /api/cart - Get user's cart items
router.get('/', auth, async (req, res) => {
  try {
    const userId = req.user.userId;
    
    const cart = await Cart.findOne({ userId });
    
    if (!cart || cart.items.length === 0) {
      return res.json({ 
        items: [],
        totalAmount: 0,
        itemCount: 0
      });
    }
    
    // Calculate totals
    const totalAmount = cart.items.reduce((total, item) => {
      return total + (item.price * item.quantity);
    }, 0);
    
    const itemCount = cart.items.reduce((count, item) => {
      return count + item.quantity;
    }, 0);
    
    res.json({
      items: cart.items,
      totalAmount: totalAmount,
      itemCount: itemCount
    });
    
  } catch (error) {
    console.error('Get cart error:', error);
    res.status(500).json({ 
      message: 'Server error while getting cart',
      error: error.message 
    });
  }
});

// DELETE /api/cart/remove/:productId - Remove item from cart
router.delete('/remove/:productId', auth, async (req, res) => {
  try {
    const userId = req.user.userId;
    const { productId } = req.params;
    
    const cart = await Cart.findOne({ userId });
    
    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }
    
    // Remove item
    cart.items = cart.items.filter(item => item.productId !== productId);
    await cart.save();
    
    res.json({ 
      message: 'Item removed from cart',
      itemCount: cart.items.length
    });
    
  } catch (error) {
    console.error('Remove from cart error:', error);
    res.status(500).json({ 
      message: 'Server error while removing item',
      error: error.message 
    });
  }
});


module.exports = router; 