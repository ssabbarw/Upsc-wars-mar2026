import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'UPSC Wars'**
  String get appTitle;

  /// Home navigation label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Settings navigation label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme setting label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// System default theme option
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemMode;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Hindi language option
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// Subjects section heading
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjects;

  /// Geography subject name
  ///
  /// In en, this message translates to:
  /// **'Geography'**
  String get subjectGeography;

  /// Modern History subject name
  ///
  /// In en, this message translates to:
  /// **'Modern History'**
  String get subjectModernHistory;

  /// Polity subject name
  ///
  /// In en, this message translates to:
  /// **'Polity'**
  String get subjectPolity;

  /// Medieval History subject name
  ///
  /// In en, this message translates to:
  /// **'Medieval History'**
  String get subjectMedievalHistory;

  /// Art and Culture subject name
  ///
  /// In en, this message translates to:
  /// **'Art & Culture'**
  String get subjectArtAndCulture;

  /// Economics subject name
  ///
  /// In en, this message translates to:
  /// **'Economics'**
  String get subjectEconomics;

  /// Environment subject name
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get subjectEnvironment;

  /// Ancient History subject name
  ///
  /// In en, this message translates to:
  /// **'Ancient History'**
  String get subjectAncientHistory;

  /// Topic-wise tests tile title
  ///
  /// In en, this message translates to:
  /// **'Topic-Wise Tests'**
  String get topicWiseTests;

  /// Topic-wise tests tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Chapter Based Tests'**
  String get chapterBasedTests;

  /// Previous Year Questions section heading
  ///
  /// In en, this message translates to:
  /// **'Previous Year Questions'**
  String get previousYearQuestions;

  /// PYQ year 2025
  ///
  /// In en, this message translates to:
  /// **'2025'**
  String get pyqYear2025;

  /// PYQ year 2024
  ///
  /// In en, this message translates to:
  /// **'2024'**
  String get pyqYear2024;

  /// PYQ year 2023
  ///
  /// In en, this message translates to:
  /// **'2023'**
  String get pyqYear2023;

  /// PYQ year 2022
  ///
  /// In en, this message translates to:
  /// **'2022'**
  String get pyqYear2022;

  /// PYQ year 2021
  ///
  /// In en, this message translates to:
  /// **'2021'**
  String get pyqYear2021;

  /// PYQ year 2020
  ///
  /// In en, this message translates to:
  /// **'2020'**
  String get pyqYear2020;

  /// Overall MCQ import progress percentage
  ///
  /// In en, this message translates to:
  /// **'Overall: {percent}%'**
  String mcqSeedOverallProgress(int percent);

  /// Current subject MCQ import progress percentage
  ///
  /// In en, this message translates to:
  /// **'{subject}: {percent}%'**
  String mcqSeedSubjectProgress(String subject, int percent);

  /// Message when MCQ import fails
  ///
  /// In en, this message translates to:
  /// **'Could not load questions. Check storage and try again.'**
  String get mcqSeedFailed;

  /// Button to retry MCQ import
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get mcqSeedRetry;

  /// App bar title for subject practice test list
  ///
  /// In en, this message translates to:
  /// **'{subjectName} — Tests'**
  String subjectTestListTitle(String subjectName);

  /// Title for one practice test row
  ///
  /// In en, this message translates to:
  /// **'Test {testNumber}'**
  String subjectTestListTileTitle(int testNumber);

  /// Ordinal question range within the subject for one test
  ///
  /// In en, this message translates to:
  /// **'Questions {start}–{end}'**
  String subjectTestListTileRange(int start, int end);

  /// Shown when subject has fewer than 25 MCQs in the database
  ///
  /// In en, this message translates to:
  /// **'There are not enough questions for a full practice test yet. Each test needs 25 questions.'**
  String get subjectTestListEmpty;

  /// Invalid subject id in route
  ///
  /// In en, this message translates to:
  /// **'This subject is not available.'**
  String get subjectTestListUnknownSubject;

  /// Generic error loading subject test list
  ///
  /// In en, this message translates to:
  /// **'Could not load tests. Try again later.'**
  String get subjectTestListLoadError;

  /// Deprecated snack copy
  ///
  /// In en, this message translates to:
  /// **'Starting a test will be available in a future update.'**
  String get subjectTestListOpenSoon;

  /// No description provided for @practiceTestProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String practiceTestProgress(int current, int total);

  /// No description provided for @practiceTestTimer.
  ///
  /// In en, this message translates to:
  /// **'{minutes}:{seconds}'**
  String practiceTestTimer(String minutes, String seconds);

  /// No description provided for @practiceTestOption.
  ///
  /// In en, this message translates to:
  /// **'Option {letter}'**
  String practiceTestOption(String letter);

  /// No description provided for @practiceTestPrev.
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get practiceTestPrev;

  /// No description provided for @practiceTestNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get practiceTestNext;

  /// No description provided for @practiceTestBookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get practiceTestBookmark;

  /// Label to mark question for later revisit
  ///
  /// In en, this message translates to:
  /// **'Revisit'**
  String get practiceTestRevisit;

  /// No description provided for @practiceTestSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get practiceTestSubmit;

  /// Title for submit confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Submit test?'**
  String get practiceTestSubmitConfirmTitle;

  /// Body for submit confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure? You cannot change your answers after submitting.'**
  String get practiceTestSubmitConfirmMessage;

  /// Dismiss submit confirmation
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get practiceTestSubmitConfirmCancel;

  /// Confirm submit test
  ///
  /// In en, this message translates to:
  /// **'Yes, submit'**
  String get practiceTestSubmitConfirmSubmit;

  /// No description provided for @practiceTestSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get practiceTestSummary;

  /// No description provided for @practiceTestSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Question palette'**
  String get practiceTestSummaryTitle;

  /// No description provided for @practiceTestLegendAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get practiceTestLegendAnswered;

  /// No description provided for @practiceTestLegendSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get practiceTestLegendSkipped;

  /// No description provided for @practiceTestLegendPending.
  ///
  /// In en, this message translates to:
  /// **'Not done'**
  String get practiceTestLegendPending;

  /// Legend for questions marked to revisit
  ///
  /// In en, this message translates to:
  /// **'Revisit'**
  String get practiceTestLegendRevisit;

  /// No description provided for @practiceTestLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load this test.'**
  String get practiceTestLoadError;

  /// No description provided for @practiceTestTimeUp.
  ///
  /// In en, this message translates to:
  /// **'Time is up — submitting…'**
  String get practiceTestTimeUp;

  /// No description provided for @practiceTestResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Test complete'**
  String get practiceTestResultsTitle;

  /// No description provided for @practiceTestStatTotal.
  ///
  /// In en, this message translates to:
  /// **'Total questions'**
  String get practiceTestStatTotal;

  /// No description provided for @practiceTestStatCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get practiceTestStatCorrect;

  /// No description provided for @practiceTestStatIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get practiceTestStatIncorrect;

  /// No description provided for @practiceTestStatSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get practiceTestStatSkipped;

  /// No description provided for @practiceTestStatAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get practiceTestStatAccuracy;

  /// No description provided for @practiceTestStatTime.
  ///
  /// In en, this message translates to:
  /// **'Time taken'**
  String get practiceTestStatTime;

  /// No description provided for @practiceTestTypeBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Accuracy by question type'**
  String get practiceTestTypeBreakdown;

  /// No description provided for @practiceTestTypeRow.
  ///
  /// In en, this message translates to:
  /// **'{typeName}: {percent}%'**
  String practiceTestTypeRow(String typeName, int percent);

  /// No description provided for @practiceTestReviewExplanations.
  ///
  /// In en, this message translates to:
  /// **'View explanations'**
  String get practiceTestReviewExplanations;

  /// No description provided for @practiceTestBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back to tests'**
  String get practiceTestBackHome;

  /// No description provided for @practiceTestResultsMissing.
  ///
  /// In en, this message translates to:
  /// **'Results are unavailable.'**
  String get practiceTestResultsMissing;

  /// No description provided for @practiceTestReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Explanations'**
  String get practiceTestReviewTitle;

  /// No description provided for @practiceTestYourPick.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get practiceTestYourPick;

  /// No description provided for @practiceTestCorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get practiceTestCorrectLabel;

  /// No description provided for @practiceTestCollapsibleTrap.
  ///
  /// In en, this message translates to:
  /// **'UPSC trap'**
  String get practiceTestCollapsibleTrap;

  /// No description provided for @practiceTestCollapsibleDistractor.
  ///
  /// In en, this message translates to:
  /// **'Strong distractor'**
  String get practiceTestCollapsibleDistractor;

  /// No description provided for @practiceTestCollapsibleElimination.
  ///
  /// In en, this message translates to:
  /// **'Elimination logic'**
  String get practiceTestCollapsibleElimination;

  /// No description provided for @practiceTestCollapsibleStatement.
  ///
  /// In en, this message translates to:
  /// **'Statement analysis'**
  String get practiceTestCollapsibleStatement;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
