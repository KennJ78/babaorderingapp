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
  
  // Clear all orders (for testing purposes)
  static Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ordersKey);
  }
} 