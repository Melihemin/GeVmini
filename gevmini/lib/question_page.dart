import 'package:flutter/material.dart';
import 'package:gevmini/api.dart'; // Import the ApiService class
import 'global.dart'; // Dart file that keeps username

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool isExplanationVisible = false;
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  String result = ''; // Result text
  String? _selectedDifficulty; // For difficulty level
  final ApiService apiService = ApiService(); // Initialize ApiService

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  Future<void> _createQuestion() async {
    // Validate input
    if (_textController1.text.trim().isEmpty || _textController2.text.trim().isEmpty || _selectedDifficulty == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    setState(() {
      result = 'Yükleniyor...'; // Show loading indicator
      isExplanationVisible = true;
    });

    try {
      // Call the API method to create a question
      final response = await apiService.createQuestion(
        _textController1.text.trim(),
        _textController2.text.trim(),
      );

      // Check the response and set the result accordingly
      setState(() {
        if (response != null && response.isNotEmpty) {
          result = 'Soru başarıyla oluşturuldu: $response'; // Show the returned question or message
        } else {
          result = 'Soru oluşturulamadı, lütfen tekrar deneyin.';
        }
      });
    } catch (e) {
      setState(() {
        result = 'Bir hata oluştu: $e'; // Display the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004E98),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Logo
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Color(0xFF3A6EA5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'geVmini',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrainsMono',
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.black,
                    ),
                  ),
                  Text(
                    'geVmini',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrainsMono',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // First TextField for Question Context
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFFFFCF2)),
              ),
              child: TextField(
                controller: _textController1,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Hangi alan için soruyu soruyorsunuz?',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            // Second TextField for Topic
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFFFFCF2)),
              ),
              child: TextField(
                controller: _textController2,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Hangi konu başlığında soru sormak istiyorsunuz?',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            // Difficulty Level Dropdown
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFFFFCF2)),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                items: ['Çırak', 'Orta Seviye', 'İleri Seviye', 'Uzman', 'Usta']
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Sorunun zorluk seviyesi',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            // Submit Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFFFFFCF2)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: _createQuestion,
              child: Text(
                'Sonucu Göster',
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Result Display Area
            if (isExplanationVisible)
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
