// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeNotifierHash() => r'68aa0196eb08b0dfb331ee8552d98449f8b40821';

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
///
/// Copied from [ThemeNotifier].
@ProviderFor(ThemeNotifier)
final themeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeNotifier, ThemeMode>.internal(
  ThemeNotifier.new,
  name: r'themeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeNotifier = AutoDisposeNotifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
