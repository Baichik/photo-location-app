import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> createDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'photos.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_photos (id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lon REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String tableName, Map<String, Object> data) async {
    final db = await DBHelper.createDatabase();
    db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await DBHelper.createDatabase();
    return db.query(tableName);
  }
}
