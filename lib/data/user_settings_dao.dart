import 'package:macro_counter/data/database_helper.dart';
import 'package:macro_counter/data/io_dao.dart';
import 'package:macro_counter/models/user_settings.dart';

class UserSettingsDao implements IoDao<UserSettings> {
  final DatabaseHelper databaseHelper;

  UserSettingsDao(this.databaseHelper);

  @override
  Future<int> insert(UserSettings item) async {
    final database = await databaseHelper.database;
    try {
      await database.setDouble("calorieGoal", item.calorieGoal);
      await database.setDouble("carbGoal", item.carbGoal);
      await database.setDouble("proteinGoal", item.proteinGoal);
      await database.setDouble("fatGoal", item.fatGoal);
      return 1;
    } catch (_) {
      return 0;
    }
  }

  @override
  Future<UserSettings?> read() async {
    final database = await databaseHelper.database;
    final double calorieGoal = database.getDouble("calorieGoal") ?? 2917;
    final double carbGoal = database.getDouble("carbGoal") ?? 255;
    final double proteinGoal = database.getDouble("proteinGoal") ?? 150;
    final double fatGoal = database.getDouble("fatGoal") ?? 138;
    return UserSettings(calorieGoal, carbGoal, proteinGoal, fatGoal);
  }
}
