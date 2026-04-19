class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String? icon;
  final bool isActive;
  final int sortOrder;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.icon,
    this.isActive = true,
    this.sortOrder = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      icon: json['icon'],
      isActive: json['is_active'] ?? true,
      sortOrder: json['sort_order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'icon': icon,
      'is_active': isActive,
      'sort_order': sortOrder,
    };
  }
}

