import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;
  static const String is_dark_mode = "is_dark_mode";
  static const String language_code = "language_code";
  static const String current_Level = "current_level";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme module
  Future<void> changeTheme(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(is_dark_mode, value);
    });
  }

  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(is_dark_mode) ?? false;
    });
  }

  //Locale module
  Future<void> changeLanguage(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(language_code, value);
    });
  }

  Future<String> get appLocale {
    return _sharedPreference.then((prefs) {
      return prefs.getString(language_code);
    });
  }

  //example module
  Future<void> changeLevel(int value) {
    return _sharedPreference.then((prefs) {
      return prefs.setInt(current_Level, value);
    });
  }

  Future<int> get currentLevel {
    return _sharedPreference.then((prefs) {
      return prefs.getInt(current_Level);
    });
  }
}
