import 'package:macro_counter/models/food.dart';

class Meal {
  final int id;
  final DateTime datetime;
  final Food food;

  Meal(
    this.id,
    this.datetime,
    this.food,
  );
}
