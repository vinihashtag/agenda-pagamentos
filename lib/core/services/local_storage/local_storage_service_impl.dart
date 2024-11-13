import 'package:shared_preferences/shared_preferences.dart';

import '../../errors/exceptions.dart';
import '../../utils/logger.dart';
import 'local_storage_service.dart';

class LocalStorageService implements ILocalStorageService {
  final SharedPreferences _sharedPreferences;

  LocalStorageService(this._sharedPreferences);

  @override
  Future<void> setValue<T>(String key, T value) async {
    try {
      if (value is bool) {
        await _sharedPreferences.setBool(key, value);
      } else if (value is double) {
        await _sharedPreferences.setDouble(key, value);
      } else if (value is int) {
        await _sharedPreferences.setInt(key, value);
      } else if (value is List<String>) {
        await _sharedPreferences.setStringList(key, value);
      } else if (value is String) {
        await _sharedPreferences.setString(key, value);
      } else {
        throw Failure(messageError: 'Tipo inválido');
      }
    } catch (e, s) {
      LoggerApp.error('Error on save value in local storage', e, s);
      rethrow;
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      return _sharedPreferences.getBool(key);
    } catch (e, s) {
      LoggerApp.error('Error on get bool in local storage', e, s);
      rethrow;
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (e, s) {
      LoggerApp.error('Error on get double in local storage', e, s);
      rethrow;
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      return _sharedPreferences.getInt(key);
    } catch (e, s) {
      LoggerApp.error('Error on get int in local storage', e, s);
      rethrow;
    }
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    try {
      return _sharedPreferences.getStringList(key);
    } catch (e, s) {
      LoggerApp.error('Error on get list string in local storage', e, s);
      rethrow;
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return _sharedPreferences.getString(key);
    } catch (e, s) {
      LoggerApp.error('Error on get string in local storage', e, s);
      rethrow;
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (e, s) {
      LoggerApp.error('Erro on remove key in local storage', e, s);
      rethrow;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _sharedPreferences.clear();
    } catch (e, s) {
      LoggerApp.error('Error unexpected on clear in local storage', e, s);
      rethrow;
    }
  }
}
