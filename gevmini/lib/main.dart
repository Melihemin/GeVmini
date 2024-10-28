import 'package:flutter/material.dart';
import 'package:gevmini/question_page.dart';
import 'global.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const MainPage(),
      '/second': (context) => const QuestionPage(),
      //'/third': (context) => const UserManual(), //User manual Page 
    },
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{


  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose(); // Clear Controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF495057),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heading
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A6EA5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'geVmini',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrainsMono', // Heading Font
                      color: Colors.white,
                      
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 50), // Some space between containers

                // TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                   child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _textController, // Adding Controller
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'İsminizi Girin...',
                    ),
                  ),
                ),
              ),
                SizedBox(height: 40), // Some space between containers

                // SignIn Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A6EA5),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                  // navigate QuestionPage
                onPressed: () {
                  if (_textController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lütfen isminizi girin')),
                    );
                  } else {
                    userName = _textController.text.trim(); // Global variable
                    Navigator.pushNamed(context, '/second');
                  }
                },
                child: Text(
                  'Giriş',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
                SizedBox(height: 40), // Some space between buttons
                
                // user manual button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF495057), // Buton color
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // user manual on click fun
                  },
                  child: Text(
                    'Kullanım Kılavuzu',
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color(0xFF8C8686),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeVmini',
      );
  }
}

