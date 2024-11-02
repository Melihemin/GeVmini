import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5000/api';

  // API'den cevap yüzdesini almak için
  Future<double?> answersPercent(String userAnswer, String correctAnswer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/answers_percent'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_answer': userAnswer,
        'correct_answer': correctAnswer,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'];
    } else {
      throw Exception('Failed to load answer percent');
    }
  }

  // Soru oluşturma
  Future<String?> createQuiz(String subject, int questionCount, String level) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create_quiz'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'subject': subject,
        'question_count': questionCount,
        'level': level,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'];
    } else {
      throw Exception('Failed to create quiz');
    }
  }

  // Ders bilgisi alma
  Future<String?> lecture(String subject, String title, String level, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/lecture'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'subject': subject,
        'title': title,
        'level': level,
        'token': token,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'];
    } else {
      throw Exception('Failed to get lecture');
    }
  }

  // Cevap bulma
  Future<String?> findAnswer(String question, String level) async {
    final response = await http.post(
      Uri.parse('$baseUrl/find_answer'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'question': question,
        'level': level,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'];
    } else {
      throw Exception('Failed to find answer');
    }
  }

  // Rehberlik alma
  Future<String?> guide(String subject, String feel) async {
    final response = await http.post(
      Uri.parse('$baseUrl/guide'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'subject': subject,
        'feel': feel,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'];
    } else {
      throw Exception('Failed to get guide');
    }
  }

  // Soru oluşturma
  Future<String?> createQuestion(String subject, String level) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create_question'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'subject': subject,
        'level': level,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'];
    } else {
      throw Exception('Failed to create question');
    }
  }

  // Verileri alma
  Future<Map<String, dynamic>?> receiveData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to receive data');
    }
  }

  // Verileri gönderme
  Future<Map<String, dynamic>?> sendData() async {
    final response = await http.get(Uri.parse('$baseUrl/data'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send data');
    }
  }
}