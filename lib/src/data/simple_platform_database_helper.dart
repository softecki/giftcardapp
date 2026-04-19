import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simplified platform-aware database helper
/// Uses SQLite on mobile and SharedPreferences + JSON on web
class SimplePlatformDatabaseHelper {
  static final SimplePlatformDatabaseHelper instance = SimplePlatformDatabaseHelper._init();
  static Database? _database;
  static SharedPreferences? _prefs;

  SimplePlatformDatabaseHelper._init();

  Future<Database?> get database async {
    if (kIsWeb) {
      // On web, we'll use SharedPreferences for simple data storage
      _prefs = await SharedPreferences.getInstance();
      return null; // No SQLite database on web
    } else {
      // On mobile, use SQLite as before
      if (_database != null) return _database!;
      _database = await _initMobileDB('malipo_mtandao.db');
      return _database!;
    }
  }

  Future<Database> _initMobileDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add columns to merchants if they don't exist
    final columnsToAdd = [
      {'name': 'create_otp', 'type': 'TEXT'},
      {'name': 'comments', 'type': 'TEXT'},
      {'name': 'otp_verified', 'type': 'TEXT'},
      {'name': 'tin', 'type': 'TEXT'},
      {'name': 'change_password', 'type': 'TEXT'},
    ];
    for (final col in columnsToAdd) {
      final result = await db.rawQuery("PRAGMA table_info(merchants)");
      final exists = result.any((row) => row['name'] == col['name']);
      if (!exists) {
        await db.execute("ALTER TABLE merchants ADD COLUMN ${col['name']} ${col['type']}");
      }
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT,
  phone TEXT,
  identification_number TEXT,
  email TEXT,
  username TEXT,
  password TEXT,
  status TEXT,
  otp TEXT,
  otp_verified TEXT,
  created_at TEXT,
  updated_at TEXT,
  change_password TEXT
)
    ''');

    await db.execute('''CREATE TABLE merchants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mechant_code TEXT NOT NULL,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  password TEXT NOT NULL,
  email TEXT,
  identification_number TEXT NOT NULL,
  licence_number TEXT,
  document_refence_id TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT '1',
  agent_id INTEGER,
  user_id INTEGER,
  created_at TEXT,
  updated_at TEXT,
  otp TEXT,
  comments TEXT,
  otp_verified TEXT,
  tin TEXT,
  change_password TEXT
)''');

    await db.execute('''
  CREATE TABLE balance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT NOT NULL,
    amount TEXT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
''');

    await db.execute('''
  CREATE TABLE customer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NULL,
    phone TEXT NULL,
    identification_number TEXT NULL,
    email TEXT NULL,
    username TEXT NULL,
    password TEXT NULL,
    status TEXT NULL,
    created_at TEXT NULL,
    updated_at TEXT NULL,
    otp TEXT NULL
  )
''');

    await db.execute('''
  CREATE TABLE account_setup (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT NULL,
    account_number TEXT NULL,
    payment_type TEXT NULL,
    selected_bank TEXT NULL
  )
''');

    await db.execute('''
  CREATE TABLE status (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT
  )
''');

    await db.execute('''
  CREATE TABLE transactions (
  id INTEGER PRIMARY KEY,
  date TEXT,
  payment_method INTEGER,
  payment_gateway TEXT,
  transaction_id TEXT,
  fees_assign_children_id INTEGER,
  fees_collect_by INTEGER,
  student_id INTEGER,
  session_id INTEGER,
  amount TEXT,
  fine_amount TEXT,
  account_id INTEGER,
  comments TEXT,
  printed INTEGER,
  created_at TEXT,
  updated_at TEXT
)
''');

    await db.execute('''
  CREATE TABLE agent_commission (
    id INTEGER PRIMARY KEY,
    total_amount TEXT NOT NULL,
    total_transactions TEXT NOT NULL,
    merchant_id TEXT NOT NULL
)
''');
  }

  // Web storage helpers using SharedPreferences
  Future<void> _saveToWebStorage(String key, List<Map<String, dynamic>> data) async {
    if (kIsWeb && _prefs != null) {
      final jsonString = jsonEncode(data);
      await _prefs!.setString(key, jsonString);
    }
  }

  Future<List<Map<String, dynamic>>> _loadFromWebStorage(String key) async {
    if (kIsWeb && _prefs != null) {
      final jsonString = _prefs!.getString(key);
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.cast<Map<String, dynamic>>();
      }
    }
    return [];
  }

  // Platform-aware database operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    if (kIsWeb) {
      // Store in SharedPreferences on web
      final users = await _loadFromWebStorage('users');
      final newId = users.length + 1;
      user['id'] = newId;
      users.add(user);
      await _saveToWebStorage('users', users);
      return newId;
    } else {
      // Use SQLite on mobile
      final db = await database;
      return await db!.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    if (kIsWeb) {
      return await _loadFromWebStorage('users');
    } else {
      final db = await database;
      return await db!.query('users');
    }
  }

  Future<Map<String, dynamic>?> getFirstUser() async {
    final users = await getUsers();
    if (users.isNotEmpty) {
      return {
        'id': users.first['id'],
        'email': users.first['email'],
        'status': users.first['status'],
        'name': users.first['name'],
        'phone': users.first['phone'],
      };
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    if (kIsWeb) {
      final users = await _loadFromWebStorage('users');
      try {
        return users.firstWhere((user) => user['email'] == email);
      } catch (e) {
        return null;
      }
    } else {
      final db = await database;
      final result = await db!.query('users', where: 'email = ?', whereArgs: [email]);
      return result.isNotEmpty ? result.first : null;
    }
  }

  Future<int> insertMerchants(Map<String, dynamic> merchants) async {
    if (kIsWeb) {
      final merchantList = await _loadFromWebStorage('merchants');
      final newId = merchantList.length + 1;
      merchants['id'] = newId;
      merchantList.add(merchants);
      await _saveToWebStorage('merchants', merchantList);
      return newId;
    } else {
      final db = await database;
      return await db!.insert('merchants', merchants, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Map<String, dynamic>>> getMerchantList() async {
    if (kIsWeb) {
      return await _loadFromWebStorage('merchants');
    } else {
      final db = await database;
      return await db!.rawQuery('''
        SELECT merchants.*, status.name AS status_name
        FROM merchants
        INNER JOIN status ON merchants.status = status.id
        ORDER BY merchants.id DESC
      ''');
    }
  }

  Future<int> getMerchantCount() async {
    if (kIsWeb) {
      final merchants = await _loadFromWebStorage('merchants');
      return merchants.length;
    } else {
      final db = await database;
      final result = await db!.rawQuery('SELECT COUNT(*) as count FROM merchants');
      return Sqflite.firstIntValue(result) ?? 0;
    }
  }

  Future<int> getTransactionsAmount() async {
    if (kIsWeb) {
      final commissions = await _loadFromWebStorage('agent_commission');
      double total = 0;
      for (final commission in commissions) {
        total += double.tryParse(commission['total_amount']?.toString() ?? '0') ?? 0;
      }
      return total.toInt();
    } else {
      final db = await database;
      final result = await db!.rawQuery('SELECT SUM(total_amount) as total_amount FROM agent_commission');
      return Sqflite.firstIntValue(result) ?? 0;
    }
  }

  Future<int> logOutUser() async {
    if (kIsWeb) {
      // Clear web storage
      if (_prefs != null) {
        await _prefs!.clear();
      }
      return 1;
    } else {
      final db = await database;
      await db!.delete('merchants');
      await db.delete('transactions');
      return await db.delete('users');
    }
  }

  // Add more methods as needed following the same pattern
  // For each method, check kIsWeb and use appropriate storage mechanism
}
