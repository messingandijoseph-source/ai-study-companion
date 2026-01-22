import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String baseUrl = "http://YOUR_VPS_IP:PORT/ai";

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
}
