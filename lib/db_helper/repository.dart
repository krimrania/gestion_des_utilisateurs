import 'package:sqflite/sqflite.dart';
import 'database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  static Database? _database;

  Repository(DatabaseConnection databaseConnection) {
    // Initialize the database connection
    _databaseConnection = DatabaseConnection();
  }

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _databaseConnection.database;
    return _database;
  }

  // Insert data into the table
  Future<void> insertData(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db!.insert(table, data);
  }

  // Read all data from the table
  Future<List<Map<String, dynamic>>> readData(String table) async {
    final db = await database;
    return await db!.query(table);
  }

  // Read data by ID
  Future<Map<String, dynamic>?> readDataById(String table, int itemId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      table,
      where: 'id = ?',
      whereArgs: [itemId],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Update data
  Future<void> updateData(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db!.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  // Delete data by ID
  Future<void> deleteDataById(String table, int itemId) async {
    final db = await database;
    await db!.delete(
      table,
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }
}
