import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';

class OrderService {
  static const String _ordersKey = 'orders';
  
  // Add a new order
  static Future<void> addOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey) ?? [];
    
    // Add the new order
    ordersJson.add(jsonEncode(order.toMap()));
    
    // Save back to SharedPreferences
    await prefs.setStringList(_ordersKey, ordersJson);
  }
  
  // Get all orders
  static Future<List<Order>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey) ?? [];
    
    return ordersJson
        .map((json) => Order.fromMap(jsonDecode(json)))
        .toList()
        ..sort((a, b) => b.orderDate.compareTo(a.orderDate)); // Sort by newest first
  }
  
  // Update order status by id
  static Future<void> updateOrderStatus(String orderId, String newStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey) ?? [];
    final orders = ordersJson.map((json) => Order.fromMap(jsonDecode(json))).toList();
    final index = orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final oldOrder = orders[index];
      final updatedOrder = Order(
        id: oldOrder.id,
        orderReference: oldOrder.orderReference,
        customerName: oldOrder.customerName,
        street: oldOrder.street,
        city: oldOrder.city,
        postalCode: oldOrder.postalCode,
        phone: oldOrder.phone,
        deliveryOption: oldOrder.deliveryOption,
        totalAmount: oldOrder.totalAmount,
        deliveryFee: oldOrder.deliveryFee,
        items: oldOrder.items,
        orderDate: oldOrder.orderDate,
        status: newStatus,
      );
      orders[index] = updatedOrder;
      final updatedOrdersJson = orders.map((order) => jsonEncode(order.toMap())).toList();
      await prefs.setStringList(_ordersKey, updatedOrdersJson);
    }
  }
  
  // Clear all orders (for testing purposes)
  static Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ordersKey);
  }

  // Find order by orderReference
  static Future<Order?> getOrderByReference(String orderReference) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey) ?? [];
    final orders = ordersJson.map((json) => Order.fromMap(jsonDecode(json))).toList();
    for (final order in orders) {
      if (order.orderReference == orderReference) {
        return order;
      }
    }
    return null;
  }
} 