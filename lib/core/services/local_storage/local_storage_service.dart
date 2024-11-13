abstract class ILocalStorageService {
  Future<void> setValue<T>(String key, T value);
  Future<int?> getInt(String key);
  Future<double?> getDouble(String key);
  Future<bool?> getBool(String key);
  Future<String?> getString(String key);
  Future<List<String>?> getStringList(String key);
  Future<void> remove(String key);
  Future<void> clear();
}
