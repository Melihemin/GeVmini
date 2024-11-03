import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5000/api';
  // final String baseUrl = 'http://10.0.2.2:5000/api'; // Android Emulator

  // API'den cevap yüzdesini almak için
  Future<double?> answersPercent(
      String userAnswer, String correctAnswer) async {
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

  // Quiz oluşturma
  Future<String?> createQuiz(
      String subject, int questionCount, int level) async {
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

  // Ders oluşturma
  Future<String?> lecture(
      String subject, String title, String level, String token) async {
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
      throw Exception('Failed to create lecture');
    }
  }

  // Rehberlik sağlama
  Future<String?> guide(String subject) async {
    final response = await http.post(
      Uri.parse('$baseUrl/guide'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'subject': subject,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'];
    } else {
      print('Guide error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to get guidance');
    }
  }

  // Soru oluşturma
  Future<String?> createQuestion(String subject, int level) async {
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

  // Veri alma ve saklama
  Future<Map<String, dynamic>?> receiveData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to receive data');
    }
  }

  // Saklanan veriyi alma
  Future<Map<String, dynamic>?> getData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/data'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to get stored data');
    }
  }

  Future<String?> formatResponse(String response) async {
    try {
      String formattedResponse = response.replaceAll(r'**', '\\**');
      return formattedResponse;
    } catch (e) {
      print('Format hatası: $e');
      return response;
    }
  }

  // Metni gösterirken Markdown widget'ını kullan
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Yanıtı')),
      body: FutureBuilder<String?>(
        future: ApiService().guide('your-subject-here'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else {
            return Markdown(
              data: snapshot.data ?? 'Veri bulunamadı',
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(fontWeight: FontWeight.bold),
                h2: TextStyle(fontWeight: FontWeight.bold),
                p: TextStyle(fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}
