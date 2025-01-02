import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/task.dart';

class DatabaseHelper {
  static const String _dbName = "movieslist.db";
  static const int _dbVersion = 1;
  static const String _tableName = "movielist";

  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type INTEGER NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            isCompleted INTEGER NOT NULL,
            rate TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> addMovie(Task task) async {
    final db = await database;
    return await db.insert(
      _tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateMovie(Task task) async {
    final db = await database;
    return await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteMovie(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> getMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> movieMaps = await db.query(_tableName);
    return movieMaps.map((map) => Task.fromMap(map)).toList();
  }

  Future<void> printDatabaseContents() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(_tableName);
    print("Database Contents:");
    for (var row in data) {
      print(row);
    }
  }
}
