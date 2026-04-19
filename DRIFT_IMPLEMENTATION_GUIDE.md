# Drift Database Implementation Guide

## Overview
This guide explains how to use the new Drift-based platform-aware database helper that provides persistent storage for both web and mobile platforms.

## Key Benefits

### ✅ **Persistent Storage**
- **Web**: Uses Drift's web storage (IndexedDB-based) - data persists across page refreshes
- **Mobile**: Uses SQLite as before
- **No data loss**: Unlike in-memory databases, data survives page refreshes and app restarts

### ✅ **Platform Detection**
- Automatically detects platform using `kIsWeb`
- Same API works on both web and mobile
- No code changes needed when switching platforms

### ✅ **Type Safety**
- Drift provides compile-time type safety
- Auto-generated code for tables and queries
- Better IDE support with autocomplete

## Usage

### 1. Replace Existing Database Helper

#### Before (Old SQLite-only):
```dart
import 'database_helper.dart';
final dbHelper = DatabaseHelper.instance;
```

#### After (New Drift-based):
```dart
import 'drift_platform_database_helper.dart';
final dbHelper = DriftPlatformDatabaseHelper.instance;
```

### 2. Platform Detection (Optional)
```dart
import 'package:flutter/foundation.dart' show kIsWeb;

if (kIsWeb) {
  print('Running on web - using Drift web storage');
} else {
  print('Running on mobile - using SQLite');
}
```

### 3. Database Operations
```dart
// All existing methods work the same way
final users = await dbHelper.getUsers();
final userId = await dbHelper.insertUser(userData);
final merchantCount = await dbHelper.getMerchantCount();
```

## Database Schema

### Tables Available:
- **Users**: Agent accounts and authentication
- **Merchants**: Merchant information
- **Transactions**: Payment transactions
- **AgentCommissions**: Agent commission tracking
- **Balances**: Account balances
- **Customers**: Customer information
- **Status**: Status definitions
- **AccountSetups**: Account configuration
- And more...

## Migration from Old Database

### Step 1: Update Dependencies
```yaml
dependencies:
  drift: ^2.18.0
  drift_flutter: ^0.1.0
```

### Step 2: Generate Drift Code
```bash
flutter packages pub run build_runner build
```

### Step 3: Update Imports
Replace all imports from:
```dart
import 'database_helper.dart';
```
To:
```dart
import 'drift_platform_database_helper.dart';
```

### Step 4: Update Database Helper References
Replace:
```dart
final dbHelper = DatabaseHelper.instance;
```
With:
```dart
final dbHelper = DriftPlatformDatabaseHelper.instance;
```

## Web Storage Details

### How It Works:
1. **Web Platform**: Drift uses `DriftWebStorage` which creates an IndexedDB database
2. **Mobile Platform**: Drift uses `NativeDatabase` with SQLite
3. **Automatic Detection**: Platform is detected using `kIsWeb`

### Storage Location:
- **Web**: Browser's IndexedDB (persistent across sessions)
- **Mobile**: SQLite database file in app directory

### Data Persistence:
- ✅ **Web**: Data survives page refreshes, browser restarts, and computer reboots
- ✅ **Mobile**: Data survives app restarts and device reboots
- ✅ **Cross-platform**: Same data structure on both platforms

## Performance Benefits

### Web Performance:
- **IndexedDB**: Native browser storage, optimized for web
- **Async Operations**: Non-blocking database operations
- **Efficient Queries**: Drift optimizes queries automatically

### Mobile Performance:
- **SQLite**: Native mobile database, very fast
- **Background Operations**: Database operations don't block UI
- **Memory Efficient**: Only loads data when needed

## Error Handling

### Common Issues and Solutions:

1. **Build Runner Errors**:
   ```bash
   flutter clean
   flutter pub get
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

2. **Web Storage Errors**:
   - Check browser console for IndexedDB errors
   - Ensure HTTPS is used (required for PWA)
   - Clear browser storage if needed

3. **Migration Errors**:
   - Check schema version compatibility
   - Verify table definitions match existing data

## Testing

### Web Testing:
```bash
flutter run -d chrome
# Test data persistence by refreshing the page
```

### Mobile Testing:
```bash
flutter run
# Test normal mobile functionality
```

### Cross-Platform Testing:
1. Test on web browser
2. Test on mobile device
3. Verify data consistency between platforms

## Best Practices

### 1. Database Operations
```dart
// Good: Use try-catch for error handling
try {
  final merchantId = await dbHelper.insertMerchants(merchantData);
  print('Merchant inserted with ID: $merchantId');
} catch (e) {
  print('Error inserting merchant: $e');
}
```

### 2. Platform-Specific Logic
```dart
if (kIsWeb) {
  // Web-specific optimizations
  print('Web platform detected');
} else {
  // Mobile-specific optimizations
  print('Mobile platform detected');
}
```

### 3. Data Validation
```dart
// Validate data before inserting
if (merchantData['name'] != null && merchantData['name'].isNotEmpty) {
  await dbHelper.insertMerchants(merchantData);
}
```

## Troubleshooting

### Common Issues:

1. **"Database not found" errors**:
   - Run `flutter packages pub run build_runner build`
   - Check if database file exists

2. **"Table doesn't exist" errors**:
   - Verify schema version
   - Check migration strategy

3. **Web storage not working**:
   - Ensure HTTPS is enabled
   - Check browser IndexedDB support
   - Clear browser storage

### Debug Commands:
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter packages pub run build_runner build

# Check for errors
flutter analyze
flutter test
```

## Migration Checklist

- [ ] Add Drift dependencies to pubspec.yaml
- [ ] Run `flutter pub get`
- [ ] Generate Drift code with build_runner
- [ ] Update imports to use DriftPlatformDatabaseHelper
- [ ] Test on web platform
- [ ] Test on mobile platform
- [ ] Verify data persistence
- [ ] Update any custom database queries
- [ ] Test error handling
- [ ] Deploy and test in production

## Support

For issues or questions:
1. Check Drift documentation: https://drift.simonbinder.eu/
2. Verify Flutter web support
3. Check browser console for errors
4. Test on different browsers and devices

---

**Drift implementation provides persistent, reliable storage for both web and mobile platforms!** 🎉
