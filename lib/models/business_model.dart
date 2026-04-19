import 'category_model.dart';

class BusinessModel {
  final int id;
  final int userId;
  final String name;
  final String slug;
  final String? description;
  final String? logo;
  final String? banner;
  final String? email;
  final String phone;
  final String? address;
  final String? city;
  final String country;
  final double? latitude;
  final double? longitude;
  final String? website;
  final List<double>? denominations;
  final String status;
  final bool isFeatured;
  final double rating;
  final int totalReviews;
  final double walletBalance;
  final List<CategoryModel>? categories;

  BusinessModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.slug,
    this.description,
    this.logo,
    this.banner,
    this.email,
    required this.phone,
    this.address,
    this.city,
    this.country = 'Tanzania',
    this.latitude,
    this.longitude,
    this.website,
    this.denominations,
    required this.status,
    this.isFeatured = false,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.walletBalance = 0.0,
    this.categories,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      logo: json['logo'],
      banner: json['banner'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      country: json['country'] ?? 'Tanzania',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      website: json['website'],
      denominations: json['denominations'] != null
          ? List<double>.from(json['denominations'])
          : null,
      status: json['status'],
      isFeatured: json['is_featured'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      walletBalance: (json['wallet_balance'] ?? 0).toDouble(),
      categories: json['categories'] != null
          ? (json['categories'] as List).map((c) => CategoryModel.fromJson(c)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'slug': slug,
      'description': description,
      'logo': logo,
      'banner': banner,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'website': website,
      'denominations': denominations,
      'status': status,
      'is_featured': isFeatured,
      'rating': rating,
      'total_reviews': totalReviews,
      'wallet_balance': walletBalance,
      'categories': categories?.map((c) => c.toJson()).toList(),
    };
  }
}

