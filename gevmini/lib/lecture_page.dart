import 'package:flutter/material.dart';
import 'package:gevmini/api.dart'; // Import ApiService
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; // dart file that keeps username

class LecturePage extends StatefulWidget {
  const LecturePage({Key? key}) : super(key: key);

  @override
  _LecturePageState createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
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

  Future<void> _calculateResult() async {
    setState(() {
      result = 'Yükleniyor...'; // Show loading indicator
      isExplanationVisible = true;
    });

    try {
      // Combine the field, topic, and difficulty to find the explanation
      final apiResult = await apiService.findAnswer(
        '${_textController1.text.trim()} - ${_textController2.text.trim()}',
        _selectedDifficulty!,
      );

      setState(() {
        result = apiResult ?? 'Bir açıklama bulunamadı';
      });
    } catch (e) {
      setState(() {
        result = 'Bir hata oluştu: $e';
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

            // First TextField for Field
            _buildTextField(
              controller: _textController1,
              hint: 'Hangi alan için anlatım istersiniz?',
            ),

            // Second TextField for Topic
            _buildTextField(
              controller: _textController2,
              hint: 'Hangi konu başlığını okumak istersiniz?',
            ),

            // Difficulty Level Dropdown
            _buildDropdown(),

            // Submit Button
            _buildSubmitButton(),

            // Result Display Area
            if (isExplanationVisible)
              _buildResultDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hint}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFFCF2)),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFFCF2)),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedDifficulty,
        items: [
          'Çırak',
          'Orta Seviye',
          'İleri Seviye',
          'Uzman',
          'Usta'
        ].map((e) => DropdownMenuItem<String>(
          value: e,
          child: Text(e),
        )).toList(),
        onChanged: (value) {
          setState(() {
            _selectedDifficulty = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Konu anlatım seviyesi nasıl olsun?',
          labelStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Color(0xFFFFFCF2)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {
        if (_textController1.text.trim().isEmpty || _textController2.text.trim().isEmpty || _selectedDifficulty == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lütfen tüm alanları doldurun')),
          );
        } else {
          _calculateResult();
        }
      },
      child: Text(
        'Konuyu Anlat',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Container(
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
    );
  }
}
