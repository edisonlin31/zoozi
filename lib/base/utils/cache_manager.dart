import 'package:shared_preferences/shared_preferences.dart';

class CacheConstants {
  CacheConstants._();
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String accessToken = 'access_token';
}

class CacheManager {
  CacheManager._();

  static Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> retrieve(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
