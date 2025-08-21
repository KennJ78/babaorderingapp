// Web version of your Flutter DataService
import { categories, products } from '../data/mockData';

class DataService {
  // Get all categories
  static getAllCategories() {
    return categories;
  }

  // Get active categories only
  static getActiveCategories() {
    return categories.filter(category => category.isActive);
  }

  // Get category by ID
  static getCategoryById(id) {
    return categories.find(category => category.id === id) || null;
  }

  // Get all products
  static getAllProducts() {
    return products;
  }

  // Get products by category
  static getProductsByCategory(categoryId) {
    if (categoryId === 'all') {
      return products;
    }
    return products.filter(product => product.categoryId === categoryId);
  }

  // Get product by ID
  static getProductById(id) {
    return products.find(product => product.id === id) || null;
  }

  // Search products by name
  static searchProducts(query) {
    const lowercaseQuery = query.toLowerCase();
    return products.filter(product => {
      return product.name.toLowerCase().includes(lowercaseQuery) ||
             product.description.toLowerCase().includes(lowercaseQuery);
    });
  }

  // Get products with filters (exact same logic as Flutter)
  static getFilteredProducts({ categoryId, searchQuery, availableOnly }) {
    let filteredProducts = [...products];

    // Filter by category
    if (categoryId && categoryId !== 'all') {
      filteredProducts = filteredProducts.filter(product => product.categoryId === categoryId);
    }

    // Filter by search query
    if (searchQuery && searchQuery.trim()) {
      const lowercaseQuery = searchQuery.toLowerCase();
      filteredProducts = filteredProducts.filter(product => {
        return product.name.toLowerCase().includes(lowercaseQuery) ||
               product.description.toLowerCase().includes(lowercaseQuery);
      });
    }

    // Filter by availability
    if (availableOnly === true) {
      filteredProducts = filteredProducts.filter(product => product.isAvailable);
    }

    return filteredProducts;
  }
}

export default DataService;
