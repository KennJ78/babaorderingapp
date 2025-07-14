const express = require('express');
const Cart = require('../models/Cart');
const router = express.Router();

// POST /api/cart/add
router.post('/add', async (req, res) => {
  try {
    const { userId, productId, name, price, quantity, image } = req.body;
    if (!userId || !productId || !name || !price || !quantity || !image) {
      return res.status(400).json({ message: 'All fields are required.' });
    }
    let cart = await Cart.findOne({ userId });
    if (!cart) {
      cart = new Cart({ userId, items: [] });
    }
    await cart.addItem({ productId, name, price, quantity, image });
    res.status(200).json({ message: 'Item added to cart.' });
  } catch (err) {
    res.status(500).json({ message: 'Server error.' });
  }
});

module.exports = router; 