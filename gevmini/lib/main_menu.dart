import 'package:flutter/material.dart';
import 'package:gevmini/ask_question.dart';
import 'package:gevmini/question_page.dart';
import 'package:gevmini/motivate_page.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    QuestionPage(),
    MotivationPage(),
    AskQuestionPage(),
    Center(child: Text('Profil Sayfası', style: TextStyle(fontSize: 24))),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Color(0xFF004E98),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Soru Oluştur',
            tooltip: 'Soru Oluştur',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Motivasyon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Soru Sor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
