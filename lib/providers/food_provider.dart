import 'package:flutter/material.dart';
import 'package:macro_counter/data/dao.dart';
import 'package:macro_counter/models/food.dart';
import 'package:macro_counter/providers/object_provider.dart';

class FoodProvider with ChangeNotifier implements ObjectProvider<Food> {
  final Dao<Food> _foodDao;
  List<Food> foods = [];

  FoodProvider(this._foodDao);

  void sortList() {
    foods.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  @override
  List<Food> get objects {
    return foods;
  }

  List<Food> get validObjects {
    return foods.where((food) => !food.isDeleted).toList();
  }

  @override
  Future<void> loadObjects() async {
    foods = await _foodDao.readAll();
    sortList();
    notifyListeners();
  }

  @override
  Food? getObject(int id) {
    for (final food in foods) {
      if (food.id == id) {
        return food;
      }
    }
    return null;
  }

  @override
  Future<void> addObject(Food food) async {
    await _foodDao.insert(food);
    await loadObjects();
  }

  @override
  Future<void> updateObject(Food food) async {
    await _foodDao.update(food);
    await loadObjects();
  }

  @override
  Future<void> deleteObject(int id) async {
    await _foodDao.delete(id);
    await loadObjects();
  }
}
