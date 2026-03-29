// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'UPSC वॉर्स';

  @override
  String get home => 'होम';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get language => 'भाषा';

  @override
  String get theme => 'थीम';

  @override
  String get lightMode => 'लाइट';

  @override
  String get darkMode => 'डार्क';

  @override
  String get systemMode => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get hindi => 'हिंदी';

  @override
  String get subjects => 'विषय';

  @override
  String get subjectGeography => 'भूगोल';

  @override
  String get subjectModernHistory => 'आधुनिक इतिहास';

  @override
  String get subjectPolity => 'राजव्यवस्था';

  @override
  String get subjectMedievalHistory => 'मध्यकालीन इतिहास';

  @override
  String get subjectArtAndCulture => 'कला एवं संस्कृति';

  @override
  String get subjectEconomics => 'अर्थशास्त्र';

  @override
  String get subjectEnvironment => 'पर्यावरण';

  @override
  String get subjectAncientHistory => 'प्राचीन इतिहास';

  @override
  String get topicWiseTests => 'विषय-वार टेस्ट';

  @override
  String get chapterBasedTests => 'अध्याय आधारित टेस्ट';

  @override
  String get previousYearQuestions => 'पिछले वर्ष के प्रश्न';

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
    return 'कुल: $percent%';
  }

  @override
  String mcqSeedSubjectProgress(String subject, int percent) {
    return '$subject: $percent%';
  }

  @override
  String get mcqSeedFailed =>
      'प्रश्न लोड नहीं हो सके। स्टोरेज जाँचें और पुनः प्रयास करें।';

  @override
  String get mcqSeedRetry => 'पुनः प्रयास';

  @override
  String subjectTestListTitle(String subjectName) {
    return '$subjectName — टेस्ट';
  }

  @override
  String subjectTestListTileTitle(int testNumber) {
    return 'टेस्ट $testNumber';
  }

  @override
  String subjectTestListTileRange(int start, int end) {
    return 'प्रश्न $start–$end';
  }

  @override
  String get subjectTestListEmpty =>
      'पूर्ण अभ्यास टेस्ट के लिए अभी पर्याप्त प्रश्न नहीं हैं। प्रत्येक टेस्ट में 25 प्रश्न चाहिए।';

  @override
  String get subjectTestListUnknownSubject => 'यह विषय उपलब्ध नहीं है।';

  @override
  String get subjectTestListLoadError =>
      'टेस्ट लोड नहीं हो सके। बाद में पुनः प्रयास करें।';

  @override
  String get subjectTestListOpenSoon =>
      'टेस्ट शुरू करने की सुविधा आगे के अपडेट में उपलब्ध होगी।';
}
