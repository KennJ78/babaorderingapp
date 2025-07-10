# Category Structure Documentation

## Overview
The category system has been completely restructured to provide better organization, scalability, and maintainability for the BABA Hardware app.

## New Structure

### 1. Category Model (`lib/models/category.dart`)
```dart
class Category {
  final String id;           // Unique identifier
  final String name;         // Display name
  final String icon;         // Icon identifier
  final String description;  // Category description
  final bool isActive;       // Whether category is active
}
```

### 2. Product Model (`lib/models/product.dart`)
```dart
class Product {
  final String id;           // Unique identifier
  final String name;         // Product name
  final String price;        // Product price
  final String soldCount;    // Number of units sold
  final String imagePath;    // Product image path
  final String categoryId;   // Reference to category
  final String description;  // Product description
  final bool isAvailable;    // Stock availability
  final double rating;       // Product rating
  final int reviewCount;     // Number of reviews
}
```

### 3. Data Service (`lib/services/data_service.dart`)
Centralized data management with methods for:
- Getting all categories
- Getting products by category
- Filtering products
- Searching products
- Managing product availability

## Categories Available

1. **All** - Shows all products
2. **Tools** - Hand tools and equipment
3. **Switches** - Electrical switches and controls
4. **Lighting** - Lighting fixtures and bulbs
5. **Circuit Breakers** - Electrical protection devices
6. **Wiring** - Electrical wires and cables
7. **Plumbing** - Plumbing supplies and fixtures
8. **Safety** - Safety equipment and protective gear

## Key Improvements

### 1. **Structured Data**
- Products and categories are now proper objects instead of maps
- Type safety and better IDE support
- Easier to maintain and extend

### 2. **Enhanced UI**
- Category buttons now include icons
- Better visual feedback with shadows and animations
- Improved product cards with ratings and availability status

### 3. **Scalability**
- Easy to add new categories
- Simple to add new products
- Centralized data management

### 4. **Features Added**
- Product ratings and review counts
- Stock availability tracking
- Product descriptions
- Category descriptions
- Better search functionality

### 5. **Management Tools**
- Category management screen for admin purposes
- Product filtering by multiple criteria
- Enhanced product detail pages

## Usage Examples

### Adding a New Category
```dart
const Category(
  id: 'new_category',
  name: 'New Category',
  icon: 'Icons.new_icon',
  description: 'Description of new category',
);
```

### Adding a New Product
```dart
const Product(
  id: 'new_product_001',
  name: 'New Product',
  price: '₱999',
  soldCount: '500',
  imagePath: 'assets/images/new_product.jpg',
  categoryId: 'tools',
  description: 'Product description',
  rating: 4.5,
  reviewCount: 25,
);
```

### Filtering Products
```dart
// Get products by category
List<Product> tools = DataService.getProductsByCategory('tools');

// Search products
List<Product> searchResults = DataService.searchProducts('socket');

// Filter with multiple criteria
List<Product> filtered = DataService.getFilteredProducts(
  categoryId: 'tools',
  searchQuery: 'socket',
  availableOnly: true,
);
```

## Benefits

1. **Maintainability**: Code is more organized and easier to maintain
2. **Scalability**: Easy to add new categories and products
3. **User Experience**: Better UI with icons, ratings, and availability status
4. **Performance**: Efficient filtering and search capabilities
5. **Flexibility**: Easy to modify category structure without breaking existing code

## Migration Notes

The old hardcoded product list in `home_screen.dart` has been replaced with the new structured approach. All existing functionality is preserved while adding new features and better organization. 