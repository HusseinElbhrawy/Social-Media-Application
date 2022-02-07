import 'package:shared_preferences/shared_preferences.dart';

class CachedHelper {
  static late SharedPreferences _sharedPreferences;

  static initialSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setData({required key, required value}) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    } else if (value is bool) {
      return await _sharedPreferences.setBool(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value).then((value) {
        print(value);
      }).catchError((error) {
        print('Error $error');
      });
    }

    return await _sharedPreferences.setStringList(key, value).then((value) {
      print(value);
    }).catchError((error) {
      print('Error $error');
    });
  }

  static getData({required key}) {
    return _sharedPreferences.get(key);
  }

  static clearData() async {
    return await _sharedPreferences.clear();
  }

  static remove({required key}) async {
    return await _sharedPreferences.remove(key);
  }
}
