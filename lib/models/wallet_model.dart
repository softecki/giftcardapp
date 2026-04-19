class WalletModel {
  final int id;
  final int? userId;
  final String walletType;
  final String walletNumber;
  final String walletName;
  final String phoneNumber;
  final double walletBalance;
  final String status;

  WalletModel({
    required this.id,
    this.userId,
    required this.walletType,
    required this.walletNumber,
    required this.walletName,
    required this.phoneNumber,
    required this.walletBalance,
    required this.status,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      userId: json['user_id'],
      walletType: json['wallet_type'],
      walletNumber: json['wallet_number'],
      walletName: json['wallet_name'],
      phoneNumber: json['phone_number'],
      walletBalance: (json['wallet_balance'] ?? 0).toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'wallet_type': walletType,
      'wallet_number': walletNumber,
      'wallet_name': walletName,
      'phone_number': phoneNumber,
      'wallet_balance': walletBalance,
      'status': status,
    };
  }
}

