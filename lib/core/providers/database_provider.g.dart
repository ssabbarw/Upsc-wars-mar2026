// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'58c0dfdadcbc0a108c64aaf0223f8cd4379d2d48';

/// Provides the open [Database] instance to the rest of the app.
///
/// Usage in a feature:
/// ```dart
/// final db = await ref.watch(appDatabaseProvider.future);
/// ```
///
/// [keepAlive] keeps the connection open for the app lifetime. [ref.onDispose]
/// must be registered **before** any `await` — otherwise if this provider is
/// disposed while [AppDatabase.instance.database] is still resolving,
/// registering a dispose callback throws [StateError].
///
/// Copied from [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = FutureProvider<Database>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = FutureProviderRef<Database>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
