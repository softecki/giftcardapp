import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

/// Registers the sqflite web worker factory.
/// Requires `web/sqflite_sw.js` and `web/sqlite3.wasm` from
/// `dart run sqflite_common_ffi_web:setup`.
void initSqfliteForWeb() {
  databaseFactory = databaseFactoryFfiWeb;
}
