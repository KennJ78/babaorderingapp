import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'category_button.dart';
import 'product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Socket', 'price': '₱299', 'sold': '2.1k', 'image': 'assets/images/socket.jpg'},
      {'name': 'Longnose', 'price': '₱450', 'sold': '1.8k', 'image': 'assets/images/longnose.jpg'},
      {'name': 'Switch', 'price': '₱799', 'sold': '3.2k', 'image': 'assets/images/switch.jpg'},
      {'name': 'Wires', 'price': '₱1,250', 'sold': '950', 'image': 'assets/images/wires.jpg'},
      {'name': 'Measuring Tape', 'price': '₱899', 'sold': '1.5k', 'image': 'assets/images/measuringtape.jpg'},
      {'name': 'Bulb', 'price': '₱650', 'sold': '2.7k', 'image': 'assets/images/bulb.jpg'},
      {'name': 'Circuit Breakers', 'price': '₱1,499', 'sold': '890', 'image': 'assets/images/circuitbreakers.jpg'},
      {'name': 'Pliers', 'price': '₱399', 'sold': '1.9k', 'image': 'assets/images/pliers.jpg'},
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.red[600],
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Search menu items...',
                hintStyle: const TextStyle(color: Colors.black87),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                CategoryButton(label: 'All', isSelected: true),
                CategoryButton(label: 'Tools'),
                CategoryButton(label: 'Switches'),
                CategoryButton(label: 'Lighting'),
                CategoryButton(label: 'Circuit Breaker'),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(
                            productName: product['name']!,
                            price: product['price']!,
                            soldCount: product['sold']!,
                            imagePath: product['image']!,
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      productName: product['name']!,
                      price: product['price']!,
                      soldCount: product['sold']!,
                      imagePath: product['image']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 2) {
            // Orders tab
            _showOrderHistory(context);
          }
          // TODO: Implement navigation for other tabs
        },
        selectedItemColor: Colors.red[600],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  void _showOrderHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.receipt_long, color: Colors.red[600]),
              const SizedBox(width: 8),
              const Text('Order History'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your order history will appear here.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Order references will be displayed for easy tracking.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red[600]),
              ),
            ),
          ],
        );
      },
    );
  }
} 