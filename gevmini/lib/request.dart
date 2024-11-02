import 'dart:convert';
import 'package:http/http.dart' as http;

class AidaFunctions {
  final String apiUrl;
  final String apiKey;

  AidaFunctions(this.apiUrl, this.apiKey);

  // Helper function to make API calls and return "result" field
  Future<String> _postRequest(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse["result"] ?? "Yanıt boş"; // "result" alanı varsa döner, yoksa uyarı verir.
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

  /// Finds an answer based on a question and a specified level.
  Future<String> findAnswer(String question, String level) async {
    return await _postRequest({
      "question": question,
      "level": level,
      "type": "findAnswer"
    });
  }

  /// Provides a guide for a given subject and emotional state.
  Future<String> guide(String subject) async {
    return await _postRequest({
      "subject": subject,
      "type": "guide"
    });
  }

  /// Provides a lecture based on a given subject, title, and level.
  Future<String> lecture(String subject, String title, String level, int token) async {
    return await _postRequest({
      "subject": subject,
      "title": title,
      "level": level,
      "token": token,
      "type": "lecture"
    });
  }

  /// Creates a quiz based on a subject, question count, and level.
  Future<String> createQuiz(String subject, int questionCount, String level) async {
    return await _postRequest({
      "subject": subject,
      "questionCount": questionCount,
      "level": level,
      "type": "createQuiz"
    });
  }
}