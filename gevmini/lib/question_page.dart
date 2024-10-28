import 'package:flutter/material.dart';
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; //dart file it keeps username

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        backgroundColor: Color(0xFF004E98), // Ana arka plan rengi
//        body: Center(
//          child: Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: CustomScreen(),
//          ),
//        ),
//      ),
//    );
//  }
//}

class QuestionPage extends StatefulWidget {

const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool isExplanationVisible = false;
  bool showAdditionalButtons = false;
  final TextEditingController _textController = TextEditingController(); // textController
  
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

        // Question Area
        Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
              'qui officia deserunt mollit anim id est laborum.',
              style: TextStyle(
                color: Colors.white, 
                fontFamily: 'PlayfairDisplay', 
                fontSize: 16
                ),
            ),
          ),
        SizedBox(height: 10),

        Container(
              margin: EdgeInsets.symmetric(vertical: 20),
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
                  hintText: 'Cevabınızı buraya yazın...',
                  hintStyle: TextStyle(color: Colors.grey),
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
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          ),
          onPressed: () { //onclick method
            if (_textController.text.trim().isEmpty) { //toast message and other buttons visibility
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lütfen bir cevap girin ${userName}')),
              );
            } else {
              setState(() {
                showAdditionalButtons = true;
              });
            }
          },
          child: Text(
            'Kontrol Et',
            style: TextStyle(color: Colors.white),
          ),
        ),

        if (showAdditionalButtons) ...[  // visibility
          //space between buttons
          SizedBox(width: 5),
          //Explain question button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFFFFFCF2)),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            onPressed: () {
              NativeDialogPlus(
                actions: [
                NativeDialogPlusAction(
                        text: 'Kapat',
                        style: NativeDialogPlusActionStyle.defaultStyle,
                    ),
                ],
                title: 'İşte Sorunun Açıklaması :',
                message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                          'qui officia deserunt mollit anim id est laborum.'
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                          'qui officia deserunt mollit anim id est laborum.'
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                          'qui officia deserunt mollit anim id est laborum.'
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                          'qui officia deserunt mollit anim id est laborum.'
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                          'qui officia deserunt mollit anim id est laborum.'
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                          'qui officia deserunt mollit anim id est laborum.'
                  ).show();
                },
            child: Text(
              'Soruyu Açıkla',
              style: TextStyle(color: Colors.white),
            ),
          ),
          //space between buttons
          SizedBox(width: 5),
          //next quesetion button
          IconButton(
            icon: Icon(Icons.arrow_forward),
            color: Color(0xFFFFFCF2),
            onPressed: () {
              // //onclick method
            setState(() {
              showAdditionalButtons = false;
              isExplanationVisible = false;
            });
            },
          ),
        ],
      ],
    ),
    SizedBox(height: 20),
        ],
      ),
    ),
    );
  }
}
