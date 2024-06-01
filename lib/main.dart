import 'package:flutter/material.dart';
import 'package:macro_counter/data/dao.dart';
import 'package:macro_counter/data/database_helper.dart';
import 'package:macro_counter/data/food_dao.dart';
import 'package:macro_counter/data/io_dao.dart';
import 'package:macro_counter/data/meal_dao.dart';
import 'package:macro_counter/data/shared_preferences_helper.dart';
import 'package:macro_counter/data/sqflite_database_helper.dart';
import 'package:macro_counter/data/user_settings_dao.dart';
import 'package:macro_counter/models/food.dart';
import 'package:macro_counter/models/meal.dart';
import 'package:macro_counter/models/user_settings.dart';
import 'package:macro_counter/providers/food_provider.dart';
import 'package:macro_counter/providers/id_provider.dart';
import 'package:macro_counter/providers/id_provider_dt.dart';
import 'package:macro_counter/providers/io_object_provider.dart';
import 'package:macro_counter/providers/meal_provider.dart';
import 'package:macro_counter/providers/object_provider.dart';
import 'package:macro_counter/providers/user_settings_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper sqfliteHelper = SqfliteDatabaseHelper.instance;
    DatabaseHelper sharedPreferencesHelper = SharedPreferencesHelper.instance;

    String foodTableName = "food";
    String mealTableName = "meal";

    Dao<Food> foodDao = FoodDao(sqfliteHelper, foodTableName);
    Dao<Meal> mealDao = MealDao(sqfliteHelper, mealTableName);
    IoDao<UserSettings> userSettingsDao =
        UserSettingsDao(sharedPreferencesHelper);

    ObjectProvider<Food> foodProvider = FoodProvider(foodDao);
    ObjectProvider<Meal> mealProvider = MealProvider(mealDao);
    IoObjectProvider<UserSettings> userSettingsProvider =
        UserSettingsProvider(userSettingsDao);
    IdProvider idProvider = IdProviderDt();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => foodProvider),
        ChangeNotifierProvider(create: (ctx) => mealProvider),
        ChangeNotifierProvider(create: (ctx) => userSettingsProvider),
        ChangeNotifierProvider(create: (ctx) => idProvider),
      ],
      child: MaterialApp(
        title: 'Macro Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: const Placeholder(),
      ),
    );
  }
}
