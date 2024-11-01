import 'package:flutter/material.dart';
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; //dart file it keeps username


class AskQuestionPage extends StatefulWidget {

const AskQuestionPage({Key? key}) : super(key: key);

  @override
  _AskQuestionPageState createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  bool isExplanationVisible = false;
  bool showAdditionalButtons = false;
  final TextEditingController _textController1 = TextEditingController(); // First textController
  String result = ''; // Result text
  String? _selectedDifficulty; // Değişkeni tanımladık
  
  @override
  void dispose() {
    _textController1.dispose();
    super.dispose();
  }

  void _calculateResult() {
    setState(() {
      // Combining input from two text fields as an example result
      //result = 'Birinci Girdi: ${_textController1.text}\nİkinci Girdi: ${_textController2.text}';
    });
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

            // First TextField
            Container(
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
                  hintText: 'Sorunuzu Girin...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            // Second TextField
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFFFFCF2)),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                items: ['Çırak', 'Orta Seviye', 'İleri Seviye', 'Uzman', 'Usta'].map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Soruların zorluk seviyesi nasıl olsun ?',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            // Submit Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFFFFFCF2)),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              onPressed: () {
                if (_textController1.text.trim().isEmpty || _selectedDifficulty == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lütfen her iki alanı da doldurun')),
                  );
                } else {
                  _calculateResult();
                }
              },
              child: Text(
                'Sonucu Gönder',
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Result Display Area
            if(isExplanationVisible)
            Container(
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