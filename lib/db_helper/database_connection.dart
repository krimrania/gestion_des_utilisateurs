import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await openDatabase(
      'app_database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            name TEXT,
            contact TEXT,
            description TEXT
          )
        ''');
      },
    );

    return _database;
  }
}
