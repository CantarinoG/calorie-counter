import 'package:macro_counter/data/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper implements DatabaseHelper {
  static final SharedPreferencesHelper instance =
      SharedPreferencesHelper._privateConstructor();
  SharedPreferences? _database;

  SharedPreferencesHelper._privateConstructor();

  @override
  Future<SharedPreferences> initDatabase() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<SharedPreferences> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  @override
  Future<void> close() async {
    _database = null;
  }
}
