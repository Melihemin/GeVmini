import 'package:flutter/material.dart';
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; //dart file it keeps username

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  bool isExplanationVisible = false;
  bool showAdditionalButtons = false;
  final TextEditingController _textController1 = TextEditingController(); // First textController
  final TextEditingController _textController2 = TextEditingController(); // Second textController
  String result = ''; // Result text

  // Chat messages list
  List<ChatBubble> messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  void _calculateResult() {
    setState(() {
      // Combining input from two text fields as an example result
      result = 'Birinci Girdi: ${_textController1.text}\nİkinci Girdi: ${_textController2.text}';
    });
  }

  // Function to add new message
  void _addMessage(String messageText) {
    setState(() {
      messages.add(
        ChatBubble(
          text: messageText,
          isUserMessage: true,
        ),
      );
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
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
            MessageInput(onSend: (text) {
              _addMessage(text);
            }),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  ChatBubble({required this.text, required this.isUserMessage});

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

class MessageInput extends StatefulWidget {
  final Function(String) onSend;

  MessageInput({required this.onSend});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final messageText = _controller.text;
    if (messageText.isNotEmpty) {
      widget.onSend(messageText); // Call the onSend function passed from ChatBotPage
      _controller.clear(); // Clear the input field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }
}
