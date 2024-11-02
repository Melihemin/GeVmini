import 'package:flutter/material.dart';
import 'package:native_dialog_plus/native_dialog_plus.dart';
import 'global.dart'; // Dart file that keeps username
import 'package:gevmini/api.dart'; // Import ApiService
import 'dart:async';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  // Statik cache sistemi
  static List<ChatBubble>? _cachedMessages;
  static Timer? _cacheTimer;

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _messageController = TextEditingController();
  final ApiService apiService = ApiService(); // Initialize ApiService
  final ScrollController _scrollController =
      ScrollController(); // Add ScrollController

  // Chat messages list
  List<ChatBubble> messages = [];

  @override
  void initState() {
    super.initState();
    _initializeChat(); // Otomatik sohbet başlatma
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose(); // Dispose the ScrollController

    // Mevcut zamanlayıcıyı iptal et
    ChatBotPage._cacheTimer?.cancel();

    // Mesajları cache'e kaydet ve zamanlayıcıyı başlat
    ChatBotPage._cachedMessages = messages;
    ChatBotPage._cacheTimer = Timer(Duration(seconds: 7), () {
      ChatBotPage._cachedMessages = null;
      print('Sohbet geçmişi temizlendi');
    });

    super.dispose();
  }

  // Function to initialize chat with cached messages or welcome message
  void _initializeChat() {
    // Cache'de mesaj varsa onu kullan
    if (ChatBotPage._cachedMessages != null) {
      setState(() {
        messages = ChatBotPage._cachedMessages!;
      });
      _scrollToBottom();
    } else {
      // Cache boşsa hoş geldin mesajını ekle
      _addWelcomeMessage();
    }
  }

  void _addWelcomeMessage() {
    setState(() {
      messages.add(ChatBubble(
        text: 'Merhaba! Ben GeVmini, senin kişisel eğitim asistanınım. '
            'Hangi konuda yardımcı olabilirim? 🎓',
        isUserMessage: false,
      ));
    });
    _scrollToBottom(); // Scroll to bottom after adding welcome message
  }

  // Function to add user message and get guide response
  Future<void> _addMessage() async {
    String subject = _messageController.text.trim();

    if (subject.isNotEmpty) {
      setState(() {
        messages.add(ChatBubble(text: subject, isUserMessage: true));
      });

      // Clear the message input
      _messageController.clear();

      // Scroll to bottom after adding user message
      _scrollToBottom();

      // Get guide response from ApiService
      try {
        final guideResponse =
            await apiService.guide(subject); // Pass empty string for feel
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

      // Scroll to bottom after adding bot response
      _scrollToBottom();
    }
  }

  // Function to scroll to the bottom of the chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeVmini Destek', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController, // Attach the ScrollController
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
            bottomLeft:
                isUserMessage ? Radius.circular(12) : Radius.circular(0),
            bottomRight:
                isUserMessage ? Radius.circular(0) : Radius.circular(12),
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
                hintText: 'Hangi konuda yardımcı olmamı istersin 💭',
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
