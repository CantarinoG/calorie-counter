abstract class IoDao<T> {
  Future<int> insert(T item);
  Future<T?> read();
}
