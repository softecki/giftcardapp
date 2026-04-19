import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase openConnection(String dbName) {
  // Use IndexedDB storage on web to avoid sql.js requirement
  return LazyDatabase(() async => WebDatabase.withStorage(
        DriftWebStorage.indexedDb(dbName),
      ));
}
