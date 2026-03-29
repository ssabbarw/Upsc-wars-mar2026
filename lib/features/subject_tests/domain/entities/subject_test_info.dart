/// One practice test slice for a subject (fixed size, 1-based indices).
class SubjectTestInfo {
  /// Creates metadata for a single test.
  const SubjectTestInfo({
    required this.testNumber,
    required this.firstQuestionOrdinal,
    required this.lastQuestionOrdinal,
  });

  /// 1-based test index (Test 1, Test 2, …).
  final int testNumber;

  /// 1-based ordinal of the first question in this test within the subject.
  final int firstQuestionOrdinal;

  /// 1-based ordinal of the last question in this test within the subject.
  final int lastQuestionOrdinal;
}
