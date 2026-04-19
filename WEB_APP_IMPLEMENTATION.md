# Web App Implementation Guide

This document describes the web app implementation for the Malipo Agent Payment App, including PWA support and platform-aware database handling.

## Features Implemented

### 1. Platform-Aware Database Support

The app now automatically detects the platform and uses the appropriate database:

- **Web Platform**: Uses IndexedDB via `idb_shim` package
- **Mobile Platform**: Uses SQLite via `sqflite` package

#### Key Files:
- `lib/src/data/platform_database_helper.dart` - Platform-aware database helper
- `lib/src/data/database_usage_example.dart` - Usage examples

#### Usage:
```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'platform_database_helper.dart';

// The database helper automatically detects platform
final dbHelper = PlatformDatabaseHelper.instance;

if (kIsWeb) {
  // Uses IndexedDB on web
  print('Running on web - using IndexedDB');
} else {
  // Uses SQLite on mobile
  print('Running on mobile - using SQLite');
}

// All existing database operations work the same way
final users = await dbHelper.getUsers();
final userId = await dbHelper.insertUser(userData);
```

### 2. Progressive Web App (PWA) Support

#### Manifest Configuration
- **File**: `web/manifest.json`
- **Features**:
  - Standalone display mode
  - Custom app name and description
  - Proper icons and theme colors
  - PWA categories and screenshots

#### Install Prompt
- **File**: `web/index.html`
- **Features**:
  - Automatic install prompt after 3 seconds
  - Custom install banner with dismiss option
  - Service worker registration
  - Proper PWA meta tags

#### PWA Features:
- ✅ Installable on desktop and mobile
- ✅ Standalone app experience
- ✅ Offline capability (via service worker)
- ✅ Custom install prompt
- ✅ Proper app icons and branding

### 3. Dependencies Added

#### AgentpaymentApp/pubspec.yaml:
```yaml
dependencies:
  sqflite: ^2.4.2
  sqflite_common_ffi: ^2.3.0  # For web SQLite support
  idb_shim: ^2.3.0            # For IndexedDB support
  path: ^1.9.1
```

## Migration Guide

### Replacing Existing Database Usage

1. **Update imports**:
   ```dart
   // OLD
   import 'database_helper.dart';
   final dbHelper = DatabaseHelper.instance;
   
   // NEW
   import 'platform_database_helper.dart';
   final dbHelper = PlatformDatabaseHelper.instance;
   ```

2. **No code changes needed** - All existing database operations work the same way

3. **Platform detection** (optional):
   ```dart
   import 'package:flutter/foundation.dart' show kIsWeb;
   
   if (kIsWeb) {
     // Web-specific logic
   } else {
     // Mobile-specific logic
   }
   ```

## Building for Web

### Development:
```bash
flutter run -d chrome
```

### Production Build:
```bash
flutter build web --release
```

### Testing PWA Features:
1. Build the app: `flutter build web`
2. Serve the build folder with a web server
3. Open in Chrome/Edge
4. Look for install prompt after 3 seconds
5. Test offline functionality

## Browser Support

### PWA Install Support:
- ✅ Chrome/Edge (Android, Windows, macOS)
- ✅ Safari (iOS 11.3+)
- ✅ Firefox (Android)
- ⚠️ Limited support on older browsers

### IndexedDB Support:
- ✅ All modern browsers
- ✅ Chrome, Firefox, Safari, Edge
- ⚠️ Limited on very old browsers

## Troubleshooting

### Common Issues:

1. **Database not working on web**:
   - Ensure `idb_shim` is added to dependencies
   - Check browser console for IndexedDB errors
   - Verify service worker is registered

2. **PWA install prompt not showing**:
   - Ensure manifest.json is properly configured
   - Check that app meets PWA criteria
   - Verify HTTPS is used (required for PWA)

3. **Build errors**:
   - Run `flutter clean` and `flutter pub get`
   - Check for dependency conflicts
   - Verify Flutter web support is enabled

### Debug Commands:
```bash
# Check Flutter web support
flutter doctor

# Clean and rebuild
flutter clean
flutter pub get
flutter build web

# Run in debug mode
flutter run -d chrome --web-renderer html
```

## Security Considerations

1. **HTTPS Required**: PWA features require HTTPS in production
2. **Service Worker**: Automatically handles caching and offline support
3. **Data Storage**: IndexedDB data is sandboxed per origin
4. **Permissions**: PWA can request device permissions when needed

## Performance Notes

1. **IndexedDB**: Generally faster than SQLite for web
2. **Caching**: Service worker provides automatic caching
3. **Bundle Size**: Web build includes both database implementations
4. **Memory**: IndexedDB uses browser's storage quota

## Next Steps

1. **Test thoroughly** on both web and mobile platforms
2. **Update existing code** to use `PlatformDatabaseHelper`
3. **Configure HTTPS** for production deployment
4. **Test PWA installation** on various devices
5. **Monitor performance** and optimize as needed

## Support

For issues or questions:
1. Check browser console for errors
2. Verify all dependencies are installed
3. Test on different browsers and devices
4. Review Flutter web documentation
