// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_tests_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subjectTestsListHash() => r'57bb93c6717b6a00bf1b417da5068786da297759';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Practice tests (25 questions each) for a subject, from local SQLite.
///
/// Copied from [subjectTestsList].
@ProviderFor(subjectTestsList)
const subjectTestsListProvider = SubjectTestsListFamily();

/// Practice tests (25 questions each) for a subject, from local SQLite.
///
/// Copied from [subjectTestsList].
class SubjectTestsListFamily extends Family<AsyncValue<List<SubjectTestInfo>>> {
  /// Practice tests (25 questions each) for a subject, from local SQLite.
  ///
  /// Copied from [subjectTestsList].
  const SubjectTestsListFamily();

  /// Practice tests (25 questions each) for a subject, from local SQLite.
  ///
  /// Copied from [subjectTestsList].
  SubjectTestsListProvider call(
    String subjectId,
  ) {
    return SubjectTestsListProvider(
      subjectId,
    );
  }

  @override
  SubjectTestsListProvider getProviderOverride(
    covariant SubjectTestsListProvider provider,
  ) {
    return call(
      provider.subjectId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'subjectTestsListProvider';
}

/// Practice tests (25 questions each) for a subject, from local SQLite.
///
/// Copied from [subjectTestsList].
class SubjectTestsListProvider
    extends AutoDisposeFutureProvider<List<SubjectTestInfo>> {
  /// Practice tests (25 questions each) for a subject, from local SQLite.
  ///
  /// Copied from [subjectTestsList].
  SubjectTestsListProvider(
    String subjectId,
  ) : this._internal(
          (ref) => subjectTestsList(
            ref as SubjectTestsListRef,
            subjectId,
          ),
          from: subjectTestsListProvider,
          name: r'subjectTestsListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subjectTestsListHash,
          dependencies: SubjectTestsListFamily._dependencies,
          allTransitiveDependencies:
              SubjectTestsListFamily._allTransitiveDependencies,
          subjectId: subjectId,
        );

  SubjectTestsListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subjectId,
  }) : super.internal();

  final String subjectId;

  @override
  Override overrideWith(
    FutureOr<List<SubjectTestInfo>> Function(SubjectTestsListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubjectTestsListProvider._internal(
        (ref) => create(ref as SubjectTestsListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subjectId: subjectId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SubjectTestInfo>> createElement() {
    return _SubjectTestsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubjectTestsListProvider && other.subjectId == subjectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subjectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubjectTestsListRef
    on AutoDisposeFutureProviderRef<List<SubjectTestInfo>> {
  /// The parameter `subjectId` of this provider.
  String get subjectId;
}

class _SubjectTestsListProviderElement
    extends AutoDisposeFutureProviderElement<List<SubjectTestInfo>>
    with SubjectTestsListRef {
  _SubjectTestsListProviderElement(super.provider);

  @override
  String get subjectId => (origin as SubjectTestsListProvider).subjectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
