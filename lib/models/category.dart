class Category {
  final String id;
  final String name;
  final String icon;
  final String description;
  final bool isActive;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    this.description = '',
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'isActive': isActive,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      description: map['description'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, icon: $icon, description: $description, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 