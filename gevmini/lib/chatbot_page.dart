import 'package:flutter/material.dart';
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; // Dart file that keeps username
import 'package:gevmini/api.dart'; // Import ApiService

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _messageController = TextEditingController();
  final ApiService apiService = ApiService(); // Initialize ApiService

  // Chat messages list
  List<ChatBubble> messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Function to add user message and get guide response
  Future<void> _addMessage() async {
    String subject = _messageController.text.trim();
    String? feel = await _showFeelDialog(); // Get "feel" through a dialog

    if (subject.isNotEmpty && feel != null) {
      setState(() {
        messages.add(ChatBubble(text: "Subject: $subject, Feel: $feel", isUserMessage: true));
      });

      // Clear the message input
      _messageController.clear();

      // Get guide response from ApiService
      try {
        final guideResponse = await apiService.guide(subject, feel);
        setState(() {
          messages.add(ChatBubble(
            text: guideResponse ?? 'Üzgünüm, bu konuda yardımcı olamıyorum.',
            isUserMessage: false,
          ));
        });
      } catch (e) {
        setState(() {
          messages.add(ChatBubble(
            text: 'Rehberlik yaparken bir hata oluştu: $e',
            isUserMessage: false,
          ));
        });
      }
    }
  }

  // Show dialog to capture "feel" input from the user using a dropdown
  Future<String?> _showFeelDialog() async {
    String? selectedFeel;

    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Feel", style: TextStyle(color: Colors.blue)),
          content: DropdownButton<String>(
            value: selectedFeel,
            hint: Text("Select how you feel...", style: TextStyle(color: Colors.blueGrey)),
            items: <String>[
              'Happy',
              'Sad',
              'Confused',
              'Excited',
              'Frustrated',
              'Neutral'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedFeel = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(selectedFeel),
              child: Text("Submit", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gevmini Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messages[index];
                },
              ),
            ),
            MessageInput(
              onSend: () {
                _addMessage();
              },
              controller: _messageController,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatBubble({required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.grey[800],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isUserMessage ? Radius.circular(12) : Radius.circular(0),
            bottomRight: isUserMessage ? Radius.circular(0) : Radius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final Function() onSend;
  final TextEditingController controller;

  const MessageInput({required this.onSend, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a guide subject...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
