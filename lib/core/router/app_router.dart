import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upsc_wars_new/features/home/presentation/pages/home_page.dart';
import 'package:upsc_wars_new/features/splash/presentation/pages/splash_page.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_test_outcome.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/pages/practice_test_page.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/pages/practice_test_results_page.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/pages/practice_test_review_page.dart';
import 'package:upsc_wars_new/features/subject_tests/presentation/pages/subject_test_list_page.dart';

part 'app_router.g.dart';

/// Named routes — always use [AppRoute.xxx.name] with [context.goNamed] so
/// that path changes never break call sites.
enum AppRoute {
  splash,
  home,
  subjectTests,
  practiceTestRun,
  practiceTestResults,
  practiceTestReview,
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/subject/:subjectId/tests',
        name: AppRoute.subjectTests.name,
        builder: (context, state) {
          final subjectId = state.pathParameters['subjectId']!;
          return SubjectTestListPage(subjectId: subjectId);
        },
      ),
      GoRoute(
        path: '/subject/:subjectId/tests/:testNumber/run',
        name: AppRoute.practiceTestRun.name,
        builder: (context, state) {
          final subjectId = state.pathParameters['subjectId']!;
          final testNumber = int.parse(state.pathParameters['testNumber']!);
          return PracticeTestPage(
            subjectId: subjectId,
            testNumber: testNumber,
          );
        },
      ),
      GoRoute(
        path: '/subject/:subjectId/tests/:testNumber/results',
        name: AppRoute.practiceTestResults.name,
        builder: (context, state) {
          final extra = state.extra;
          return PracticeTestResultsPage(
            outcome: extra is PracticeTestOutcome ? extra : null,
          );
        },
      ),
      GoRoute(
        path: '/practice/review',
        name: AppRoute.practiceTestReview.name,
        builder: (context, state) {
          final extra = state.extra;
          return PracticeTestReviewPage(
            outcome: extra is PracticeTestOutcome ? extra : null,
          );
        },
      ),
    ],
  );
}
