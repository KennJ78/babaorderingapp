import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/product_detail_screen.dart';
import 'pages/cart_screen.dart';
import 'pages/checkout_screen.dart';
import 'pages/order_confirmation_screen.dart';
import 'pages/order_screen.dart';
import 'pages/LoginandSignup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BABA Hardware',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/orders': (context) => const OrderScreen(),
        '/checkout': (context) => CheckoutScreen(cartItems: [], totalAmount: 0),
        '/order_confirmation': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
          return OrderConfirmationScreen(
            name: args?['name'] ?? 'Customer',
            street: args?['street'] ?? '',
            city: args?['city'] ?? '',
            postalCode: args?['postalCode'] ?? '',
            deliveryOption: args?['deliveryOption'] ?? 'Standard Delivery',
            orderReference: args?['orderReference'] ?? '',
          );
        },
      },
    );
  }
} 