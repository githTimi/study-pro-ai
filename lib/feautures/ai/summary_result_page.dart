import 'package:flutter/material.dart';
import 'package:study_pro/model/summary_result_model.dart';

class SummaryResultPage extends StatelessWidget {
  final SummaryResult result;

  const SummaryResultPage({super.key, required this.result});

  double pageSpace(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 20;
    if (width < 600) return 28;
    return 40;
  }

  double titleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 20;
    if (width < 600) return 24;
    return 30;
  }

  double sectionTitleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 16;
    if (width < 600) return 18;
    return 22;
  }

  double bodySize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 13;
    if (width < 600) return 15;
    return 18;
  }

  double buttonHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 600 ? 52 : 60;
  }

  @override
  Widget build(BuildContext context) {
    final space = pageSpace(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5DBEF),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Summary',
          style: TextStyle(
            color: const Color(0xFF842CD3),
            fontSize: titleSize(context),
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
              _HeaderCard(
                title: result.title,
                titleSize: titleSize(context),
                bodySize: bodySize(context),
              ),
              SizedBox(height: space),

              _SectionCard(
                title: 'Short Summary',
                titleFontSize: sectionTitleSize(context),
                child: Text(
                  result.shortSummary,
                  style: TextStyle(
                    fontSize: bodySize(context),
                    height: 1.5,
                    color: const Color(0xFF4A3B5F),
                  ),
                ),
              ),
              SizedBox(height: space),

              _SectionCard(
                title: 'Key Points',
                titleFontSize: sectionTitleSize(context),
                child: Column(
                  children: result.keyPoints
                      .map(
                        (point) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: Color(0xFF842CD3),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  point,
                                  style: TextStyle(
                                    fontSize: bodySize(context),
                                    height: 1.5,
                                    color: const Color(0xFF4A3B5F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: space),

              _SectionCard(
                title: 'Important Terms',
                titleFontSize: sectionTitleSize(context),
                child: Column(
                  children: result.importantTerms
                      .map(
                        (item) => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3EFF9),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.term,
                                style: TextStyle(
                                  fontSize: bodySize(context),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF342C63),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.meaning,
                                style: TextStyle(
                                  fontSize: bodySize(context),
                                  height: 1.4,
                                  color: const Color(0xFF5A4E70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: space),

              _SectionCard(
                title: 'Exam Tip',
                titleFontSize: sectionTitleSize(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFF842CD3),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          result.examTip,
                          style: TextStyle(
                            fontSize: bodySize(context),
                            height: 1.5,
                            color: const Color(0xFF4A3B5F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: space),

              SizedBox(
                width: double.infinity,
                height: buttonHeight(context),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF5B63F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Text(
                    'Save to Library',
                    style: TextStyle(
                      fontSize: bodySize(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;
  final double titleSize;
  final double bodySize;

  const _HeaderCard({
    required this.title,
    required this.titleSize,
    required this.bodySize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B63F6), Color(0xFF8A3FF0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome, color: Colors.white, size: 26),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AI-generated summary ready for review',
            style: TextStyle(
              fontSize: bodySize,
              color: Colors.white.withAlpha(220),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.titleFontSize,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2DBEC), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF342C63),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
