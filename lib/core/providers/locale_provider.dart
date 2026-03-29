import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

const _kLocaleKey = 'locale';

/// Supported app locales.
abstract final class AppLocales {
  static const english = Locale('en');
  static const hindi = Locale('hi');

  static const all = [english, hindi];

  static Locale fromCode(String code) =>
      all.firstWhere((l) => l.languageCode == code, orElse: () => english);
}

/// Manages the app's [Locale] and persists the user's preference.
///
/// Usage:
/// ```dart
/// // Read current locale
/// final locale = ref.watch(localeNotifierProvider);
///
/// // Change locale
/// ref.read(localeNotifierProvider.notifier).setLocale(AppLocales.hindi);
/// ```
@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    _loadSaved();
    return AppLocales.english;
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kLocaleKey);
    if (saved != null) {
      state = AppLocales.fromCode(saved);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, locale.languageCode);
  }
}
