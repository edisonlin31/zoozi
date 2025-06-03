import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/cache_manager.dart';

final languageProvider = StateNotifierProvider<LanguageController, Locale>((
  ref,
) {
  return LanguageController();
});

class LanguageController extends StateNotifier<Locale> {
  LanguageController() : super(const Locale('system')) {
    _loadLanguageFromCache();
  }

  Future<void> setLanguage(Locale locale) async {
    state = locale;
    await CacheManager.save(CacheConstants.languageKey, locale.languageCode);
  }

  Future<void> _loadLanguageFromCache() async {
    final cachedLanguage = await CacheManager.retrieve(
      CacheConstants.languageKey,
    );
    if (cachedLanguage != null) {
      switch (cachedLanguage) {
        case 'en':
          state = const Locale('en');
          break;
        case 'id':
          state = const Locale('id');
          break;
        default:
          state = const Locale('system');
      }
    } else {
      state = const Locale('system'); // Default to system if no cache is found
    }
  }
}
