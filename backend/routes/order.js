const express = require('express');
const Order = require('../models/Order');
const Cart = require('../models/Cart');
const auth = require('../middleware/auth');
const router = express.Router();

// POST /api/orders/checkout - Create order from cart and clear cart
router.post('/checkout', auth, async (req, res) => {
  try {
    const userId = req.user.userId;
    // Find user's cart
    const cart = await Cart.findOne({ userId });
    if (!cart || cart.items.length === 0) {
      return res.status(400).json({ message: 'Cart is empty.' });
    }

    // Extract order details from request body
    const {
      customerName,
      street,
      city,
      postalCode,
      phone,
      deliveryOption,
      deliveryFee,
      itemsToCheckout // Array of productIds
    } = req.body;

    if (!customerName || !street || !city || !postalCode || !phone || !deliveryOption || deliveryFee === undefined) {
      return res.status(400).json({ message: 'Missing required order details.' });
    }

    // Filter items to checkout
    let itemsForOrder;
    if (Array.isArray(itemsToCheckout) && itemsToCheckout.length > 0) {
      itemsForOrder = cart.items.filter(item => itemsToCheckout.includes(item.productId));
      if (itemsForOrder.length === 0) {
        return res.status(400).json({ message: 'No valid items found in cart for checkout.' });
      }
    } else {
      itemsForOrder = cart.items;
    }

    // Calculate total amount
    const totalAmount = itemsForOrder.reduce((total, item) => total + (item.price * item.quantity), 0) + Number(deliveryFee);

    // Prepare order items
    const orderItems = itemsForOrder.map(item => ({
      productId: item.productId,
      productName: item.name,
      quantity: item.quantity,
      price: item.price,
      totalPrice: item.price * item.quantity
    }));

    // Generate orderReference manually (workaround for pre-save hook issue)
    const timestamp = Date.now().toString().slice(-6);
    const random = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
    const orderReference = `ORD-${timestamp}-${random}`;

    // Create new order (set orderReference manually)
    const order = new Order({
      customerName,
      street,
      city,
      postalCode,
      phone,
      deliveryOption,
      totalAmount,
      deliveryFee,
      items: orderItems,
      userId,
      orderReference
    });

    // Debug log to confirm orderReference is set
    console.log('Order to be saved:', order);

    await order.save();

    // Remove checked out items from cart
    if (itemsForOrder.length === cart.items.length) {
      // All items checked out, clear cart
      cart.items = [];
    } else {
      // Remove only checked out items
      cart.items = cart.items.filter(item => !orderItems.some(oi => oi.productId === item.productId));
    }
    await cart.save();

    res.status(201).json({
      message: 'Order placed successfully.',
      order
    });
  } catch (error) {
    console.error('Checkout error:', error);
    res.status(500).json({ message: 'Server error during checkout.', error: error.message });
  }
});

module.exports = router; 