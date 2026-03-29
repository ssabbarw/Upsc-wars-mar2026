import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/mcq_seed/data/repositories/mcq_seed_repository_impl.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/entities/mcq_seed_progress.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/usecases/run_mcq_seed_if_needed_usecase.dart';

part 'mcq_seed_controller.g.dart';

/// UI-facing state while bundled MCQs are imported on first launch.
class McqSeedControllerState {
  /// Creates the controller state.
  const McqSeedControllerState({
    this.isWorking = false,
    this.progress,
    this.failure,
  });

  /// Whether a seed or preference check is in progress.
  final bool isWorking;

  /// Latest progress snapshot while [isWorking] is true.
  final McqSeedProgress? progress;

  /// Set when the last [McqSeedController.run] ended with a failure.
  final Failure? failure;
}

/// Orchestrates first-run MCQ import and exposes progress to the splash screen.
@riverpod
class McqSeedController extends _$McqSeedController {
  @override
  McqSeedControllerState build() => const McqSeedControllerState();

  /// Runs the seed use case when preferences do not yet record completion.
  Future<Either<Failure, Unit>> run(
    Database database,
    SharedPreferences preferences,
  ) async {
    final repository = McqSeedRepositoryImpl(
      database: database,
      preferences: preferences,
    );
    if (repository.isSeedMarkedComplete()) {
      return right(unit);
    }

    state = const McqSeedControllerState(isWorking: true);
    final useCase = RunMcqSeedIfNeededUseCase(repository);
    final result = await useCase(
      onProgress: (McqSeedProgress p) => state = McqSeedControllerState(
        isWorking: true,
        progress: p,
      ),
    );
    state = McqSeedControllerState(
      isWorking: false,
      failure: result.fold((f) => f, (_) => null),
    );
    return result;
  }
}
