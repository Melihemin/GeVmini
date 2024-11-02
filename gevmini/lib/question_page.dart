import 'package:flutter/material.dart';
import 'api.dart'; // ApiService'ı ekleyin

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final ApiService apiService = ApiService();
  final TextEditingController userAnswerController = TextEditingController();
  
  String question = "Sample question?"; // API'den alınacak soru
  String correctAnswer = "Sample answer"; // Doğru cevap
  double? answerPercent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: userAnswerController,
              decoration: InputDecoration(
                labelText: 'Your Answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await checkAnswer();
              },
              child: Text('Submit Answer'),
            ),
            if (answerPercent != null) 
              Text(
                'Your answer percentage: ${answerPercent!.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> checkAnswer() async {
    try {
      answerPercent = await apiService.answersPercent(userAnswerController.text, correctAnswer);
      setState(() {});
    } catch (e) {
      showError(e.toString());
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }
}