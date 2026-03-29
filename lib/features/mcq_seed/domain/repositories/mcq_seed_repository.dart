import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/entities/mcq_seed_progress.dart';

/// Writes bundled English MCQs from assets into SQLite when first needed.
abstract class McqSeedRepository {
  /// Whether a previous successful seed has been recorded in preferences.
  bool isSeedMarkedComplete();

  /// Inserts MCQs from assets if [isSeedMarkedComplete] is false.
  ///
  /// [onProgress] is invoked on the calling isolate after each file slot
  /// (including missing files) so the UI can update percentages.
  Future<Either<Failure, Unit>> seedFromAssetsIfNeeded({
    required void Function(McqSeedProgress progress) onProgress,
  });

  /// Persists the “seed complete” flag so future launches skip import.
  Future<void> markSeedComplete();
}
