import 'package:macro_counter/data/dao.dart';
import 'package:macro_counter/data/database_helper.dart';
import 'package:macro_counter/models/food.dart';
import 'package:sqflite/sqflite.dart';

class FoodDao implements Dao<Food> {
  final DatabaseHelper databaseHelper;
  final String tableName;

  FoodDao(this.databaseHelper, this.tableName);

  @override
  Future<int> insert(Food item) async {
    final database = await databaseHelper.database;
    return await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<Food?> read(int id) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;

    return Food.fromMap(maps.first);
  }

  @override
  Future<List<Food>> readAll() async {
    final database = await databaseHelper.database;
    final maps = await database.query(tableName);
    return List.generate(maps.length, (i) => Food.fromMap(maps[i]));
  }

  @override
  Future<int> update(Food item) async {
    final database = await databaseHelper.database;
    return await database.update(
      tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final database = await databaseHelper.database;
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
