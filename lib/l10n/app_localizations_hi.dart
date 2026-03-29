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
  String get topicWiseBrowseTitle => 'विषय-वार ब्राउज़';

  @override
  String get topicWiseBrowseSearchHint => 'टैग खोजें…';

  @override
  String get topicWiseBrowseGroupingTopic => 'दिखा रहे हैं: विषय';

  @override
  String get topicWiseBrowseGroupingSubTopic => 'दिखा रहे हैं: उप-विषय';

  @override
  String get topicWiseBrowseGroupingConcepts => 'दिखा रहे हैं: अवधारणाएँ';

  @override
  String get topicWiseBrowseEmptySubject =>
      'इस विषय के लिए अभी कोई टैग नहीं मिला।';

  @override
  String get topicWiseBrowseEmptyFilter =>
      'आपकी खोज से कोई टैग मेल नहीं खाता। दूसरे शब्द आज़माएँ।';

  @override
  String get topicWiseBrowseLoadError =>
      'टैग लोड नहीं हो सके। प्रश्न आयात पूरा होने के बाद ऐप फिर खोलें।';

  @override
  String topicWiseBrowseQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्रश्न',
      one: '$count प्रश्न',
    );
    return '$_temp0';
  }

  @override
  String get topicWiseBrowseTagTapSoon =>
      'टैग से अभ्यास आगे के अपडेट में उपलब्ध होगा।';

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
    return 'विकल्प $letter';
  }

  @override
  String get practiceTestPrev => 'पिछला';

  @override
  String get practiceTestNext => 'अगला';

  @override
  String get practiceTestBookmark => 'बुकमार्क';

  @override
  String get practiceTestRevisit => 'पुनः देखें';

  @override
  String get practiceTestSubmit => 'जमा करें';

  @override
  String get practiceTestSubmitConfirmTitle => 'टेस्ट जमा करें?';

  @override
  String get practiceTestSubmitConfirmMessage =>
      'क्या आप निश्चित हैं? जमा करने के बाद उत्तर बदले नहीं जा सकते।';

  @override
  String get practiceTestSubmitConfirmCancel => 'अभी नहीं';

  @override
  String get practiceTestSubmitConfirmSubmit => 'हाँ, जमा करें';

  @override
  String get practiceTestSummary => 'सारांश';

  @override
  String get practiceTestSummaryTitle => 'प्रश्न सूची';

  @override
  String get practiceTestLegendAnswered => 'उत्तर दिया';

  @override
  String get practiceTestLegendSkipped => 'छोड़ा';

  @override
  String get practiceTestLegendPending => 'बाकी';

  @override
  String get practiceTestLegendRevisit => 'पुनः देखें';

  @override
  String get practiceTestLoadError => 'यह टेस्ट लोड नहीं हो सका।';

  @override
  String get practiceTestTimeUp => 'समय समाप्त — जमा किया जा रहा है…';

  @override
  String get practiceTestResultsTitle => 'टेस्ट पूर्ण';

  @override
  String get practiceTestStatTotal => 'कुल प्रश्न';

  @override
  String get practiceTestStatCorrect => 'सही';

  @override
  String get practiceTestStatIncorrect => 'गलत';

  @override
  String get practiceTestStatSkipped => 'छोड़े गए';

  @override
  String get practiceTestStatAccuracy => 'सटीकता';

  @override
  String get practiceTestStatTime => 'लिया गया समय';

  @override
  String get practiceTestTypeBreakdown => 'प्रकार के अनुसार सटीकता';

  @override
  String practiceTestTypeRow(String typeName, int percent) {
    return '$typeName: $percent%';
  }

  @override
  String get practiceTestReviewExplanations => 'व्याख्याएँ देखें';

  @override
  String get practiceTestBackHome => 'टेस्ट पर वापस';

  @override
  String get practiceTestResultsMissing => 'परिणाम उपलब्ध नहीं।';

  @override
  String get practiceTestReviewTitle => 'व्याख्या';

  @override
  String get practiceTestYourPick => 'आपका उत्तर';

  @override
  String get practiceTestCorrectLabel => 'सही';

  @override
  String get practiceTestCollapsibleTrap => 'UPSC जाल';

  @override
  String get practiceTestCollapsibleDistractor => 'मजबूत विधर्मी';

  @override
  String get practiceTestCollapsibleElimination => 'उन्मूलन तर्क';

  @override
  String get practiceTestCollapsibleStatement => 'कथन विश्लेषण';
}
