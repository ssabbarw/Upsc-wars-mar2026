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
}
