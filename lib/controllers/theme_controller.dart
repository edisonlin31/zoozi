import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/cache_manager.dart';

final themeProvider = StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  return ThemeController();
});

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system) {
    _loadThemeFromCache();
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    await CacheManager.save(CacheConstants.themeKey, themeMode.name);
  }

  Future<void> _loadThemeFromCache() async {
    final cachedTheme = await CacheManager.retrieve(CacheConstants.themeKey);
    if (cachedTheme != null) {
      switch (cachedTheme) {
        case 'light':
          state = ThemeMode.light;
          break;
        case 'dark':
          state = ThemeMode.dark;
          break;
        default:
          state = ThemeMode.system;
      }
    } else {
      state = ThemeMode.system; // Default to system if no cache is found
    }
  }
}
