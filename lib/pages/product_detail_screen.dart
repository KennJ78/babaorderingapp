import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import '../models/product.dart';
import '../services/data_service.dart';

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

  Product? get product {
    return DataService.products.firstWhere(
      (p) => p.name == productName,
      orElse: () => Product(
        id: 'temp',
        name: productName,
        price: price,
        soldCount: soldCount,
        imagePath: imagePath,
        categoryId: 'tools',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productData = product;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.white60, size: 30),
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
                child: Stack(
                  children: [
                    Image.asset(
                      imagePath,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    if (productData != null && !productData.isAvailable)
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              productName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (productData != null) ...[
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[600], size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${productData.rating} (${productData.reviewCount} reviews)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'Price: $price',
              style: TextStyle(fontSize: 18, color: Colors.red[600], fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
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
            Text(
              productData?.description ?? 'This is a high-quality electrical product, ideal for both residential and commercial use. Designed for durability and efficiency.',
              style: const TextStyle(fontSize: 14),
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
                onPressed: productData?.isAvailable == false ? null : () {
                  // Add product to cart
                  CartService.addToCart(productName, price, imagePath);
                  // Navigate to cart screen immediately
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
                onPressed: productData?.isAvailable == false ? null : () {
                  // Create a single item list for buy now
                  final buyNowItem = {
                    'name': productName,
                    'price': price,
                    'image': imagePath,
                    'qty': 1,
                    'checked': true,
                  };
                  
                  // Calculate total amount for single item
                  final priceValue = double.tryParse(
                    price.replaceAll('₱', '').replaceAll(',', '')
                  ) ?? 0.0;
                  
                  // Navigate directly to checkout screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(
                        cartItems: [buyNowItem],
                        totalAmount: priceValue,
                      ),
                    ),
                  );
                },
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