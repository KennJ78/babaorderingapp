import 'package:flutter/material.dart';

void main() {
  runApp(const RamenApp());
}

class RamenApp extends StatelessWidget {
  const RamenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BABA App',
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: null,
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
}

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
          backgroundColor: Colors.grey[900],
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Search menu items...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
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
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryButton({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black,
        backgroundColor: isSelected ? Colors.red[600] : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final String soldCount;
  final String imagePath;

  const ProductCard({
    super.key,
    required this.productName,
    required this.price,
    required this.soldCount,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 1.3,
                child: Container(
                  color: Colors.grey[200],
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[600],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber[600]),
                            const SizedBox(width: 2),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '$soldCount sold',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String price;
  final String soldCount;
  final String imagePath;

  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.price,
    required this.soldCount,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Product Name Placeholder
            Container(
              width: double.infinity,
              height: 24,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),

            // Price Placeholder
            Container(
              width: 100,
              height: 20,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),

            // Sold Count Placeholder
            Container(
              width: 60,
              height: 18,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),

            // Description Placeholder
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
