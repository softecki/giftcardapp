import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase openConnection(String dbName) {
  // sql.js (sql-wasm.js / sql-wasm.wasm) plus IndexedDB persistence.
  return LazyDatabase(() async => WebDatabase.withStorage(
        DriftWebStorage.indexedDb(dbName),
      ));
}
