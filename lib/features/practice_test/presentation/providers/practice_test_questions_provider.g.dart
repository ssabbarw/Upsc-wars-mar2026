// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_test_questions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$practiceTestQuestionsHash() =>
    r'cbc558df2fe4614e5b9eb71051f98e05b88be02b';

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

/// Loads one 25-question block for the practice UI.
///
/// Copied from [practiceTestQuestions].
@ProviderFor(practiceTestQuestions)
const practiceTestQuestionsProvider = PracticeTestQuestionsFamily();

/// Loads one 25-question block for the practice UI.
///
/// Copied from [practiceTestQuestions].
class PracticeTestQuestionsFamily
    extends Family<AsyncValue<List<PracticeQuestion>>> {
  /// Loads one 25-question block for the practice UI.
  ///
  /// Copied from [practiceTestQuestions].
  const PracticeTestQuestionsFamily();

  /// Loads one 25-question block for the practice UI.
  ///
  /// Copied from [practiceTestQuestions].
  PracticeTestQuestionsProvider call(
    String subjectId,
    int testNumber,
  ) {
    return PracticeTestQuestionsProvider(
      subjectId,
      testNumber,
    );
  }

  @override
  PracticeTestQuestionsProvider getProviderOverride(
    covariant PracticeTestQuestionsProvider provider,
  ) {
    return call(
      provider.subjectId,
      provider.testNumber,
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
  String? get name => r'practiceTestQuestionsProvider';
}

/// Loads one 25-question block for the practice UI.
///
/// Copied from [practiceTestQuestions].
class PracticeTestQuestionsProvider
    extends AutoDisposeFutureProvider<List<PracticeQuestion>> {
  /// Loads one 25-question block for the practice UI.
  ///
  /// Copied from [practiceTestQuestions].
  PracticeTestQuestionsProvider(
    String subjectId,
    int testNumber,
  ) : this._internal(
          (ref) => practiceTestQuestions(
            ref as PracticeTestQuestionsRef,
            subjectId,
            testNumber,
          ),
          from: practiceTestQuestionsProvider,
          name: r'practiceTestQuestionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$practiceTestQuestionsHash,
          dependencies: PracticeTestQuestionsFamily._dependencies,
          allTransitiveDependencies:
              PracticeTestQuestionsFamily._allTransitiveDependencies,
          subjectId: subjectId,
          testNumber: testNumber,
        );

  PracticeTestQuestionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subjectId,
    required this.testNumber,
  }) : super.internal();

  final String subjectId;
  final int testNumber;

  @override
  Override overrideWith(
    FutureOr<List<PracticeQuestion>> Function(PracticeTestQuestionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PracticeTestQuestionsProvider._internal(
        (ref) => create(ref as PracticeTestQuestionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subjectId: subjectId,
        testNumber: testNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PracticeQuestion>> createElement() {
    return _PracticeTestQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PracticeTestQuestionsProvider &&
        other.subjectId == subjectId &&
        other.testNumber == testNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subjectId.hashCode);
    hash = _SystemHash.combine(hash, testNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PracticeTestQuestionsRef
    on AutoDisposeFutureProviderRef<List<PracticeQuestion>> {
  /// The parameter `subjectId` of this provider.
  String get subjectId;

  /// The parameter `testNumber` of this provider.
  int get testNumber;
}

class _PracticeTestQuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<PracticeQuestion>>
    with PracticeTestQuestionsRef {
  _PracticeTestQuestionsProviderElement(super.provider);

  @override
  String get subjectId => (origin as PracticeTestQuestionsProvider).subjectId;
  @override
  int get testNumber => (origin as PracticeTestQuestionsProvider).testNumber;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
