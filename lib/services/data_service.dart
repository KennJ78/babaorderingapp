import '../models/category.dart';
import '../models/product.dart';

class DataService {
  // Categories data
  static final List<Category> categories = [
    const Category(
      id: 'all',
      name: 'All',
      icon: 'Icons.all_inclusive',
      description: 'All products',
    ),
    const Category(
      id: 'tools',
      name: 'Tools',
      icon: 'Icons.build',
      description: 'Hand tools and equipment',
    ),
    const Category(
      id: 'switches',
      name: 'Switches',
      icon: 'Icons.power',
      description: 'Electrical switches and controls',
    ),
    const Category(
      id: 'lighting',
      name: 'Lighting',
      icon: 'Icons.lightbulb',
      description: 'Lighting fixtures and bulbs',
    ),
    const Category(
      id: 'circuit_breakers',
      name: 'Circuit Breakers',
      icon: 'Icons.electric_bolt',
      description: 'Circuit breakers and electrical protection',
    ),
    const Category(
      id: 'wiring',
      name: 'Wiring',
      icon: 'Icons.cable',
      description: 'Electrical wires and cables',
    ),
  ];

  // Products data
  static final List<Product> products = [
    const Product(
      id: 'socket_001',
      name: 'Socket',
      price: '₱299',
      soldCount: '2.1k',
      imagePath: 'assets/images/socket.jpg',
      categoryId: 'tools',
      description: 'High-quality electrical socket for various applications',
      rating: 4.5,
      reviewCount: 128,
    ),
    const Product(
      id: 'longnose_001',
      name: 'Longnose Pliers',
      price: '₱450',
      soldCount: '1.8k',
      imagePath: 'assets/images/longnose.jpg',
      categoryId: 'tools',
      description: 'Precision longnose pliers for detailed work',
      rating: 4.3,
      reviewCount: 95,
    ),
    const Product(
      id: 'switch_001',
      name: 'Switch',
      price: '₱799',
      soldCount: '3.2k',
      imagePath: 'assets/images/switch.jpg',
      categoryId: 'switches',
      description: 'Reliable electrical switch for home and commercial use',
      rating: 4.7,
      reviewCount: 203,
    ),
    const Product(
      id: 'wire_001',
      name: 'Electrical Wire',
      price: '₱1,250',
      soldCount: '950',
      imagePath: 'assets/images/wires.jpg',
      categoryId: 'wiring',
      description: 'High-grade electrical wire for safe installations',
      rating: 4.4,
      reviewCount: 67,
    ),
    const Product(
      id: 'measuring_tape_001',
      name: 'Measuring Tape',
      price: '₱899',
      soldCount: '1.5k',
      imagePath: 'assets/images/measuringtape.jpg',
      categoryId: 'tools',
      description: 'Accurate measuring tape for precise measurements',
      rating: 4.6,
      reviewCount: 142,
    ),
    const Product(
      id: 'bulb_001',
      name: 'LED Bulb',
      price: '₱650',
      soldCount: '2.7k',
      imagePath: 'assets/images/bulb.jpg',
      categoryId: 'lighting',
      description: 'Energy-efficient LED bulb with long lifespan',
      rating: 4.8,
      reviewCount: 189,
    ),
    const Product(
      id: 'circuit_breaker_001',
      name: 'Circuit Breaker',
      price: '₱1,499',
      soldCount: '890',
      imagePath: 'assets/images/circuitbreakers.jpg',
      categoryId: 'circuit_breakers',
      description: 'Safety circuit breaker for electrical protection',
      rating: 4.9,
      reviewCount: 76,
    ),
    const Product(
      id: 'pliers_001',
      name: 'Pliers',
      price: '₱399',
      soldCount: '1.9k',
      imagePath: 'assets/images/pliers.jpg',
      categoryId: 'tools',
      description: 'Versatile pliers for various gripping tasks',
      rating: 4.2,
      reviewCount: 113,
    ),
  ];

  // Get all categories
  static List<Category> getAllCategories() {
    return categories;
  }

  // Get active categories only
  static List<Category> getActiveCategories() {
    return categories.where((category) => category.isActive).toList();
  }

  // Get category by ID
  static Category? getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get all products
  static List<Product> getAllProducts() {
    return products;
  }

  // Get products by category
  static List<Product> getProductsByCategory(String categoryId) {
    if (categoryId == 'all') {
      return products;
    }
    return products.where((product) => product.categoryId == categoryId).toList();
  }

  // Get product by ID
  static Product? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search products by name
  static List<Product> searchProducts(String query) {
    final lowercaseQuery = query.toLowerCase();
    return products.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
             product.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Get products with filters
  static List<Product> getFilteredProducts({
    String? categoryId,
    String? searchQuery,
    bool? availableOnly,
  }) {
    List<Product> filteredProducts = products;

    // Filter by category
    if (categoryId != null && categoryId != 'all') {
      filteredProducts = filteredProducts.where((product) => product.categoryId == categoryId).toList();
    }

    // Filter by search query
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final lowercaseQuery = searchQuery.toLowerCase();
      filteredProducts = filteredProducts.where((product) {
        return product.name.toLowerCase().contains(lowercaseQuery) ||
               product.description.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }

    // Filter by availability
    if (availableOnly == true) {
      filteredProducts = filteredProducts.where((product) => product.isAvailable).toList();
    }

    return filteredProducts;
  }
} 