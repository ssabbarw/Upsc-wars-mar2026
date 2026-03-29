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
