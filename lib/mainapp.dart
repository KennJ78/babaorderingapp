import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          borderRadius: BorderRadius.circular(24),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(productName, style: const TextStyle(color: Colors.white)),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 16),
            Text(
              productName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              'Price: $price',
              style: TextStyle(fontSize: 18, color: Colors.red[600], fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Text(
              'Sold: $soldCount',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              'This is a high-quality electrical product, ideal for both residential and commercial use. Designed for durability and efficiency.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Customer Reviews',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 18))),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person, color: Colors.grey[700]),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '"Very durable and worth the price! I\'ve been using this for months now with no issues. Highly recommended!"',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 18))),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person, color: Colors.grey[700]),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '"Fast delivery and great customer service. Will definitely order again!"',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart, color: Colors.red),
                label: const Text('Add to Cart', style: TextStyle(color: Colors.red)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.flash_on, color: Colors.white),
                label: const Text('Buy Now', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartProducts = [
    {
      'name': 'Socket',
      'price': '₱299',
      'image': 'assets/images/socket.jpg',
      'qty': 2,
      'checked': false,
    },
    {
      'name': 'Switch',
      'price': '₱799',
      'image': 'assets/images/switch.jpg',
      'qty': 1,
      'checked': false,
    },
    {
      'name': 'Bulb',
      'price': '₱650',
      'image': 'assets/images/bulb.jpg',
      'qty': 3,
      'checked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = cartProducts.isEmpty;

    double total = cartProducts
        .where((p) => p['checked'] == true)
        .fold(0.0, (total, p) {
      final price = double.tryParse(p['price'].toString().replaceAll('₱', '')) ?? 0.0;
      return total + (price * (p['qty'] ?? 1));
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 60,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add some products to your cart\nand they will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.store),
              label: const Text('Start Shopping'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: cartProducts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final product = cartProducts[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: (product['checked'] ?? false)
                    ? Colors.red[200]!
                    : Colors.grey[200]!,
                width: (product['checked'] ?? false) ? 2 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: product['checked'] ?? false,
                    activeColor: Colors.red[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        product['checked'] = value ?? false;
                      });
                    },
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      product['image']!,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name']!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['price']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[600],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (product['qty'] > 1) {
                                product['qty']--;
                              }
                            });
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.remove, size: 18, color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '${product['qty']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              product['qty']++;
                            });
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cartProducts.isEmpty
          ? null
          : Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '₱${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(
                        totalAmount: total,
                        cartItems: cartProducts.where((p) => p['checked'] == true).toList(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> cartItems;

  const CheckoutScreen({
    super.key,
    required this.totalAmount,
    required this.cartItems,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    // Empty initialization
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Empty checkout content
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Checkout Page',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Content will be added here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Placeholder action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Place Order',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
