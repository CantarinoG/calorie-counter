import 'package:macro_counter/data/database_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseHelper implements DatabaseHelper {
  static const String _databaseName = "calorie_counter.db";
  static final SqfliteDatabaseHelper instance =
      SqfliteDatabaseHelper._privateConstructor();
  Database? _database;

  SqfliteDatabaseHelper._privateConstructor();

  @override
  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, _databaseName),
      version: 1,
      onCreate: (db, _) {
        return db.execute(
            "CREATE TABLE IF NOT EXISTS food ( id INTEGER PRIMARY KEY, name TEXT NOT NULL, calories REAL, carbs REAL, proteins REAL, fats REAL, isDeleted BOOLEAN DEFAULT FALSE );" +
                "CREATE TABLE IF NOT EXISTS meal ( id INTEGER PRIMARY KEY, datetime DATETIME NOT NULL, quantity REAL NOT NULL,foodId INTEGER NOT NULL);");
      },
    );
  }

  @override
  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  @override
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
