const express = require('express');
const Order = require('../models/Order');
const Cart = require('../models/Cart');
const auth = require('../middleware/auth');
const User = require('../models/User');
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

    // Fetch user profile
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found.' });
    }

    // Extract order details from request body or fallback to user profile
    const customerName = req.body.customerName || user.name;
    const street = req.body.street || user.address; // user.address maps to street
    const city = req.body.city || user.city;
    const postalCode = req.body.postalCode || user.zipCode;
    const phone = req.body.phone || user.phoneNumber;
    const deliveryOption = req.body.deliveryOption || 'Delivery'; // default to Delivery if not set
    const deliveryFee = req.body.deliveryFee !== undefined ? req.body.deliveryFee : 0; // default to 0 if not set

    // Only require itemsToCheckout in body
    const { itemsToCheckout } = req.body;
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

// GET /api/orders/all - Admin: View all users' orders
router.get('/all', auth, async (req, res) => {
  try {
    // Fetch user from DB to check admin status
    const user = await User.findById(req.user.userId);
    if (!user || !user.isAdmin) {
      return res.status(403).json({ message: 'Access denied. Admins only.' });
    }
    const orders = await Order.find().sort({ createdAt: -1 });
    res.json({ orders });
  } catch (error) {
    console.error('Admin get all orders error:', error);
    res.status(500).json({ message: 'Server error fetching orders.', error: error.message });
  }
});

// GET /api/orders/user - Get all orders for the authenticated user
router.get('/user', auth, async (req, res) => {
  try {
    const userId = req.user.userId;
    const orders = await Order.find({ userId }).sort({ createdAt: -1 });
    res.json({ orders });
  } catch (error) {
    console.error('Get user orders error:', error);
    res.status(500).json({ message: 'Server error fetching user orders.', error: error.message });
  }
});

module.exports = router; 