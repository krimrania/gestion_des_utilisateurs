import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db_crud.db');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
     await database.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY,
       name TEXT,
       contact TEXT,
        description TEXT
        )
        ''');
    
  }
   // ignore: recursive_getters
   Database get database => database;
}
