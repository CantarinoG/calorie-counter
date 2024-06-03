import 'package:flutter/material.dart';
import 'package:macro_counter/data/dao.dart';
import 'package:macro_counter/models/meal.dart';
import 'package:macro_counter/providers/object_provider.dart';

class MealProvider with ChangeNotifier implements ObjectProvider<Meal> {
  final Dao<Meal> _mealDao;
  List<Meal> meals = [];

  MealProvider(this._mealDao);

  @override
  List<Meal> get objects {
    return meals;
  }

  @override
  Future<void> loadObjects() async {
    meals = await _mealDao.readAll();
    notifyListeners();
  }

  @override
  Meal? getObject(int id) {
    for (final meal in meals) {
      if (meal.id == id) {
        return meal;
      }
    }
    return null;
  }

  @override
  Future<void> addObject(Meal meal) async {
    await _mealDao.insert(meal);
    await loadObjects();
  }

  @override
  Future<void> updateObject(Meal meal) async {
    await _mealDao.update(meal);
    await loadObjects();
  }

  @override
  Future<void> deleteObject(int id) async {
    await _mealDao.delete(id);
    await loadObjects();
  }

  List<Meal> filterMealsByDay(DateTime targetDay) {
    return meals.where((meal) => isSameDay(meal.datetime, targetDay)).toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
