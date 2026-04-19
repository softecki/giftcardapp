import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('malipo_mtandao.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
       version: 6,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add columns to merchants if they don't exist
    if (oldVersion < 2) {
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
    
    // Add commission_charge and admission_charge columns to users table
    if (oldVersion < 3) {
      final userColumnsToAdd = [
        {'name': 'commission_charge', 'type': 'TEXT'},
        {'name': 'admission_charge', 'type': 'TEXT'},
      ];
      for (final col in userColumnsToAdd) {
        final result = await db.rawQuery("PRAGMA table_info(users)");
        final exists = result.any((row) => row['name'] == col['name']);
        if (!exists) {
          await db.execute("ALTER TABLE users ADD COLUMN ${col['name']} ${col['type']}");
        }
      }
    }
    
    // Add qr_link column to merchants table
    if (oldVersion < 4) {
      final result = await db.rawQuery("PRAGMA table_info(merchants)");
      final exists = result.any((row) => row['name'] == 'qr_link');
      if (!exists) {
        await db.execute("ALTER TABLE merchants ADD COLUMN qr_link TEXT DEFAULT '1234567890'");
        // Update existing rows with default value
        await db.update('merchants', {'qr_link': '1234567890'}, where: 'qr_link IS NULL');
      }
    }
    
    // Add merchant_number column to merchants table
    if (oldVersion < 5) {
      final result = await db.rawQuery("PRAGMA table_info(merchants)");
      final exists = result.any((row) => row['name'] == 'merchant_number');
      if (!exists) {
        await db.execute("ALTER TABLE merchants ADD COLUMN merchant_number TEXT");
      }
    }
    
    // Add qr_link and merchant_number columns to users table
    if (oldVersion < 6) {
      final userColumns = await db.rawQuery("PRAGMA table_info(users)");
      final columnNames = userColumns.map((col) => col['name'] as String).toList();
      
      if (!columnNames.contains('qr_link')) {
        await db.execute("ALTER TABLE users ADD COLUMN qr_link TEXT DEFAULT '1234567890'");
        // Update existing rows with default value
        await db.update('users', {'qr_link': '1234567890'}, where: 'qr_link IS NULL');
      }
      
      if (!columnNames.contains('merchant_number')) {
        await db.execute("ALTER TABLE users ADD COLUMN merchant_number TEXT");
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
  change_password TEXT,
  commission_charge TEXT,
  admission_charge TEXT,
  qr_link TEXT DEFAULT '1234567890',
  merchant_number TEXT
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
  change_password TEXT,
  qr_link TEXT DEFAULT '1234567890',
  merchant_number TEXT
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



  Future<int> insertStatus(Map<String, dynamic> transaction) async {
    try {
      final db = await instance.database;

      return await db.insert(
        'status',
        transaction,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting transaction: $e');
      return -1;
    }
  }



  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<int> logOutUser() async {
    final db = await instance.database;
     await db.delete('merchants');
    await db.delete('transactions');
    return await db.delete('users');
  }

  Future<int> delete() async {
    final db = await instance.database;
    await db.delete('merchants');
    return await db.delete('users');
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getUsersList() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getCustomer() async {
    final db = await instance.database;
    return await db.query('customer');
  }

  Future<List<Map<String, dynamic>>> getAccountSetup() async {
    final db = await instance.database;
    return await db.query('account_setup');
  }

  Future<List<Map<String, dynamic>>> getBalance() async {
    final db = await instance.database;
    return await db.query('merchants');
  }

  Future<int> getMerchantCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM merchants');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getTransactionsAmount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT SUM(total_amount) as total_amount FROM agent_commission');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getMerchantList() async {
    final db = await instance.database;

    return await db.rawQuery('''
    SELECT merchants.*, status.name AS status_name
    FROM merchants
    INNER JOIN status ON merchants.status = status.id
    ORDER BY merchants.id DESC
  ''');
  }

  Future<Map<String, dynamic>?> getMerchantById(String id) async {
    final db = await instance.database;
    final result = await db.query(
      'merchants',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<String?> getMerchantQrLink(String id) async {
    final merchant = await getMerchantById(id);
    if (merchant != null && merchant.containsKey('qr_link')) {
      return merchant['qr_link']?.toString() ?? '1234567890';
    }
    return '1234567890';
  }

  Future<List<Map<String, dynamic>>> getStaff() async {
    final db = await instance.database;
    return await db.query('staff');
  }


  Future<List<Map<String, dynamic>>> getSchoolFees(int id) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        '''
    SELECT *,fees_type.name as fee_name FROM fees_assignments
    INNER JOIN fees_masters ON fees_masters.id = fees_assignments.fees_master_id
    INNER JOIN fees_type ON fees_type.id = fees_masters.fees_type_id
    WHERE fees_assignments.student_id = ?
    ''',
        [id]
    );

    return result;
  }

  Future<Map<String, dynamic>?> getFirstUser() async {
    List<Map<String, dynamic>> users = await getUsers();

    if (users.isNotEmpty) {
      return {
        'id': users.first['id'],
        'email': users.first['email'],
        'status': users.first['status'],
        'name': users.first['name'],
        'phone': users.first['phone'],
      };
    }

    return null; // Return null if no users exist
  }
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result =
    await db.query('users', where: 'email = ?', whereArgs: [email]);

    return result.isNotEmpty ? result.first : null;
  }

  Future<int> insertCustomer(Map<String, dynamic> user) async {
    try {
      // Convert all values to String
      Map<String, String> stringStudent = user.map((key, value) => MapEntry(key, value?.toString() ?? ''));

      final db = await instance.database;

      // Insert using converted map
      return await db.insert(
        'users',
        stringStudent,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting student: $e');
      return -1;
    }
  }

  Future<int> clearTransactions() async {
    final db = await instance.database;
    await db.delete('agent_commission');
    return await db.delete('merchants');
  }

  Future<int> insertTransaction(Map<String, dynamic> merchants) async {
    try {
      // Convert all values to String
      Map<String, String> stringStudent = merchants.map((key, value) => MapEntry(key, value?.toString() ?? ''));

      final db = await instance.database;

      // Insert using converted map
      return await db.insert(
        'agent_commission',
        stringStudent,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting student: $e');
      return -1;
    }
  }

  Future<int> insertMerchants(Map<String, dynamic> merchants) async {
    try {
      // Convert all values to String
      Map<String, String> stringStudent = merchants.map((key, value) => MapEntry(key, value?.toString() ?? ''));
      
      // Set default qr_link if not provided
      if (!stringStudent.containsKey('qr_link') || stringStudent['qr_link']?.isEmpty == true) {
        stringStudent['qr_link'] = '1234567890';
      }

      final db = await instance.database;

      // Insert using converted map
      return await db.insert(
        'merchants',
        stringStudent,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting student: $e');
      return -1;
    }
  }

  Future<int> insertBalance(Map<String, dynamic> balance) async {
    try {
      // Convert all values to String
      Map<String, String> stringStudent = balance.map((key, value) => MapEntry(key, value?.toString() ?? ''));

      final db = await instance.database;

      // Insert using converted map
      return await db.insert(
        'balance',
        stringStudent,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting student: $e');
      return -1;
    }
  }

  Future<int> insertAccount(Map<String, dynamic> account) async {
    try {
      // Convert all values to String
      Map<String, String> stringStudent = account.map((key, value) => MapEntry(key, value?.toString() ?? ''));

      final db = await instance.database;

      // Insert using converted map
      return await db.insert(
        'account_setup',
        stringStudent,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting student: $e');
      return -1;
    }
  }


  Future<int> insertStudent(Map<String, dynamic> student) async {
    try {
      // Convert all values to String
      Map<String, String> stringStudent = student.map((key, value) => MapEntry(key, value?.toString() ?? ''));

      final db = await instance.database;

      // Insert using converted map
      return await db.insert(
        'students',
        stringStudent,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting student: $e');
      return -1;
    }
  }




  Future<Map<String, dynamic>?> getAgentById(int id) async {
    final db = await instance.database;
    final result = await db.rawQuery('''
    SELECT * FROM users
    WHERE id = ?
  ''', [id]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }


  // Function to update user status by ID
  Future<int> updateUserStatus(int userId) async {
    final db = await database;
    return await db.update(
      'users',
      {'status': 2}, // Update status to 2
      where: 'id = ?',
      whereArgs: [userId],
    );
  }


}
