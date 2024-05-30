abstract class DatabaseHelper<T> {
  DatabaseHelper.privateConstructor();

  static DatabaseHelper? instance;

  Future<T> initDatabase();

  Future<T> get database;

  Future<void> close();
}
