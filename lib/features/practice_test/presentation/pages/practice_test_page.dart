import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upsc_wars_new/core/constants/practice_test_config.dart';
import 'package:upsc_wars_new/core/providers/database_provider.dart';
import 'package:upsc_wars_new/core/router/app_router.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/practice_test/data/repositories/practice_test_repository_impl.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_question.dart';
import 'package:upsc_wars_new/features/practice_test/domain/usecases/build_practice_test_outcome.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/providers/practice_test_questions_provider.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/widgets/practice_mcq_table.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/widgets/practice_test_control_bar.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/widgets/practice_test_summary_sheet.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Live 25-question practice session with timer and palette navigation.
class PracticeTestPage extends HookConsumerWidget {
  /// Creates a session for [testNumber] (1-based) under [subjectId].
  const PracticeTestPage({
    super.key,
    required this.subjectId,
    required this.testNumber,
  });

  final String subjectId;
  final int testNumber;

  static String _fmtRemaining(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncQuestions = ref.watch(
      practiceTestQuestionsProvider(subjectId, testNumber),
    );

    return asyncQuestions.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
            child: Text(
              e is StateError ? e.message : l10n.practiceTestLoadError,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      data: (questions) => _PracticeTestLoaded(
        subjectId: subjectId,
        testNumber: testNumber,
        questions: questions,
        l10n: l10n,
        fmtRemaining: _fmtRemaining,
      ),
    );
  }
}

class _PracticeTestLoaded extends HookConsumerWidget {
  const _PracticeTestLoaded({
    required this.subjectId,
    required this.testNumber,
    required this.questions,
    required this.l10n,
    required this.fmtRemaining,
  });

  final String subjectId;
  final int testNumber;
  final List<PracticeQuestion> questions;
  final AppLocalizations l10n;
  final String Function(Duration) fmtRemaining;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = questions.length;
    final startedAt = useRef(DateTime.now());
    final submitted = useRef(false);

    final currentIndex = useState(0);
    final answers = useState<Map<int, String?>>({});
    final skippedIndices = useState<Set<int>>({});
    final revisitIndices = useState<Set<int>>({});
    final bookmarkByOverall = useState<Map<int, bool>>({});
    final locked = useState(false);
    final remaining = useState(PracticeTestConfig.testDuration);

    useEffect(() {
      final m = <int, bool>{};
      for (final q in questions) {
        m[q.overallQueNo] = q.bookmarked;
      }
      bookmarkByOverall.value = m;
      return null;
    }, [questions]);

    void submitSession() {
      if (submitted.value) return;
      submitted.value = true;
      locked.value = true;
      if (!context.mounted) {
        return;
      }

      final elapsed = DateTime.now().difference(startedAt.value);
      final capped = elapsed > PracticeTestConfig.testDuration
          ? PracticeTestConfig.testDuration
          : elapsed;

      final outcome = BuildPracticeTestOutcomeUseCase()(
        subjectId: subjectId,
        testNumber: testNumber,
        questions: questions,
        answersByIndex: Map<int, String?>.from(answers.value),
        timeTaken: capped,
      );

      context.pushReplacementNamed(
        AppRoute.practiceTestResults.name,
        pathParameters: {
          'subjectId': subjectId,
          'testNumber': '$testNumber',
        },
        extra: outcome,
      );
    }

    Future<void> confirmSubmit() async {
      if (locked.value || submitted.value) return;
      final go = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.practiceTestSubmitConfirmTitle),
          content: Text(l10n.practiceTestSubmitConfirmMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.practiceTestSubmitConfirmCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.practiceTestSubmitConfirmSubmit),
            ),
          ],
        ),
      );
      if (go == true && context.mounted) {
        submitSession();
      }
    }

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (submitted.value) return;
        final elapsed = DateTime.now().difference(startedAt.value);
        final left = PracticeTestConfig.testDuration - elapsed;
        if (left <= Duration.zero) {
          remaining.value = Duration.zero;
          submitSession();
        } else {
          remaining.value = left;
        }
      });
      return () {
        timer.cancel();
      };
    }, const []);

    Future<void> toggleBookmark() async {
      if (locked.value) return;
      final q = questions[currentIndex.value];
      final next = !(bookmarkByOverall.value[q.overallQueNo] ?? false);
      final db = await ref.read(appDatabaseProvider.future);
      final repo = PracticeTestRepositoryImpl(db);
      final res = await repo.setBookmarked(
        overallQueNo: q.overallQueNo,
        bookmarked: next,
      );
      if (!context.mounted) return;
      res.fold((_) {}, (_) {
        bookmarkByOverall.value = {
          ...bookmarkByOverall.value,
          q.overallQueNo: next,
        };
      });
    }

    void selectOption(String letter) {
      if (locked.value) return;
      final i = currentIndex.value;
      final lower = letter.toLowerCase();
      answers.value = {...answers.value, i: lower};
      skippedIndices.value = {...skippedIndices.value}..remove(i);
    }

    void goNext() {
      if (locked.value) return;
      final i = currentIndex.value;
      if (answers.value[i] == null) {
        skippedIndices.value = {...skippedIndices.value, i};
      }
      if (i < n - 1) {
        currentIndex.value = i + 1;
      }
    }

    void goPrev() {
      if (locked.value) return;
      if (currentIndex.value > 0) {
        currentIndex.value = currentIndex.value - 1;
      }
    }

    void openPalette() {
      final answered = <int>{};
      for (final e in answers.value.entries) {
        if (e.value != null) answered.add(e.key);
      }
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (ctx) => PracticeTestSummarySheet(
          total: n,
          currentIndex: currentIndex.value,
          answeredIndices: answered,
          skippedIndices: skippedIndices.value,
          revisitIndices: revisitIndices.value,
          onPick: (ix) {
            Navigator.of(ctx).pop();
            currentIndex.value = ix;
          },
          l10n: l10n,
        ),
      );
    }

    void setRevisitForCurrent(bool marked) {
      if (locked.value) return;
      final i = currentIndex.value;
      final next = {...revisitIndices.value};
      if (marked) {
        next.add(i);
      } else {
        next.remove(i);
      }
      revisitIndices.value = next;
    }

    final q = questions[currentIndex.value];
    final scheme = Theme.of(context).colorScheme;
    final selected = answers.value[currentIndex.value];
    final timerParts = fmtRemaining(remaining.value).split(':');

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.practiceTestProgress(currentIndex.value + 1, n),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: context.sp(19),
                ),
          ),
          actions: [
            IconButton(
              onPressed: locked.value ? null : openPalette,
              icon: const Icon(Icons.grid_view_rounded),
              tooltip: l10n.practiceTestSummary,
            ),
            SizedBox(width: context.wp(1)),
          ],
        ),
        body: Column(
          children: [
            if (locked.value)
              Material(
                color: scheme.errorContainer.withValues(alpha: 0.35),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.hp(1),
                      horizontal: context.wp(4),
                    ),
                    child: Text(
                      l10n.practiceTestTimeUp,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
            PracticeTestControlBar(
              l10n: l10n,
              locked: locked.value,
              remaining: remaining.value,
              isMarkedRevisit:
                  revisitIndices.value.contains(currentIndex.value),
              onRevisitMarked: setRevisitForCurrent,
              onSubmit: () {
                confirmSubmit();
              },
              timerMinutes: timerParts[0],
              timerSeconds: timerParts[1],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  context.wp(4),
                  context.hp(1.5),
                  context.wp(4),
                  context.hp(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (q.hasTable && q.table != null)
                      PracticeMcqTable(data: q.table!)
                    else
                      Text(
                        q.displayText ?? q.questionText,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.5,
                              fontSize: context.sp(16),
                            ),
                      ),
                    SizedBox(height: context.hp(3)),
                    Wrap(
                      spacing: context.wp(2),
                      runSpacing: context.hp(1),
                      alignment: WrapAlignment.center,
                      children: ['A', 'B', 'C', 'D'].map((letter) {
                        final lower = letter.toLowerCase();
                        final isSel = selected == lower;
                        return SizedBox(
                          width: context.wp(18),
                          child: FilledButton.tonal(
                            onPressed: locked.value
                                ? null
                                : () => selectOption(lower),
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: context.hp(1.4),
                              ),
                              backgroundColor: isSel
                                  ? scheme.primary
                                  : scheme.surfaceContainerHighest,
                              foregroundColor: isSel
                                  ? scheme.onPrimary
                                  : scheme.onSurface,
                            ),
                            child: Text(
                              letter,
                              style: TextStyle(
                                fontSize: context.sp(18),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.wp(3),
                  context.hp(0.8),
                  context.wp(3),
                  context.hp(1.2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: locked.value ? null : goPrev,
                        child: Text(l10n.practiceTestPrev),
                      ),
                    ),
                    SizedBox(width: context.wp(2)),
                    IconButton.filledTonal(
                      onPressed: locked.value ? null : toggleBookmark,
                      icon: Icon(
                        (bookmarkByOverall.value[q.overallQueNo] ?? false)
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                      ),
                      tooltip: l10n.practiceTestBookmark,
                    ),
                    SizedBox(width: context.wp(2)),
                    Expanded(
                      child: FilledButton(
                        onPressed: locked.value ? null : goNext,
                        child: Text(l10n.practiceTestNext),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
