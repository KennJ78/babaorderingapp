class Product {
  final String id;
  final String name;
  final String price;
  final String soldCount;
  final String imagePath;
  final String categoryId;
  final String description;
  final bool isAvailable;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.soldCount,
    required this.imagePath,
    required this.categoryId,
    this.description = '',
    this.isAvailable = true,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'soldCount': soldCount,
      'imagePath': imagePath,
      'categoryId': categoryId,
      'description': description,
      'isAvailable': isAvailable,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      soldCount: map['soldCount'],
      imagePath: map['imagePath'],
      categoryId: map['categoryId'],
      description: map['description'] ?? '',
      isAvailable: map['isAvailable'] ?? true,
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 