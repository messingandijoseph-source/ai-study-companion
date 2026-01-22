import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // Base AI service (FastAPI)
  static const String baseUrl = "http://YOUR_VPS_IP:PORT/ai";

  /// 1️⃣ Summarize notes
  static Future<String> summarizeNotes(String notes) async {
    final response = await http.post(
      Uri.parse("$baseUrl/summarize"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"notes": notes}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["summary"];
    } else {
      throw Exception("AI summarization failed");
    }
  }

  /// 2️⃣ Suggest study groups
  static Future<List<String>> suggestGroups(String userId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/group-suggest?userId=$userId"),
    );

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body)["groups"]);
    } else {
      throw Exception("Group suggestion failed");
    }
  }

  /// 3️⃣ Analyze study behavior (FOCUS MODE + NOTIFICATIONS)
  static Future<Map<String, dynamic>> analyzeStudyRisk({
    required String userId,
    required int distractionMinutes,
    required int missedSessions,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/analyze"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "distraction_minutes": distractionMinutes,
        "missed_sessions": missedSessions,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("AI analysis failed");
    }
  }
}
