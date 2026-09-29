import 'business_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String status;
  final bool otpVerified;
  final BusinessModel? business;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    required this.otpVerified,
    this.business,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      role: json['role']?.toString() ?? 'customer',
      status: json['status']?.toString() ?? 'active',
      otpVerified: json['otp_verified'] == true || json['otp_verified'] == 1,
      business: _parseBusiness(json['business']),
    );
  }

  static BusinessModel? _parseBusiness(dynamic raw) {
    if (raw is! Map) return null;
    try {
      return BusinessModel.fromJson(Map<String, dynamic>.from(raw));
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'status': status,
      'otp_verified': otpVerified,
      'business': business?.toJson(),
    };
  }
}

