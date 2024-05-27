import 'package:liste_elements/models/liste_element.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CruddataBase {
  static final CruddataBase _instance = CruddataBase._internal();
  factory CruddataBase() => _instance;
  CruddataBase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'element.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE liste_element(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nom TEXT NOT NULL,
      description TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertElement(ListeElement element) async {
    final db = await database;
    return await db.insert('liste_element', element.toMap());
  }

  Future<void> updateElement(ListeElement element) async {
    final db = await database;
    await db.update(
      'liste_element',
      element.toMap(),
      where: 'id = ?',
      whereArgs: [element.id],
    );
  }

  Future<void> deleteElement(int id) async {
    final db = await database;
    await db.delete(
      'liste_element',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ListeElement>> getListeElement() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('liste_element');
    return List.generate(maps.length, (i) {
      return ListeElement(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        description: maps[i]['description'],
      );
    });
  }

  Future<ListeElement?> getElementWithId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'liste_element',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ListeElement(
        id: maps[0]['id'],
        nom: maps[0]['nom'],
        description: maps[0]['description'],
      );
    } else {
      return null;
    }
  }
}
