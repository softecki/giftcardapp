import 'business_model.dart';
import 'user_model.dart';

class GiftCardModel {
  final int id;
  final int businessId;
  final int customerId;
  final String cardCode;
  final String? qrCode;
  final double originalAmount;
  final double currentBalance;
  final String status;
  final DateTime? expiresAt;
  final DateTime purchasedAt;
  final DateTime? redeemedAt;
  final String? purchaseNote;
  final String? redemptionNote;
  final String? recipientEmail;
  final String? recipientPhone;
  final String? recipientName;
  final BusinessModel? business;
  final UserModel? customer;

  GiftCardModel({
    required this.id,
    required this.businessId,
    required this.customerId,
    required this.cardCode,
    this.qrCode,
    required this.originalAmount,
    required this.currentBalance,
    required this.status,
    this.expiresAt,
    required this.purchasedAt,
    this.redeemedAt,
    this.purchaseNote,
    this.redemptionNote,
    this.recipientEmail,
    this.recipientPhone,
    this.recipientName,
    this.business,
    this.customer,
  });

  factory GiftCardModel.fromJson(Map<String, dynamic> json) {
    return GiftCardModel(
      id: int.tryParse('${json['id']}') ?? 0,
      businessId: int.tryParse('${json['business_id']}') ?? 0,
      customerId: int.tryParse('${json['customer_id']}') ?? 0,
      cardCode: json['card_code']?.toString() ?? '',
      qrCode: json['qr_code'],
      originalAmount: (json['original_amount'] ?? 0).toDouble(),
      currentBalance: (json['current_balance'] ?? 0).toDouble(),
      status: json['status']?.toString() ?? 'active',
      expiresAt: json['expires_at'] != null ? DateTime.tryParse('${json['expires_at']}') : null,
      purchasedAt: DateTime.tryParse('${json['purchased_at'] ?? json['created_at']}') ??
          DateTime.now(),
      redeemedAt: json['redeemed_at'] != null ? DateTime.tryParse('${json['redeemed_at']}') : null,
      purchaseNote: json['purchase_note'],
      redemptionNote: json['redemption_note'],
      recipientEmail: json['recipient_email'],
      recipientPhone: json['recipient_phone'],
      recipientName: json['recipient_name'],
      business: json['business'] != null ? BusinessModel.fromJson(json['business']) : null,
      customer: json['customer'] != null ? UserModel.fromJson(json['customer']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'customer_id': customerId,
      'card_code': cardCode,
      'qr_code': qrCode,
      'original_amount': originalAmount,
      'current_balance': currentBalance,
      'status': status,
      'expires_at': expiresAt?.toIso8601String(),
      'purchased_at': purchasedAt.toIso8601String(),
      'redeemed_at': redeemedAt?.toIso8601String(),
      'purchase_note': purchaseNote,
      'redemption_note': redemptionNote,
      'recipient_email': recipientEmail,
      'recipient_phone': recipientPhone,
      'recipient_name': recipientName,
      'business': business?.toJson(),
      'customer': customer?.toJson(),
    };
  }

  bool get isActive => status == 'active' && currentBalance > 0;
  bool get isExpired => expiresAt != null && expiresAt!.isBefore(DateTime.now());
  bool get canBeRedeemed => isActive && !isExpired && currentBalance > 0;
}

