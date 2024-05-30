import 'package:macro_counter/data/dao.dart';
import 'package:macro_counter/data/database_helper.dart';
import 'package:macro_counter/models/meal.dart';
import 'package:sqflite/sqflite.dart';

class MealDao implements Dao<Meal> {
  final DatabaseHelper databaseHelper;
  final String tableName;

  MealDao(this.databaseHelper, this.tableName);

  @override
  Future<int> insert(Meal item) async {
    final database = await databaseHelper.database;
    return await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<Meal?> read(int id) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Meal.fromMap(maps.first);
  }

  @override
  Future<List<Meal>> readAll() async {
    final database = await databaseHelper.database;
    final maps = await database.query(tableName);
    return List.generate(maps.length, (i) => Meal.fromMap(maps[i]));
  }

  @override
  Future<int> update(Meal item) async {
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
