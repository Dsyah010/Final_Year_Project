import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // Or any database package you are using
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const String DB_Name = "Takraw.db";
  static const int Version = 1;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    try {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, DB_Name);
      var db = await openDatabase(path, version: Version, onCreate: _createDB);
      return db;
      //final dbPath = await getDatabasesPath();
      //final path = join(dbPath, filePath);
      //return await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (e) {
      print('Error initializing database: $e');
      throw Exception('Database initialization failed');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    //const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    //const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE users (
        fullName TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        PRIMARY KEY(email)
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }
}
