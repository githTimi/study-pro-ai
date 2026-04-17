import 'package:flutter/material.dart';
import 'package:study_pro/feautures/ai/quiz_result_page.dart';
import 'package:study_pro/feautures/ai/summary_result_page.dart';
import 'package:study_pro/model/quiz_model.dart';
import 'package:study_pro/model/summary_result_model.dart';
import 'package:study_pro/services/ai_service.dart';
import 'package:study_pro/widgets/resume_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  double spacing(BuildContext context, double value) {
    final width = MediaQuery.sizeOf(context).width;
    return value * (width / 375); // 375 = base design width
  }

  double normalText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 400) {
      return 13;
    } else if (width < 600) {
      return 16;
    } else {
      return 20;
    }
  }

  double largeText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 400) {
      return 36;
    } else if (width < 600) {
      return 44;
    } else {
      return 50;
    }
  }

  double bigText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 400) {
      return 26;
    } else if (width < 600) {
      return 30;
    } else {
      return 36;
    }
  }

  double smallBigText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 400) {
      return 18;
    } else if (width < 600) {
      return 24;
    } else {
      return 28;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 229, 219, 239),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.maxWidth < 60 ? 35.0 : 60.0;

              return SizedBox(
                width: size,
                height: size,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/im1.jpg'),
                      fit: BoxFit.cover, // 👈 important
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        title: Builder(
          builder: (context) {
            final width = MediaQuery.sizeOf(context).width;

            double fontSize;
            if (width < 400) {
              fontSize = 18;
            } else if (width < 600) {
              fontSize = 20;
            } else {
              fontSize = 24;
            }

            return Text(
              'Scholar Sanctuary',
              style: TextStyle(
                color: const Color(0xFF842CD3),
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: spacing(context, 40)),
              Container(
                margin: EdgeInsets.all(
                  MediaQuery.sizeOf(context).width < 600 ? 20 : 40,
                ),

                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).width < 600 ? 10 : 25,
                      ),
                      alignment: Alignment(-1, 0),

                      width: MediaQuery.sizeOf(context).width < 600 ? 180 : 550,
                      child: Text(
                        'Welcome Scholar,',
                        style: TextStyle(
                          fontSize: normalText(context),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).width < 600 ? 10 : 25,
                      ),
                      alignment: Alignment(-1, 0),

                      width: MediaQuery.sizeOf(context).width < 600 ? 300 : 650,
                      child: RichText(
                        text: TextSpan(
                          text: 'What are we ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 57, 29, 67),
                            fontWeight: FontWeight.bold,
                            fontSize: largeText(context),
                          ),
                          children: <InlineSpan>[
                            // 👈 remove const + use InlineSpan
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFF4D1762),
                                        Color(0xFF842CD3),
                                      ],
                                    ).createShader(bounds),
                                child: Text(
                                  'Studying',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: largeText(
                                      context,
                                    ), // 👈 match size
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' today!'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).width < 600 ? 10 : 25,
                      ),
                      alignment: Alignment(-1, 0),

                      width: MediaQuery.sizeOf(context).width < 600 ? 300 : 650,
                      child: Text(
                        'Transform your lecture notes, PDFs, or textbook scans into intelligent study tools in seconds.',
                        style: TextStyle(
                          fontSize: normalText(context),
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width < 600 ? 20 : 40,
                ),
                child: Text(
                  'What do you want to generate?',
                  style: TextStyle(
                    fontSize: bigText(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // background
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // 👈 curved edges
                        border: Border.all(
                          color: const Color.fromARGB(
                            255,
                            191,
                            188,
                            188,
                          ), // 👈 border color
                          width: 1.5, // 👈 card-like border width
                        ),
                      ),
                      width: double.infinity,
                      padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width < 600 ? 16 : 24,
                      ),
                      margin: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width < 600 ? 20 : 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final size = constraints.maxWidth < 60
                                    ? 35.0
                                    : 60.0;

                                return SizedBox(
                                  width: size,
                                  height: size,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/fla.jpg',
                                        ),
                                        fit: BoxFit.cover, // 👈 important
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Generate Flashcards',
                                  style: TextStyle(
                                    fontSize: smallBigText(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'AI-powered active recall cards designed for long-term retention.',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.sizeOf(context).width < 600
                                        ? 13
                                        : 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final width = MediaQuery.sizeOf(context).width;

                              final boxSize = width < 600 ? 40.0 : 55.0;
                              final iconSize = width < 600 ? 20.0 : 26.0;

                              return Container(
                                width: boxSize,
                                height: boxSize,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFEDE7F6,
                                  ), // light purple background
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: const Color(0xFF842CD3),
                                    size: iconSize,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // quiz
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizPage(
                                questions: const [
                                  QuizQuestion(
                                    question:
                                        'Which part of the brain is primarily responsible for memory formation?',
                                    options: [
                                      QuizOption(
                                        label: 'A',
                                        text: 'Cerebellum',
                                      ),
                                      QuizOption(
                                        label: 'B',
                                        text: 'Hippocampus',
                                      ),
                                      QuizOption(label: 'C', text: 'Amygdala'),
                                      QuizOption(
                                        label: 'D',
                                        text: 'Prefrontal Cortex',
                                      ),
                                    ],
                                    correctIndex: 1,
                                    explanation:
                                        'The hippocampus plays a major role in learning and memory, especially in forming new episodic memories.',
                                  ),
                                  QuizQuestion(
                                    question:
                                        'Which organ pumps blood around the human body?',
                                    options: [
                                      QuizOption(label: 'A', text: 'Liver'),
                                      QuizOption(label: 'B', text: 'Brain'),
                                      QuizOption(label: 'C', text: 'Heart'),
                                      QuizOption(label: 'D', text: 'Kidney'),
                                    ],
                                    correctIndex: 2,
                                    explanation:
                                        'The heart pumps blood through the circulatory system.',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color.fromARGB(255, 191, 188, 188),
                              width: 1.5,
                            ),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width < 600 ? 16 : 24,
                          ),
                          margin: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width < 600 ? 20 : 40,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final size = constraints.maxWidth < 60
                                        ? 35.0
                                        : 60.0;

                                    return SizedBox(
                                      width: size,
                                      height: size,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/quiz.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Create Quiz',
                                      style: TextStyle(
                                        fontSize: smallBigText(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Multiple choice and short answer assessments to test your depth.',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.sizeOf(context).width <
                                                600
                                            ? 13
                                            : 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Builder(
                                builder: (context) {
                                  final width = MediaQuery.sizeOf(
                                    context,
                                  ).width;

                                  final boxSize = width < 600 ? 40.0 : 55.0;
                                  final iconSize = width < 600 ? 20.0 : 26.0;

                                  return Container(
                                    width: boxSize,
                                    height: boxSize,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEDE7F6),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: const Color(0xFF842CD3),
                                        size: iconSize,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //summary
                    InkWell(
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // match your container radius
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SummaryResultPage(
                              result: const SummaryResult(
                                title: 'Advanced Macroeconomics',
                                shortSummary:
                                    'This chapter explains inflation, unemployment, and monetary policy.',
                                keyPoints: [
                                  'Inflation affects purchasing power',
                                  'Central banks control money supply',
                                ],
                                importantTerms: [
                                  ImportantTerm(
                                    term: 'Inflation',
                                    meaning: 'Rise in general price levels',
                                  ),
                                  ImportantTerm(
                                    term: 'Monetary Policy',
                                    meaning:
                                        'Control of money supply by central bank',
                                  ),
                                ],
                                examTip:
                                    'Understand the relationship between inflation and unemployment.',
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // background
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // 👈 curved edges
                          border: Border.all(
                            color: const Color.fromARGB(
                              255,
                              191,
                              188,
                              188,
                            ), // 👈 border color
                            width: 1.5, // 👈 card-like border width
                          ),
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 16 : 24,
                        ),
                        margin: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 20 : 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final size = constraints.maxWidth < 60
                                      ? 35.0
                                      : 60.0;

                                  return SizedBox(
                                    width: size,
                                    height: size,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/summ.jpg',
                                          ),
                                          fit: BoxFit.cover, // 👈 important
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Summarize',
                                    style: TextStyle(
                                      fontSize: smallBigText(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Condense complex topics into easy-to-read executive summaries.',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width < 600
                                          ? 13
                                          : 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final width = MediaQuery.sizeOf(context).width;

                                final boxSize = width < 600 ? 40.0 : 55.0;
                                final iconSize = width < 600 ? 20.0 : 26.0;

                                return Container(
                                  width: boxSize,
                                  height: boxSize,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFEDE7F6,
                                    ), // light purple background
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: const Color(0xFF842CD3),
                                      size: iconSize,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ResumeSessionCard(
                streakText: 'Daily Streak: 12 Days',
                title: 'Resume Session',
                subtitle: 'Advanced Macroeconomics - Chapter 4\nFlashcards',
                buttonText: 'Continue Study',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
