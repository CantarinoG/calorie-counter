import 'package:flutter/material.dart';
import 'package:macro_counter/data/dao.dart';

abstract class ObjectProvider<T> with ChangeNotifier {
  ObjectProvider(Dao dao);
  List<T> get objects;
  Future<void> loadObjects();
  T? getObject(int id);
  Future<void> addObject(T object);
  Future<void> updateObject(T object);
  Future<void> deleteObject(int id);
}
