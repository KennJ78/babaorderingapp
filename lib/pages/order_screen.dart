import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Orders Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 