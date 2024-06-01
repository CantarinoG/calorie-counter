import 'package:flutter/material.dart';
import 'package:macro_counter/data/dao.dart';

abstract class IoObjectProvider<T> with ChangeNotifier {
  IoObjectProvider(Dao dao);
  Future<T?> get object;
  Future<void> addObject(T object);
}
