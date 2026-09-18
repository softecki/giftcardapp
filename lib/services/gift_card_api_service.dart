import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_data.dart';

class GiftCardApiService {
  static String get baseUrl => '${AppData.url}/gift-card';
  
  // Get auth token from storage
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  // Save auth token to storage
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  
  // Remove auth token
  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  // Make authenticated request
  Future<Map<String, String>> _getHeaders({bool includeAuth = false}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (includeAuth) {
      final token = await _getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    
    return headers;
  }
  
  // Handle response
  Map<String, dynamic> _handleResponse(http.Response response) {
    Map<String, dynamic> body;
    try {
      final decoded = jsonDecode(response.body);
      body = decoded is Map<String, dynamic> ? decoded : {'data': decoded};
    } catch (_) {
      throw Exception('Invalid server response');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final data = body['data'];
    final message = (data is Map && data['message'] != null)
        ? data['message'].toString()
        : (body['message'] ?? 'Request failed').toString();
    throw Exception(message);
  }

  Future<void> _persistToken(Map<String, dynamic> data) async {
    final payload = data['data'];
    if (payload is Map) {
      final token = payload['token'] ?? payload['access_token'];
      if (token != null) {
        await _saveToken(token.toString());
      }
    }
  }
  
  // Authentication APIs
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'role': role,
      }),
    );
    
    final data = _handleResponse(response);
    await _persistToken(data);
    return data;
  }
  
  Future<Map<String, dynamic>> login({
    String? email,
    String? phone,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: await _getHeaders(),
      body: jsonEncode({
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        'password': password,
      }),
    );
    
    final data = _handleResponse(response);
    await _persistToken(data);
    return data;
  }
  
  Future<Map<String, dynamic>> verifyOTP({
    String? email,
    String? phone,
    required String otpCode,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp'),
      headers: await _getHeaders(),
      body: jsonEncode({
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        'otp_code': otpCode,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> resendOTP({
    String? email,
    String? phone,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/resend-otp'),
      headers: await _getHeaders(),
      body: jsonEncode({
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> forgotPassword({
    String? email,
    String? phone,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: await _getHeaders(),
      body: jsonEncode({
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> resetPassword({
    String? email,
    String? phone,
    required String otpCode,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: await _getHeaders(),
      body: jsonEncode({
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        'otp_code': otpCode,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> logout() async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: await _getHeaders(includeAuth: true),
    );
    
    await _removeToken();
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getMe() async {
    final response = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: await _getHeaders(includeAuth: true),
    );
    
    return _handleResponse(response);
  }
  
  // Marketplace APIs
  Future<Map<String, dynamic>> getMarketplace({
    int? categoryId,
    String? search,
    String? city,
    String? sortBy,
    String? sortOrder,
    bool featuredFirst = false,
    int page = 1,
    int perPage = 15,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'per_page': perPage.toString(),
      if (categoryId != null) 'category_id': categoryId.toString(),
      if (search != null) 'search': search,
      if (city != null) 'city': city,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder,
      'featured_first': featuredFirst.toString(),
    };
    
    final uri = Uri.parse('$baseUrl/marketplace').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: await _getHeaders());
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getFeaturedBusinesses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/marketplace/featured'),
      headers: await _getHeaders(),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/marketplace/categories'),
      headers: await _getHeaders(),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getBusinessDetails(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/marketplace/$id'),
      headers: await _getHeaders(),
    );
    
    return _handleResponse(response);
  }
  
  // Business APIs
  Future<Map<String, dynamic>> registerBusiness({
    required String name,
    String? description,
    String? email,
    required String phone,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    String? website,
    required List<double> denominations,
    required List<int> categoryIds,
    String? logo,
    String? banner,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/business/register'),
      headers: await _getHeaders(includeAuth: true),
      body: jsonEncode({
        'name': name,
        'description': description,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'website': website,
        'denominations': denominations,
        'category_ids': categoryIds,
        'logo': logo,
        'banner': banner,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getMyBusiness() async {
    final response = await http.get(
      Uri.parse('$baseUrl/business/my-business'),
      headers: await _getHeaders(includeAuth: true),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getBusinessDashboard() async {
    final response = await http.get(
      Uri.parse('$baseUrl/business/dashboard'),
      headers: await _getHeaders(includeAuth: true),
    );
    
    return _handleResponse(response);
  }
  
  // Gift Card APIs
  Future<Map<String, dynamic>> purchaseGiftCard({
    required int businessId,
    required double amount,
    required String paymentMethod,
    String? paymentReference,
    String? recipientName,
    String? recipientEmail,
    String? recipientPhone,
    String? purchaseNote,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/gift-cards/purchase'),
      headers: await _getHeaders(includeAuth: true),
      body: jsonEncode({
        'business_id': businessId,
        'amount': amount,
        'payment_method': paymentMethod,
        'payment_reference': paymentReference,
        'recipient_name': recipientName,
        'recipient_email': recipientEmail,
        'recipient_phone': recipientPhone,
        'purchase_note': purchaseNote,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getMyGiftCards({String? status}) async {
    final queryParams = <String, String>{};
    if (status != null) {
      queryParams['status'] = status;
    }
    final uri = Uri.parse('$baseUrl/gift-cards/my-cards').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: await _getHeaders(includeAuth: true));
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getGiftCardDetails(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/gift-cards/$id'),
      headers: await _getHeaders(includeAuth: true),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> redeemGiftCard({
    String? cardCode,
    String? qrCode,
    required double amount,
    String? redemptionNote,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/gift-cards/redeem'),
      headers: await _getHeaders(includeAuth: true),
      body: jsonEncode({
        if (cardCode != null) 'card_code': cardCode,
        if (qrCode != null) 'qr_code': qrCode,
        'amount': amount,
        'redemption_note': redemptionNote,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> validateGiftCard({
    String? cardCode,
    String? qrCode,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/validate'),
      headers: await _getHeaders(),
      body: jsonEncode({
        if (cardCode != null) 'card_code': cardCode,
        if (qrCode != null) 'qr_code': qrCode,
      }),
    );
    
    return _handleResponse(response);
  }
  
  // Wallet APIs
  Future<Map<String, dynamic>> getWalletBalance() async {
    final response = await http.get(
      Uri.parse('$baseUrl/wallet/balance'),
      headers: await _getHeaders(includeAuth: true),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> getWalletTransactions({
    String? type,
    int page = 1,
    int perPage = 15,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'per_page': perPage.toString(),
      if (type != null) 'type': type,
    };
    
    final uri = Uri.parse('$baseUrl/wallet/transactions').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: await _getHeaders(includeAuth: true));
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> depositWallet({
    required double amount,
    required String paymentMethod,
    required String paymentReference,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/wallet/deposit'),
      headers: await _getHeaders(includeAuth: true),
      body: jsonEncode({
        'amount': amount,
        'payment_method': paymentMethod,
        'payment_reference': paymentReference,
      }),
    );
    
    return _handleResponse(response);
  }
  
  Future<Map<String, dynamic>> withdrawWallet({
    required double amount,
    required String bankAccount,
    required String bankName,
    required String accountName,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/wallet/withdraw'),
      headers: await _getHeaders(includeAuth: true),
      body: jsonEncode({
        'amount': amount,
        'bank_account': bankAccount,
        'bank_name': bankName,
        'account_name': accountName,
      }),
    );
    
    return _handleResponse(response);
  }
}

