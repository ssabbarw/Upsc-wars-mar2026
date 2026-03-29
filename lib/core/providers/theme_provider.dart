import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

const _kThemeModeKey = 'theme_mode';

/// Manages the app's [ThemeMode] and persists the user's preference.
///
/// Usage:
/// ```dart
/// // Read current mode
/// final mode = ref.watch(themeNotifierProvider);
///
/// // Change mode
/// ref.read(themeNotifierProvider.notifier).setThemeMode(ThemeMode.dark);
///
/// // Toggle light ↔ dark (ignores system)
/// ref.read(themeNotifierProvider.notifier).toggle();
/// ```
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    _loadSaved();
    return ThemeMode.system;
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemeModeKey);
    if (saved != null) {
      state = ThemeMode.values.firstWhere(
        (m) => m.name == saved,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeModeKey, mode.name);
  }

  /// Toggles between light and dark. If currently system, switches to light.
  Future<void> toggle() async {
    await setThemeMode(
      state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
