import 'package:flutter/material.dart';
import 'package:study_pro/model/quiz_model.dart';

class QuizPage extends StatefulWidget {
  final List<QuizQuestion> questions;

  const QuizPage({super.key, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int? selectedIndex;
  bool hasAnswered = false;
  int score = 0;

  QuizQuestion get currentQuestion => widget.questions[currentQuestionIndex];

  double pageSpace(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 16;
    if (width < 600) return 22;
    return 32;
  }

  double questionFont(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 22;
    if (width < 600) return 28;
    return 34;
  }

  double bodyFont(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 13;
    if (width < 600) return 15;
    return 18;
  }

  double optionFont(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 16;
    if (width < 600) return 18;
    return 22;
  }

  double optionHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 72;
    if (width < 600) return 84;
    return 96;
  }

  double buttonHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 600 ? 54 : 62;
  }

  void selectAnswer(int index) {
    if (hasAnswered) return;

    setState(() {
      selectedIndex = index;
      hasAnswered = true;

      if (index == currentQuestion.correctIndex) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedIndex = null;
        hasAnswered = false;
      });
    } else {
      endQuiz();
    }
  }

  void endQuiz() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete'),
        content: Text('You scored $score out of ${widget.questions.length}.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Color optionBackground(int index) {
    if (!hasAnswered) return const Color(0xFFF1ECF7);

    if (index == currentQuestion.correctIndex) {
      return const Color(0xFFE9F8EE);
    }

    if (index == selectedIndex && index != currentQuestion.correctIndex) {
      return const Color(0xFFFCEBEC);
    }

    return const Color(0xFFF1ECF7);
  }

  Color optionBorder(int index) {
    if (!hasAnswered) {
      return index == selectedIndex
          ? const Color(0xFF5B63F6)
          : Colors.transparent;
    }

    if (index == currentQuestion.correctIndex) {
      return const Color(0xFF2E7D32);
    }

    if (index == selectedIndex && index != currentQuestion.correctIndex) {
      return const Color(0xFFD32F2F);
    }

    return Colors.transparent;
  }

  Color optionCircleBackground(int index) {
    if (!hasAnswered) return Colors.white;

    if (index == currentQuestion.correctIndex) {
      return const Color(0xFF2E7D32);
    }

    if (index == selectedIndex && index != currentQuestion.correctIndex) {
      return const Color(0xFFD32F2F);
    }

    return Colors.white;
  }

  Color optionCircleTextColor(int index) {
    if (!hasAnswered) return const Color(0xFF5B63F6);

    if (index == currentQuestion.correctIndex ||
        (index == selectedIndex && index != currentQuestion.correctIndex)) {
      return Colors.white;
    }

    return const Color(0xFF5B63F6);
  }

  IconData? trailingIcon(int index) {
    if (!hasAnswered) return null;

    if (index == currentQuestion.correctIndex) {
      return Icons.check_circle;
    }

    if (index == selectedIndex && index != currentQuestion.correctIndex) {
      return Icons.cancel;
    }

    return null;
  }

  Color trailingIconColor(int index) {
    if (index == currentQuestion.correctIndex) {
      return const Color(0xFF2E7D32);
    }
    return const Color(0xFFD32F2F);
  }

  @override
  Widget build(BuildContext context) {
    final space = pageSpace(context);
    final progress = (currentQuestionIndex + 1) / widget.questions.length;
    final isLastQuestion = currentQuestionIndex == widget.questions.length - 1;
    final selectedIsCorrect = selectedIndex == currentQuestion.correctIndex;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5DBEF),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Quiz',
          style: TextStyle(
            color: Color(0xFF842CD3),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(space),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${widget.questions.length}',
                    style: TextStyle(
                      fontSize: bodyFont(context),
                      color: const Color(0xFF6F6488),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${(progress * 100).round()}%',
                    style: TextStyle(
                      fontSize: bodyFont(context),
                      color: const Color(0xFF5B63F6),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFE8E0F2),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF7B4CE2)),
                ),
              ),
              SizedBox(height: space + 6),
              Text(
                currentQuestion.question,
                style: TextStyle(
                  fontSize: questionFont(context),
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                  color: const Color(0xFF2F2340),
                ),
              ),
              SizedBox(height: space + 2),

              ...List.generate(currentQuestion.options.length, (index) {
                final option = currentQuestion.options[index];
                final icon = trailingIcon(index);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => selectAnswer(index),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: optionHeight(context),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: space,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: optionBackground(index),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: optionBorder(index),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: optionCircleBackground(index),
                            ),
                            child: Center(
                              child: Text(
                                option.label,
                                style: TextStyle(
                                  fontSize: bodyFont(context),
                                  fontWeight: FontWeight.w700,
                                  color: optionCircleTextColor(index),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              option.text,
                              style: TextStyle(
                                fontSize: optionFont(context),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2F2340),
                              ),
                            ),
                          ),
                          if (icon != null) ...[
                            const SizedBox(width: 12),
                            Icon(
                              icon,
                              color: trailingIconColor(index),
                              size: 24,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),

              if (hasAnswered) ...[
                SizedBox(height: space * 0.4),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(space),
                  decoration: BoxDecoration(
                    color: selectedIsCorrect
                        ? const Color(0xFFEAF7EE)
                        : const Color(0xFFF1ECF7),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            selectedIsCorrect
                                ? Icons.auto_awesome
                                : Icons.info_outline,
                            color: selectedIsCorrect
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFF842CD3),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedIsCorrect
                                ? 'Correct Answer'
                                : 'AI Explanation',
                            style: TextStyle(
                              fontSize: bodyFont(context),
                              fontWeight: FontWeight.w700,
                              color: selectedIsCorrect
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFF6D52B5),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentQuestion.explanation,
                        style: TextStyle(
                          fontSize: bodyFont(context),
                          height: 1.6,
                          color: const Color(0xFF4A3B5F),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: space),
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight(context),
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF5B63F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      isLastQuestion ? 'End Quiz' : 'Next Question',
                      style: TextStyle(
                        fontSize: bodyFont(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
