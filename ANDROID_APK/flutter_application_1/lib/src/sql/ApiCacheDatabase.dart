import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class ApiCacheDatabase {
  static final ApiCacheDatabase _singleton = ApiCacheDatabase._internal();

  factory ApiCacheDatabase() {
    return _singleton;
  }

  ApiCacheDatabase._internal();

  late Database _database;

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final pathToDatabase = path.join(databasesPath, 'api_cache.db');

    _database = await openDatabase(pathToDatabase, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS api_cache (url TEXT PRIMARY KEY, data TEXT)',
      );
    });
  }

  Future<String?> getCache(String url) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'api_cache',
      where: 'url = ?',
      whereArgs: [url],
    );

    if (maps.isNotEmpty) {
      return maps.first['data'] as String;
    } else {
      return null;
    }
  }

  Future<void> insertOrUpdateCache(String url, String data) async {
    await _database.insert(
      'api_cache',
      {'url': url, 'data': data},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
