import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/entities/mcq_seed_progress.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/repositories/mcq_seed_repository.dart';

/// Runs repository seeding once per install unless already marked complete.
class RunMcqSeedIfNeededUseCase {
  /// Creates the use case with a concrete [McqSeedRepository].
  const RunMcqSeedIfNeededUseCase(this._repository);

  final McqSeedRepository _repository;

  /// Seeds when needed and reports [onProgress] from the repository.
  Future<Either<Failure, Unit>> call({
    required void Function(McqSeedProgress progress) onProgress,
  }) async {
    if (_repository.isSeedMarkedComplete()) {
      return right(unit);
    }
    final result = await _repository.seedFromAssetsIfNeeded(
      onProgress: onProgress,
    );
    return await result.fold(
      (f) async => left<Failure, Unit>(f),
      (_) async {
        await _repository.markSeedComplete();
        return right<Failure, Unit>(unit);
      },
    );
  }
}
