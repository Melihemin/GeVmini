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
  String result = ''; // Result text
  String? _selectedDifficulty; // For difficulty level
  final ApiService apiService = ApiService(); // Initialize ApiService
  int? _selectedOption; // Define the variable

  @override
  void dispose() {
    _textController1.dispose();
    super.dispose();
  }

  Future<void> _createQuiz() async {
    // Input validation
    if (_textController1.text.trim().isEmpty ||
        _selectedOption == null ||
        _selectedDifficulty == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    setState(() {
      result = 'Yükleniyor...';
      isExplanationVisible = true;
    });

    try {
      final subject = _textController1.text.trim();
      final questionCount = _selectedOption ?? 1;
      final level = _selectedDifficulty == 'Çırak'
          ? 1
          : _selectedDifficulty == 'Orta Seviye'
              ? 2
              : _selectedDifficulty == 'İleri Seviye'
                  ? 3
                  : _selectedDifficulty == 'Uzman'
                      ? 4
                      : 5;

      // Send quiz creation request via ApiService
      final response =
          await apiService.createQuiz(subject, questionCount, level);

      setState(() {
        result = response != null && response.isNotEmpty
            ? 'Quiz başarıyla oluşturuldu: $response'
            : 'Quiz oluşturulamadı, lütfen tekrar deneyin.';
      });

      // Display result in a popup
      _showResultPopup(result);
    } catch (e) {
      setState(() {
        result = 'Bir hata oluştu: $e';
      });
      _showResultPopup(result);
    }
  }

  void _showResultPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: TextStyle(
                  color: Colors.black, fontSize: 16), // Set text color to black
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Kapat',
                style: TextStyle(
                    color: Colors.black), // Set button text color to black
              ),
            ),
          ],
        );
      },
    );
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
                  hintText: 'Soru oluşturmak istediğiniz alan ve konu nedir?',
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
              child: DropdownButtonFormField<int>(
                value: 1,
                items: [1, 2, 3, 4, 5]
                    .map((int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ))
                    .toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    if (newValue != null) {
                      _selectedOption = newValue;
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: '1 ile 5 arasında bir değer seçin',
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
            SizedBox(height: 40),
            // Submit Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFFFFFCF2)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: _createQuiz,
              child: Text(
                'Soru Oluştur',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
