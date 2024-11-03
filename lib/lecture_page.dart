import 'package:flutter/material.dart';
import 'package:gevmini/api.dart'; // Import ApiService
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; // Dart file that keeps username

class LecturePage extends StatefulWidget {
  const LecturePage({Key? key}) : super(key: key);

  @override
  _LecturePageState createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  String? _selectedDifficulty; // For difficulty level
  final ApiService apiService = ApiService(); // Initialize ApiService

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  Future<void> _calculateResult() async {
    try {
      // Combine the field, topic, and difficulty to find the explanation
      final apiResult = await apiService.findAnswer(
        '${_textController1.text.trim()} - ${_textController2.text.trim()}',
        _selectedDifficulty!,
      );

      // Show result in a popup
      _showResultPopup(apiResult ?? 'Bir açıklama bulunamadı');
    } catch (e) {
      _showResultPopup('Bir hata oluştu: $e');
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
                    'GeVmini',
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
                    'GeVmini',
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
            SizedBox(height: 40),
            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String hint}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
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
        if (_textController1.text.trim().isEmpty ||
            _textController2.text.trim().isEmpty ||
            _selectedDifficulty == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lütfen tüm alanları doldurun')),
          );
        } else {
          _calculateResult();
        }
      },
      child: Text(
        'Konu Özetini Oluştur',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
