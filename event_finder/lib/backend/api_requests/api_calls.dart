import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCalls {
  static const String baseUrl = "https://example.com/api";

  static Future<http.Response> fetchData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.get(url);
  }

  static Future<http.Response> postData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });
  }
}