// ignore_for_file: unused_import
// (imports trimmed)
import 'package:drift/drift.dart';
import 'connection_native.dart'
    if (dart.library.html) 'connection_web.dart'
    if (dart.library.js) 'connection_web.dart';
// (imports trimmed)

// Drift database setup
part 'drift_platform_database_helper.g.dart';

@DriftDatabase(tables: [
  Users,
  Merchants,
  Balances,
  Customers,
  AccountSetups,
  Status,
  Transactions,
  AgentCommissions,
  PaymentTransactions,
])
class DriftPlatformDatabase extends _$DriftPlatformDatabase {
  DriftPlatformDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Add columns to merchants if they don't exist
        await customStatement('ALTER TABLE merchants ADD COLUMN create_otp TEXT');
        await customStatement('ALTER TABLE merchants ADD COLUMN comments TEXT');
        await customStatement('ALTER TABLE merchants ADD COLUMN otp_verified TEXT');
        await customStatement('ALTER TABLE merchants ADD COLUMN tin TEXT');
        await customStatement('ALTER TABLE merchants ADD COLUMN change_password TEXT');
      }
      if (from < 3) {
        // Add commission_charge and admission_charge columns to users table
        await customStatement('ALTER TABLE users ADD COLUMN commission_charge TEXT');
        await customStatement('ALTER TABLE users ADD COLUMN admission_charge TEXT');
      }
      if (from < 4) {
        // Add qr_link column to merchants table
        await customStatement("ALTER TABLE merchants ADD COLUMN qr_link TEXT DEFAULT '1234567890'");
        await customStatement("UPDATE merchants SET qr_link = '1234567890' WHERE qr_link IS NULL");
      }
      if (from < 5) {
        // Add merchant_number column to merchants table
        await customStatement("ALTER TABLE merchants ADD COLUMN merchant_number TEXT");
      }
      if (from < 6) {
        // Create payment_transactions table if it doesn't exist
        // Note: Drift will handle table creation via onCreate, but we add migration for safety
        await customStatement('''
          CREATE TABLE IF NOT EXISTS payment_transactions (
            id INTEGER PRIMARY KEY,
            msisdn TEXT,
            amount REAL,
            reference TEXT,
            type TEXT,
            status TEXT,
            mechant_id INTEGER,
            settlement_status TEXT,
            charge TEXT,
            receiving_account_id TEXT,
            total_amount TEXT,
            transaction_id TEXT,
            settlement_id TEXT,
            settlement_date TEXT,
            settlement_account TEXT,
            settlement_type TEXT,
            agent_id TEXT,
            created_at TEXT,
            updated_at TEXT,
            callback_received_at TEXT,
            callback_data TEXT
          )
        ''');
      }
      if (from < 7) {
        // Add qr_link and merchant_number columns to users table
        await customStatement("ALTER TABLE users ADD COLUMN qr_link TEXT DEFAULT '1234567890'");
        await customStatement("UPDATE users SET qr_link = '1234567890' WHERE qr_link IS NULL");
        await customStatement("ALTER TABLE users ADD COLUMN merchant_number TEXT");
      }
    },
  );
}

LazyDatabase _openConnection() => openConnection('malipo_mtandao.db');

// Table definitions
class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get identificationNumber => text().named('identification_number').nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get username => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get otp => text().nullable()();
  TextColumn get otpVerified => text().named('otp_verified').nullable()();
  TextColumn get createdAt => text().named('created_at').nullable()();
  TextColumn get updatedAt => text().named('updated_at').nullable()();
  TextColumn get changePassword => text().named('change_password').nullable()();
  TextColumn get commissionCharge => text().named('commission_charge').nullable()();
  TextColumn get admissionCharge => text().named('admission_charge').nullable()();
  TextColumn get qrLink => text().named('qr_link').withDefault(const Constant('1234567890'))();
  TextColumn get merchantNumber => text().named('merchant_number').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Merchants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mechantCode => text().named('mechant_code')();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  TextColumn get password => text()();
  TextColumn get email => text().nullable()();
  TextColumn get identificationNumber => text().named('identification_number')();
  TextColumn get licenceNumber => text().named('licence_number').nullable()();
  TextColumn get documentReferenceId => text().named('document_refence_id')();
  TextColumn get status => text().withDefault(const Constant('1'))();
  IntColumn get agentId => integer().named('agent_id').nullable()();
  IntColumn get userId => integer().named('user_id').nullable()();
  TextColumn get createdAt => text().named('created_at').nullable()();
  TextColumn get updatedAt => text().named('updated_at').nullable()();
  TextColumn get otp => text().nullable()();
  TextColumn get comments => text().nullable()();
  TextColumn get otpVerified => text().named('otp_verified').nullable()();
  TextColumn get tin => text().nullable()();
  TextColumn get changePassword => text().named('change_password').nullable()();
  TextColumn get qrLink => text().named('qr_link').withDefault(const Constant('1234567890'))();
  TextColumn get merchantNumber => text().named('merchant_number').nullable()();
}

class Balances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().named('user_id')();
  TextColumn get amount => text().nullable()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
}

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get identificationNumber => text().named('identification_number').nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get username => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get createdAt => text().named('created_at').nullable()();
  TextColumn get updatedAt => text().named('updated_at').nullable()();
  TextColumn get otp => text().nullable()();
}

class AccountSetups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().named('user_id').nullable()();
  TextColumn get accountNumber => text().named('account_number').nullable()();
  TextColumn get paymentType => text().named('payment_type').nullable()();
  TextColumn get selectedBank => text().named('selected_bank').nullable()();
}

class Status extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get createdAt => text().named('created_at').nullable()();
  TextColumn get updatedAt => text().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Transactions extends Table {
  IntColumn get id => integer()();
  TextColumn get date => text().nullable()();
  IntColumn get paymentMethod => integer().named('payment_method').nullable()();
  TextColumn get paymentGateway => text().named('payment_gateway').nullable()();
  TextColumn get transactionId => text().named('transaction_id').nullable()();
  IntColumn get feesAssignChildrenId => integer().named('fees_assign_children_id').nullable()();
  IntColumn get feesCollectBy => integer().named('fees_collect_by').nullable()();
  IntColumn get studentId => integer().named('student_id').nullable()();
  IntColumn get sessionId => integer().named('session_id').nullable()();
  TextColumn get amount => text().nullable()();
  TextColumn get fineAmount => text().named('fine_amount').nullable()();
  IntColumn get accountId => integer().named('account_id').nullable()();
  TextColumn get comments => text().nullable()();
  IntColumn get printed => integer().nullable()();
  TextColumn get createdAt => text().named('created_at').nullable()();
  TextColumn get updatedAt => text().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class AgentCommissions extends Table {
  IntColumn get id => integer()();
  TextColumn get totalAmount => text().named('total_amount')();
  TextColumn get totalTransactions => text().named('total_transactions')();
  TextColumn get merchantId => text().named('merchant_id')();

  @override
  Set<Column> get primaryKey => {id};
}

class PaymentTransactions extends Table {
  IntColumn get id => integer()();
  TextColumn get msisdn => text().nullable()();
  RealColumn get amount => real().nullable()();
  TextColumn get reference => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get status => text().nullable()();
  IntColumn get mechantId => integer().named('mechant_id').nullable()();
  TextColumn get settlementStatus => text().named('settlement_status').nullable()();
  TextColumn get charge => text().nullable()();
  TextColumn get receivingAccountId => text().named('receiving_account_id').nullable()();
  TextColumn get totalAmount => text().named('total_amount').nullable()();
  TextColumn get transactionId => text().named('transaction_id').nullable()();
  TextColumn get settlementId => text().named('settlement_id').nullable()();
  TextColumn get settlementDate => text().named('settlement_date').nullable()();
  TextColumn get settlementAccount => text().named('settlement_account').nullable()();
  TextColumn get settlementType => text().named('settlement_type').nullable()();
  TextColumn get agentId => text().named('agent_id').nullable()();
  TextColumn get createdAt => text().named('created_at').nullable()();
  TextColumn get updatedAt => text().named('updated_at').nullable()();
  TextColumn get callbackReceivedAt => text().named('callback_received_at').nullable()();
  TextColumn get callbackData => text().named('callback_data').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Platform-aware database helper using Drift
class DriftPlatformDatabaseHelper {
  static final DriftPlatformDatabaseHelper instance = DriftPlatformDatabaseHelper._init();
  static DriftPlatformDatabase? _database;

  DriftPlatformDatabaseHelper._init();

  DriftPlatformDatabase get database {
    _database ??= DriftPlatformDatabase();
    return _database!;
  }

  // Platform-aware database operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    final usersCompanion = UsersCompanion(
      id: Value(user['id']),
      name: Value(user['name']),
      phone: Value(user['phone']),
      identificationNumber: Value(user['identification_number']),
      email: Value(user['email']),
      username: Value(user['username']),
      password: Value(user['password']),
      status: Value(user['status']),
      otp: Value(user['otp']),
      otpVerified: Value(user['otp_verified']),
      createdAt: Value(user['created_at']),
      updatedAt: Value(user['updated_at']),
      changePassword: Value(user['change_password']),
      commissionCharge: Value(user['commission_charge']?.toString()),
      admissionCharge: Value(user['admission_charge']?.toString()),
      qrLink: user['qr_link'] == null || user['qr_link'].toString().isEmpty
          ? const Value('1234567890')
          : Value(user['qr_link'].toString()),
      merchantNumber: Value(user['merchant_number']?.toString()),
    );

    return await database.into(database.users).insert(usersCompanion, mode: InsertMode.insertOrReplace);
  }

  Future<List<User>> getUsers() async {
    return await database.select(database.users).get();
  }

  Future<User?> getFirstUser() async {
    final users = await getUsers();
    return users.isNotEmpty ? users.first : null;
  }

  Future<User?> getUserByEmail(String email) async {
    final query = database.select(database.users)..where((tbl) => tbl.email.equals(email));
    final results = await query.get();
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertMerchants(Map<String, dynamic> merchants) async {
    print('[DB][drift-agent] insertMerchants');
    final merchantsCompanion = MerchantsCompanion(
      // Non-nullable text columns: coerce to empty string if missing
      mechantCode: Value((merchants['mechant_code'] ?? '').toString()),
      name: Value((merchants['name'] ?? '').toString()),
      phone: Value((merchants['phone'] ?? '').toString()),
      password: Value((merchants['password'] ?? '').toString()),
      identificationNumber: Value((merchants['identification_number'] ?? '').toString()),
      documentReferenceId: Value((merchants['document_refence_id'] ?? '').toString()),

      // Nullable text columns: pass absent when null
      email: merchants['email'] == null
          ? const Value.absent()
          : Value(merchants['email'].toString()),
      licenceNumber: merchants['licence_number'] == null
          ? const Value.absent()
          : Value(merchants['licence_number'].toString()),
      status: merchants['status'] == null
          ? const Value.absent()
          : Value(merchants['status'].toString()),
      otp: merchants['otp'] == null
          ? const Value.absent()
          : Value(merchants['otp'].toString()),
      comments: merchants['comments'] == null
          ? const Value.absent()
          : Value(merchants['comments'].toString()),
      otpVerified: merchants['otp_verified'] == null
          ? const Value.absent()
          : Value(merchants['otp_verified'].toString()),
      tin: merchants['tin'] == null
          ? const Value.absent()
          : Value(merchants['tin'].toString()),
      changePassword: merchants['change_password'] == null
          ? const Value.absent()
          : Value(merchants['change_password'].toString()),
      qrLink: merchants['qr_link'] == null || merchants['qr_link'].toString().isEmpty
          ? const Value('1234567890')
          : Value(merchants['qr_link'].toString()),
      merchantNumber: merchants['merchant_number'] == null
          ? const Value.absent()
          : Value(merchants['merchant_number'].toString()),

      // Nullable ints: parse safely or mark absent
      agentId: merchants['agent_id'] == null
          ? const Value.absent()
          : Value(merchants['agent_id'] is int
              ? merchants['agent_id'] as int
              : int.tryParse(merchants['agent_id'].toString())),
      userId: merchants['user_id'] == null
          ? const Value.absent()
          : Value(merchants['user_id'] is int
              ? merchants['user_id'] as int
              : int.tryParse(merchants['user_id'].toString())),

      // Timestamps: nullable
      createdAt: merchants['created_at'] == null
          ? const Value.absent()
          : Value(merchants['created_at'].toString()),
      updatedAt: merchants['updated_at'] == null
          ? const Value.absent()
          : Value(merchants['updated_at'].toString()),
    );

    return await database.into(database.merchants).insert(merchantsCompanion, mode: InsertMode.insertOrReplace);
  }

  Future<List<Merchant>> getMerchantList() async {
    return await database.select(database.merchants).get();
  }

  Future<Merchant?> getMerchantById(String id) async {
    final merchantId = int.tryParse(id);
    if (merchantId == null) return null;
    return await (database.select(database.merchants)..where((tbl) => tbl.id.equals(merchantId))).getSingleOrNull();
  }

  Future<String> getMerchantQrLink(String id) async {
    final merchant = await getMerchantById(id);
    if (merchant != null && merchant.qrLink.isNotEmpty) {
      return merchant.qrLink;
    }
    return '1234567890';
  }

  Future<int> getMerchantCount() async {
    final query = database.selectOnly(database.merchants)..addColumns([database.merchants.id.count()]);
    final result = await query.getSingle();
    return result.read(database.merchants.id.count()) ?? 0;
  }

  Future<int> getTransactionsAmount() async {
    final allCommissions = await database.select(database.agentCommissions).get();
    int total = 0;
    for (final commission in allCommissions) {
      total += int.tryParse(commission.totalAmount) ?? 0;
    }
    return total;
  }

  Future<int> logOutUser() async {
    await database.delete(database.merchants).go();
    await database.delete(database.agentCommissions).go();
    await database.delete(database.status).go();
    return await database.delete(database.users).go();
  }

  Future<List<Map<String, dynamic>>> getUsersList() async {
    print('[DB][drift-agent] getUsersList');
    final users = await database.select(database.users).get();
    return users.map((user) => {
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'identification_number': user.identificationNumber,
      'email': user.email,
      'username': user.username,
      'password': user.password,
      'status': user.status,
      'otp': user.otp,
      'otp_verified': user.otpVerified,
      'created_at': user.createdAt,
      'updated_at': user.updatedAt,
      'change_password': user.changePassword,
      'commission_charge': user.commissionCharge,
      'admission_charge': user.admissionCharge,
      'qr_link': user.qrLink,
      'merchant_number': user.merchantNumber,
    }).toList();
  }

  Future<Map<String, dynamic>?> getAgentById(String id) async {
    print('[DB][drift-agent] getAgentById');
    final user = await (database.select(database.users)..where((tbl) => tbl.id.equals(int.tryParse(id) ?? 0))).getSingleOrNull();
    if (user == null) return null;
    return {
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'identification_number': user.identificationNumber,
      'email': user.email,
      'username': user.username,
      'password': user.password,
      'status': user.status,
      'otp': user.otp,
      'otp_verified': user.otpVerified,
      'created_at': user.createdAt,
      'updated_at': user.updatedAt,
      'change_password': user.changePassword,
      'commission_charge': user.commissionCharge,
      'admission_charge': user.admissionCharge,
      'qr_link': user.qrLink,
      'merchant_number': user.merchantNumber,
    };
  }

  Future<void> clearTransactions() async {
    print('[DB][drift-agent] clearTransactions');
    await database.delete(database.agentCommissions).go();
  }

  // Add more methods as needed following the same pattern
  // All methods will work the same on both web and mobile platforms
}

extension DriftAgentInserts on DriftPlatformDatabaseHelper {
  Future<int> insertMerchants(Map<String, dynamic> merchants) async {
    final companion = MerchantsCompanion(
      mechantCode: Value(merchants['mechant_code'] ?? ''),
      name: Value(merchants['name'] ?? ''),
      phone: Value(merchants['phone'] ?? ''),
      password: Value(merchants['password'] ?? ''),
      email: Value(merchants['email']),
      identificationNumber: Value(merchants['identification_number'] ?? ''),
      licenceNumber: Value(merchants['licence_number']),
      documentReferenceId: Value(merchants['document_refence_id'] ?? ''),
      status: Value(merchants['status'] ?? '1'),
      agentId: Value(merchants['agent_id']),
      userId: Value(merchants['user_id']),
      createdAt: Value(merchants['created_at']),
      updatedAt: Value(merchants['updated_at']),
      otp: Value(merchants['otp']),
      comments: Value(merchants['comments']),
      otpVerified: Value(merchants['otp_verified']),
      tin: Value(merchants['tin']),
      changePassword: Value(merchants['change_password']),
      qrLink: merchants['qr_link'] == null || merchants['qr_link'].toString().isEmpty
          ? const Value('1234567890')
          : Value(merchants['qr_link'].toString()),
      merchantNumber: Value(merchants['merchant_number']),
    );
    return database.into(database.merchants).insert(companion, mode: InsertMode.insertOrReplace);
  }

  Future<int> insertTransaction(Map<String, dynamic> commission) async {
    print('[DB][drift-agent] insertTransaction');
    final companion = AgentCommissionsCompanion(
      id: Value(commission['id']),
      totalAmount: Value(commission['total_amount'] ?? '0'),
      totalTransactions: Value(commission['total_transactions'] ?? '0'),
      merchantId: Value(commission['merchant_id'] ?? ''),
    );
    return database.into(database.agentCommissions).insert(companion, mode: InsertMode.insertOrReplace);
  }

  Future<int> insertStatus(Map<String, dynamic> row) async {
    print('[DB][drift-agent] insertStatus');
    final companion = StatusCompanion(
      id: Value(row['id']),
      name: Value(row['name'] ?? ''),
      createdAt: Value(row['created_at']),
      updatedAt: Value(row['updated_at']),
    );
    return database.into(database.status).insert(companion, mode: InsertMode.insertOrReplace);
  }

  Future<int> insertCustomer(Map<String, dynamic> user) async {
    print('[DB][drift-agent] insertCustomer');
    print('[DB][drift-agent] insertCustomer user: ${user}');
    final companion = UsersCompanion(
      id: Value(user['id']),
      name: Value(user['name']),
      phone: Value(user['phone']),
      identificationNumber: Value(user['identification_number'].toString()),
      email: Value(user['email']),
      username: Value(user['username']),
      password: Value(user['password']),
      status: Value(user['status'].toString()),
      otp: Value(user['otp'].toString()),
      otpVerified: Value(user['otp_verified'].toString()),
      createdAt: Value(user['created_at']),
      updatedAt: Value(user['updated_at']),
      changePassword: Value(user['change_password'].toString()),
      commissionCharge: Value(user['commission_charge']?.toString()),
      admissionCharge: Value(user['admission_charge']?.toString()),
      qrLink: user['qr_link'] == null || user['qr_link'].toString().isEmpty
          ? const Value('1234567890')
          : Value(user['qr_link'].toString()),
      merchantNumber: Value(user['merchant_number']?.toString()),
    );
    return database.into(database.users).insert(companion, mode: InsertMode.insertOrReplace);
  }

  Future<int> insertPaymentTransaction(Map<String, dynamic> transaction) async {
    print('[DB][drift-agent] insertPaymentTransaction');
    final companion = PaymentTransactionsCompanion(
      id: Value(transaction['id']),
      msisdn: Value(transaction['msisdn']?.toString()),
      amount: transaction['amount'] == null
          ? const Value.absent()
          : Value(transaction['amount'] is double
              ? transaction['amount'] as double
              : double.tryParse(transaction['amount'].toString())),
      reference: Value(transaction['reference']?.toString()),
      type: Value(transaction['type']?.toString()),
      status: Value(transaction['status']?.toString()),
      mechantId: transaction['mechant_id'] == null
          ? const Value.absent()
          : Value(transaction['mechant_id'] is int
              ? transaction['mechant_id'] as int
              : int.tryParse(transaction['mechant_id'].toString())),
      settlementStatus: Value(transaction['settlement_status']?.toString()),
      charge: Value(transaction['charge']?.toString()),
      receivingAccountId: Value(transaction['receiving_account_id']?.toString()),
      totalAmount: Value(transaction['total_amount']?.toString()),
      transactionId: Value(transaction['transaction_id']?.toString()),
      settlementId: Value(transaction['settlement_id']?.toString()),
      settlementDate: Value(transaction['settlement_date']?.toString()),
      settlementAccount: Value(transaction['settlement_account']?.toString()),
      settlementType: Value(transaction['settlement_type']?.toString()),
      agentId: Value(transaction['agent_id']?.toString()),
      createdAt: Value(transaction['created_at']?.toString()),
      updatedAt: Value(transaction['updated_at']?.toString()),
      callbackReceivedAt: Value(transaction['callback_received_at']?.toString()),
      callbackData: Value(transaction['callback_data']?.toString()),
    );
    return database.into(database.paymentTransactions).insert(companion, mode: InsertMode.insertOrReplace);
  }
}
