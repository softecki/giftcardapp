import 'category_model.dart';
import 'json_num.dart';

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
    List<double>? denominations;
    final rawDenoms = json['denominations'];
    if (rawDenoms is List) {
      denominations = rawDenoms
          .map(parseJsonDoubleOrNull)
          .whereType<double>()
          .toList();
    }

    List<CategoryModel>? categories;
    final rawCats = json['categories'];
    if (rawCats is List) {
      categories = rawCats
          .whereType<Map>()
          .map((c) {
            try {
              return CategoryModel.fromJson(Map<String, dynamic>.from(c));
            } catch (_) {
              return null;
            }
          })
          .whereType<CategoryModel>()
          .toList();
    }

    return BusinessModel(
      id: parseJsonInt(json['id']),
      userId: parseJsonInt(json['user_id']),
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString(),
      logo: json['logo']?.toString(),
      banner: json['banner']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      country: json['country']?.toString() ?? 'Tanzania',
      latitude: parseJsonDoubleOrNull(json['latitude']),
      longitude: parseJsonDoubleOrNull(json['longitude']),
      website: json['website']?.toString(),
      denominations: denominations,
      status: json['status']?.toString() ?? 'pending',
      isFeatured: parseJsonBool(json['is_featured']),
      rating: parseJsonDouble(json['rating']),
      totalReviews: parseJsonInt(json['total_reviews']),
      walletBalance: parseJsonDouble(json['wallet_balance']),
      categories: categories,
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

