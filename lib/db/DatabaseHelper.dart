import 'package:flutter_to_do_app/model/Todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;


//DatabaseHelper provides functionality to interact with a SQLite database for todos
class DatabaseHelper {
  static const _databaseName = 'todo.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  // Returns the database instance, creating it if it doesn't exist
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
// Initializes the database and returns the instance
  Future<Database> _initDatabase() async {
    final directory = await pathProvider.getApplicationDocumentsDirectory();
    final dbPath = path.join(directory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Creates the 'todos' table when the database is created
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        is_completed INTEGER
      )
    ''');
  }
// Retrieves all todos from the database and returns a list of To_do objects
  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query('todos');
    return List.generate(maps.length, (index) {
      return Todo(
        id: maps[index]['id'] as int,
        title: maps[index]['title'] as String,
        description: maps[index]['description'] as String,
        isCompleted: maps[index]['is_completed'] == 1,
      );
    });
  }
// Inserts a new to_do into the 'to_dos' table
  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      'todos',
      {
        'title': todo.title,
        'description': todo.description,
        'is_completed': todo.isCompleted ? 1 : 0,
      },
    );
  }
// Updates an existing to_do in the 'todos' table
  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'todos',
      {
        'title': todo.title,
        'description': todo.description,
        'is_completed': todo.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
// Deletes a to_do from the 'todos' table based on its ID
  Future<void> deleteTodoById(int id) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}