class SummaryResult {
  final String title;
  final String shortSummary;
  final List<String> keyPoints;
  final List<ImportantTerm> importantTerms;
  final String examTip;

  const SummaryResult({
    required this.title,
    required this.shortSummary,
    required this.keyPoints,
    required this.importantTerms,
    required this.examTip,
  });
}

class ImportantTerm {
  final String term;
  final String meaning;

  const ImportantTerm({required this.term, required this.meaning});
}
