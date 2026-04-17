//import 'dart:convert';
//import 'package:http/http.dart' as http;

class AiService {
  static const String summaryUrl =
      'https://generatesummary-5hlkit3nxq-uc.a.run.app';
  static Future<Map<String, dynamic>> generateSummary(String content) async {
    await Future.delayed(const Duration(seconds: 2)); // fake loading

    return {
      "title": "Advanced Macroeconomics - Chapter 4",
      "shortSummary":
          "This chapter explains inflation, unemployment, and monetary policy in a simplified way for quick revision.",
      "keyPoints": [
        "Inflation is a sustained rise in the general price level.",
        "Central banks use monetary policy to manage inflation.",
        "Short-run trade-offs may exist between inflation and unemployment.",
      ],
      "importantTerms": [
        {
          "term": "Inflation",
          "meaning":
              "A persistent increase in the average prices of goods and services.",
        },
        {
          "term": "Monetary Policy",
          "meaning":
              "Actions taken by the central bank to control money supply and interest rates.",
        },
      ],
      "examTip":
          "Focus on how inflation and unemployment relate in the short run versus the long run.",
    };
  }

  /*
  static Future<Map<String, dynamic>> generateSummary(String content) async {
    final response = await http.post(
      Uri.parse(summaryUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'content': content}),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  }
  */

  static Future<List<Map<String, dynamic>>> generateQuiz(String content) async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      {
        "question":
            "Which part of the brain is primarily responsible for memory formation?",
        "options": [
          {"label": "A", "text": "Cerebellum"},
          {"label": "B", "text": "Hippocampus"},
          {"label": "C", "text": "Amygdala"},
          {"label": "D", "text": "Prefrontal Cortex"},
        ],
        "correctIndex": 1,
        "explanation":
            "The hippocampus plays a major role in learning and forming new memories.",
      },
      {
        "question": "Which organ pumps blood through the body?",
        "options": [
          {"label": "A", "text": "Liver"},
          {"label": "B", "text": "Kidney"},
          {"label": "C", "text": "Heart"},
          {"label": "D", "text": "Brain"},
        ],
        "correctIndex": 2,
        "explanation":
            "The heart is the muscular organ responsible for circulating blood.",
      },
    ];
  }
}
