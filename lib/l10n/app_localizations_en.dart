// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'UPSC Wars';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get lightMode => 'Light';

  @override
  String get darkMode => 'Dark';

  @override
  String get systemMode => 'System default';

  @override
  String get english => 'English';

  @override
  String get hindi => 'Hindi';

  @override
  String get subjects => 'Subjects';

  @override
  String get subjectGeography => 'Geography';

  @override
  String get subjectModernHistory => 'Modern History';

  @override
  String get subjectPolity => 'Polity';

  @override
  String get subjectMedievalHistory => 'Medieval History';

  @override
  String get subjectArtAndCulture => 'Art & Culture';

  @override
  String get subjectEconomics => 'Economics';

  @override
  String get subjectEnvironment => 'Environment';

  @override
  String get subjectAncientHistory => 'Ancient History';

  @override
  String get topicWiseTests => 'Topic-Wise Tests';

  @override
  String get chapterBasedTests => 'Chapter Based Tests';

  @override
  String get topicWiseBrowseTitle => 'Topic-wise browse';

  @override
  String get topicWiseBrowseSearchHint => 'Search tags…';

  @override
  String topicWiseBrowseTotalTagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tags',
      one: '$count tag',
    );
    return '$_temp0';
  }

  @override
  String topicWiseBrowseTagsShownOfTotal(int shown, int total) {
    return 'Showing $shown of $total tags';
  }

  @override
  String get topicWiseBrowseGroupingTopic => 'Showing: topics';

  @override
  String get topicWiseBrowseGroupingSubTopic => 'Showing: sub-topics';

  @override
  String get topicWiseBrowseGroupingConcepts => 'Showing: concepts';

  @override
  String get topicWiseBrowseEmptySubject =>
      'No tags found for this subject yet.';

  @override
  String get topicWiseBrowseEmptyFilter =>
      'No tags match your search. Try different words.';

  @override
  String get topicWiseBrowseLoadError =>
      'Could not load tags. Open the app again after questions finish importing.';

  @override
  String topicWiseBrowseQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '$count question',
    );
    return '$_temp0';
  }

  @override
  String get topicWiseBrowseTagTapSoon =>
      'Practice by tag will be available in a future update.';

  @override
  String get previousYearQuestions => 'Previous Year Questions';

  @override
  String get pyqYear2025 => '2025';

  @override
  String get pyqYear2024 => '2024';

  @override
  String get pyqYear2023 => '2023';

  @override
  String get pyqYear2022 => '2022';

  @override
  String get pyqYear2021 => '2021';

  @override
  String get pyqYear2020 => '2020';

  @override
  String mcqSeedOverallProgress(int percent) {
    return 'Overall: $percent%';
  }

  @override
  String mcqSeedSubjectProgress(String subject, int percent) {
    return '$subject: $percent%';
  }

  @override
  String get mcqSeedFailed =>
      'Could not load questions. Check storage and try again.';

  @override
  String get mcqSeedRetry => 'Retry';

  @override
  String subjectTestListTitle(String subjectName) {
    return '$subjectName — Tests';
  }

  @override
  String subjectTestListTileTitle(int testNumber) {
    return 'Test $testNumber';
  }

  @override
  String subjectTestListTileRange(int start, int end) {
    return 'Questions $start–$end';
  }

  @override
  String get subjectTestListEmpty =>
      'There are not enough questions for a full practice test yet. Each test needs 25 questions.';

  @override
  String get subjectTestListUnknownSubject => 'This subject is not available.';

  @override
  String get subjectTestListLoadError =>
      'Could not load tests. Try again later.';

  @override
  String get subjectTestListOpenSoon =>
      'Starting a test will be available in a future update.';

  @override
  String practiceTestProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String practiceTestTimer(String minutes, String seconds) {
    return '$minutes:$seconds';
  }

  @override
  String practiceTestOption(String letter) {
    return 'Option $letter';
  }

  @override
  String get practiceTestPrev => 'Prev';

  @override
  String get practiceTestNext => 'Next';

  @override
  String get practiceTestBookmark => 'Bookmark';

  @override
  String get practiceTestRevisit => 'Revisit';

  @override
  String get practiceTestSubmit => 'Submit';

  @override
  String get practiceTestSubmitConfirmTitle => 'Submit test?';

  @override
  String get practiceTestSubmitConfirmMessage =>
      'Are you sure? You cannot change your answers after submitting.';

  @override
  String get practiceTestSubmitConfirmCancel => 'Not now';

  @override
  String get practiceTestSubmitConfirmSubmit => 'Yes, submit';

  @override
  String get practiceTestSummary => 'Summary';

  @override
  String get practiceTestSummaryTitle => 'Question palette';

  @override
  String get practiceTestLegendAnswered => 'Answered';

  @override
  String get practiceTestLegendSkipped => 'Skipped';

  @override
  String get practiceTestLegendPending => 'Not done';

  @override
  String get practiceTestLegendRevisit => 'Revisit';

  @override
  String get practiceTestLoadError => 'Could not load this test.';

  @override
  String get practiceTestTimeUp => 'Time is up — submitting…';

  @override
  String get practiceTestResultsTitle => 'Test complete';

  @override
  String get practiceTestStatTotal => 'Total questions';

  @override
  String get practiceTestStatCorrect => 'Correct';

  @override
  String get practiceTestStatIncorrect => 'Incorrect';

  @override
  String get practiceTestStatSkipped => 'Skipped';

  @override
  String get practiceTestStatAccuracy => 'Accuracy';

  @override
  String get practiceTestStatTime => 'Time taken';

  @override
  String get practiceTestTypeBreakdown => 'Accuracy by question type';

  @override
  String practiceTestTypeRow(String typeName, int percent) {
    return '$typeName: $percent%';
  }

  @override
  String get practiceTestReviewExplanations => 'View explanations';

  @override
  String get practiceTestBackHome => 'Back to tests';

  @override
  String get practiceTestResultsMissing => 'Results are unavailable.';

  @override
  String get practiceTestReviewTitle => 'Explanations';

  @override
  String get practiceTestYourPick => 'Your answer';

  @override
  String get practiceTestCorrectLabel => 'Correct';

  @override
  String get practiceTestCollapsibleTrap => 'UPSC trap';

  @override
  String get practiceTestCollapsibleDistractor => 'Strong distractor';

  @override
  String get practiceTestCollapsibleElimination => 'Elimination logic';

  @override
  String get practiceTestCollapsibleStatement => 'Statement analysis';

  @override
  String practiceTestReviewVerdictCorrect(String letter) {
    return 'Correct — your answer ($letter) is right.';
  }

  @override
  String practiceTestReviewVerdictIncorrect(String letter) {
    return 'Incorrect — the correct answer is ($letter).';
  }

  @override
  String practiceTestReviewVerdictSkipped(String letter) {
    return 'Not answered — the correct answer is ($letter).';
  }

  @override
  String practiceTestReviewCorrectOptionLine(String letter, String text) {
    return '($letter) $text';
  }

  @override
  String get practiceTestReviewValueAdditionToggleShow => '+ value addition';

  @override
  String get practiceTestReviewValueAdditionToggleHide => '− value addition';

  @override
  String get practiceTestReviewDeepDiveTitle => 'Deep dive';

  @override
  String get practiceTestReviewTabStatements => 'Statements';

  @override
  String get practiceTestReviewTabElimination => 'Elimination';

  @override
  String get practiceTestReviewTabTrap => 'Trap breakdown';

  @override
  String get practiceTestReviewStrongDistractorHeading => 'Strong distractor';

  @override
  String get practiceTestReviewWhyWrongHeading =>
      'Why aspirants get this wrong';

  @override
  String get practiceTestReviewEmptySection => 'No notes here.';
}
