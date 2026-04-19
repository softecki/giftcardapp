import 'package:flutter/foundation.dart' show kIsWeb;
import 'platform_database_helper.dart';

/// Example of how to use the platform-aware database helper
/// This demonstrates the kIsWeb condition for web vs mobile database usage
class DatabaseUsageExample {
  static final PlatformDatabaseHelper _dbHelper = PlatformDatabaseHelper.instance;

  /// Example method showing how to use the database with platform detection
  static Future<void> exampleUsage() async {
    if (kIsWeb) {
      print('Running on web - using IndexedDB');
      // Web-specific database operations
      await _webSpecificOperations();
    } else {
      print('Running on mobile - using SQLite');
      // Mobile-specific database operations
      await _mobileSpecificOperations();
    }
  }

  /// Web-specific database operations
  static Future<void> _webSpecificOperations() async {
    try {
      // Example: Insert a user
      final userData = {
        'name': 'Web Agent',
        'email': 'agent@example.com',
        'phone': '1234567890',
        'status': '1',
        'created_at': DateTime.now().toIso8601String(),
      };
      
      final userId = await _dbHelper.insertUser(userData);
      print('Agent inserted with ID: $userId');

      // Example: Get all users
      final users = await _dbHelper.getUsers();
      print('Total agents in web database: ${users.length}');

    } catch (e) {
      print('Web database error: $e');
    }
  }

  /// Mobile-specific database operations
  static Future<void> _mobileSpecificOperations() async {
    try {
      // Example: Insert a user
      final userData = {
        'name': 'Mobile Agent',
        'email': 'mobile@example.com',
        'phone': '0987654321',
        'status': '1',
        'created_at': DateTime.now().toIso8601String(),
      };
      
      final userId = await _dbHelper.insertUser(userData);
      print('Agent inserted with ID: $userId');

      // Example: Get all users
      final users = await _dbHelper.getUsers();
      print('Total agents in mobile database: ${users.length}');

    } catch (e) {
      print('Mobile database error: $e');
    }
  }

  /// Example of platform-agnostic database operations
  static Future<void> platformAgnosticOperations() async {
    try {
      // These operations work the same on both platforms
      final users = await _dbHelper.getUsers();
      final firstUser = await _dbHelper.getFirstUser();
      final merchantCount = await _dbHelper.getMerchantCount();
      
      print('Platform: ${kIsWeb ? 'Web' : 'Mobile'}');
      print('Agents count: ${users.length}');
      print('First agent: ${firstUser?['name'] ?? 'None'}');
      print('Merchant count: $merchantCount');
      
    } catch (e) {
      print('Database operation error: $e');
    }
  }
}

/// Example of how to replace existing DatabaseHelper usage
/// Replace this in your existing code:
/// 
/// OLD:
/// import 'database_helper.dart';
/// final dbHelper = DatabaseHelper.instance;
/// 
/// NEW:
/// import 'platform_database_helper.dart';
/// final dbHelper = PlatformDatabaseHelper.instance;
/// 
/// The API remains the same, but now it automatically uses:
/// - IndexedDB on web platforms
/// - SQLite on mobile platforms
