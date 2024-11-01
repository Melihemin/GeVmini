import 'package:flutter/material.dart';
import 'package:gevmini/functions.dart';
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; //dart file it keeps username


class QuestionPage extends StatefulWidget {

const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool isExplanationVisible = false;
  bool showAdditionalButtons = false;
  final TextEditingController _textController = TextEditingController(); // textController;
  int? _selectedQuestionCount; // Değişkeni tanımladık
  String? _selectedDifficulty; // Değişkeni tanımladık


  @override
  void dispose() {
    _textController.dispose(); // clear Controller
    super.dispose();
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
              // logo black outline
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
              // logo wihte label
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

        Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFFFFCF2)),
              ),
              child: TextField(
                controller: _textController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Hangi konuda soru oluşturmak istersiniz ?',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFFFFCF2)),
              ),
              child: DropdownButtonFormField<int>(
                value: _selectedQuestionCount,
                items: List.generate(5, (index) => index + 1).map((e) => DropdownMenuItem<int>(
                  value: e,
                  child: Text(e.toString()),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedQuestionCount = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Kaç adet soru oluşturmalıyım ?',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

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
                items: ['Kolay', 'Orta', 'Zor', 'İleri'].map((e) => DropdownMenuItem<String>(
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
        
      //Buttons and actions
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Answer checker button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color(0xFFFFFCF2)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () { //onclick method
            if (_textController.text.trim().isEmpty || _selectedQuestionCount == null || _selectedDifficulty == null) { //toast message and other buttons visibility

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lütfen tüm alanları doldurun ${userName}')),
              );
            }else{
            NativeDialogPlus(
                actions: [
                NativeDialogPlusAction(
                        text: 'Kapat',
                        style: NativeDialogPlusActionStyle.defaultStyle,
                    ),
                ],
                title: 'İşte Oluşturmamı İstediğin Sorular :',
                //message: AidaFunctions(model).createQuiz(_textController.text, _selectedQuestionCount, _selectedDifficulty); //Attach a model in Class parameter
                  ).show();
                }
          },
          child: Text(
            'Soruları Oluştur',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    SizedBox(height: 20),
        ],
      ),
    ),
    );
  }
}
