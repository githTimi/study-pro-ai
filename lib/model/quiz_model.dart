class QuizQuestion {
  final String question;
  final List<QuizOption> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class QuizOption {
  final String label;
  final String text;

  const QuizOption({required this.label, required this.text});
}
