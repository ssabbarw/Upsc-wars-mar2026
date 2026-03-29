// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_wise_browse_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$topicWiseTagListSourceHash() =>
    r'dd2f33ed4d7a3aa8282c2e3867c972974ddfaa95';

/// Parsed `tagListSource` from [TopicWiseBrowseConstants.configAssetPath].
///
/// Copied from [topicWiseTagListSource].
@ProviderFor(topicWiseTagListSource)
final topicWiseTagListSourceProvider =
    FutureProvider<TopicWiseTagListSource>.internal(
  topicWiseTagListSource,
  name: r'topicWiseTagListSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$topicWiseTagListSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TopicWiseTagListSourceRef = FutureProviderRef<TopicWiseTagListSource>;
String _$topicWiseTagItemsForSubjectHash() =>
    r'a71ec5fe7b1e3ff881e977037347c9029d72dbe5';

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

/// Distinct tags for [subjectId] using the configured list source.
///
/// Copied from [topicWiseTagItemsForSubject].
@ProviderFor(topicWiseTagItemsForSubject)
const topicWiseTagItemsForSubjectProvider = TopicWiseTagItemsForSubjectFamily();

/// Distinct tags for [subjectId] using the configured list source.
///
/// Copied from [topicWiseTagItemsForSubject].
class TopicWiseTagItemsForSubjectFamily
    extends Family<AsyncValue<List<TopicWiseTagItem>>> {
  /// Distinct tags for [subjectId] using the configured list source.
  ///
  /// Copied from [topicWiseTagItemsForSubject].
  const TopicWiseTagItemsForSubjectFamily();

  /// Distinct tags for [subjectId] using the configured list source.
  ///
  /// Copied from [topicWiseTagItemsForSubject].
  TopicWiseTagItemsForSubjectProvider call(
    String subjectId,
  ) {
    return TopicWiseTagItemsForSubjectProvider(
      subjectId,
    );
  }

  @override
  TopicWiseTagItemsForSubjectProvider getProviderOverride(
    covariant TopicWiseTagItemsForSubjectProvider provider,
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
  String? get name => r'topicWiseTagItemsForSubjectProvider';
}

/// Distinct tags for [subjectId] using the configured list source.
///
/// Copied from [topicWiseTagItemsForSubject].
class TopicWiseTagItemsForSubjectProvider
    extends AutoDisposeFutureProvider<List<TopicWiseTagItem>> {
  /// Distinct tags for [subjectId] using the configured list source.
  ///
  /// Copied from [topicWiseTagItemsForSubject].
  TopicWiseTagItemsForSubjectProvider(
    String subjectId,
  ) : this._internal(
          (ref) => topicWiseTagItemsForSubject(
            ref as TopicWiseTagItemsForSubjectRef,
            subjectId,
          ),
          from: topicWiseTagItemsForSubjectProvider,
          name: r'topicWiseTagItemsForSubjectProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$topicWiseTagItemsForSubjectHash,
          dependencies: TopicWiseTagItemsForSubjectFamily._dependencies,
          allTransitiveDependencies:
              TopicWiseTagItemsForSubjectFamily._allTransitiveDependencies,
          subjectId: subjectId,
        );

  TopicWiseTagItemsForSubjectProvider._internal(
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
    FutureOr<List<TopicWiseTagItem>> Function(
            TopicWiseTagItemsForSubjectRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopicWiseTagItemsForSubjectProvider._internal(
        (ref) => create(ref as TopicWiseTagItemsForSubjectRef),
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
  AutoDisposeFutureProviderElement<List<TopicWiseTagItem>> createElement() {
    return _TopicWiseTagItemsForSubjectProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopicWiseTagItemsForSubjectProvider &&
        other.subjectId == subjectId;
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
mixin TopicWiseTagItemsForSubjectRef
    on AutoDisposeFutureProviderRef<List<TopicWiseTagItem>> {
  /// The parameter `subjectId` of this provider.
  String get subjectId;
}

class _TopicWiseTagItemsForSubjectProviderElement
    extends AutoDisposeFutureProviderElement<List<TopicWiseTagItem>>
    with TopicWiseTagItemsForSubjectRef {
  _TopicWiseTagItemsForSubjectProviderElement(super.provider);

  @override
  String get subjectId =>
      (origin as TopicWiseTagItemsForSubjectProvider).subjectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
