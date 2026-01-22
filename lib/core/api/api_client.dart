import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "http://YOUR_VPS_IP:3000/api";

  static Future<http.Response> post(String path, Map data) {
    return http.post(
      Uri.parse("$baseUrl$path"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> get(String path) {
    return http.get(Uri.parse("$baseUrl$path"));
  }
}
