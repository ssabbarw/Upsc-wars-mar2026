import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/core/router/app_router.dart';
import 'package:upsc_wars_new/features/home/data/datasources/subjects_datasource.dart';
import 'package:upsc_wars_new/features/subject_tests/presentation/providers/subject_tests_providers.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Lists 25-question practice tests for one subject.
class SubjectTestListPage extends ConsumerWidget {
  /// Creates a page for the subject identified by [subjectId] (e.g. `polity`).
  const SubjectTestListPage({super.key, required this.subjectId});

  /// [Subject.id] from [SubjectsDataSource].
  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subject = SubjectsDataSource.tryById(subjectId);

    if (subject == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
            child: Text(
              l10n.subjectTestListUnknownSubject,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final asyncTests = ref.watch(subjectTestsListProvider(subjectId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.subjectTestListTitle(subject.name(l10n)),
        ),
      ),
      body: asyncTests.when(
        data: (tests) {
          if (tests.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
                child: Text(
                  l10n.subjectTestListEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              vertical: context.hp(1),
              horizontal: context.wp(4),
            ),
            itemCount: tests.length,
            separatorBuilder: (_, __) => SizedBox(height: context.hp(0.5)),
            itemBuilder: (context, index) {
              final t = tests[index];
              return ListTile(
                title: Text(
                  l10n.subjectTestListTileTitle(t.testNumber),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  l10n.subjectTestListTileRange(
                    t.firstQuestionOrdinal,
                    t.lastQuestionOrdinal,
                  ),
                ),
                onTap: () {
                  context.pushNamed(
                    AppRoute.practiceTestRun.name,
                    pathParameters: {
                      'subjectId': subjectId,
                      'testNumber': '${t.testNumber}',
                    },
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
            child: Text(
              e is StateError ? e.message : l10n.subjectTestListLoadError,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
