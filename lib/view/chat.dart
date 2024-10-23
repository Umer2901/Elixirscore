import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/key.dart';
import 'package:flutter_application_elixirscore/providers/chat_services.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';

class ChatScreen extends StatefulWidget {
  final String uid; // UID for identifying the user in Firestore

  const ChatScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ChatGPTService chatGPTService = ChatGPTService(OPENAI_API_KEY);
  List<Map<String, String>> chatHistory = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadChatHistory(); // Load chat history from Firestore on initialization
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: -50).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Load chat history from Firestore
  void _loadChatHistory() async {
    try {
      // Get the document for the current user based on UID
      final doc = await _firestore.collection('chats').doc(widget.uid).get();

      // If document exists, load the messages array into chatHistory
      if (doc.exists) {
        final data = doc.data();
        final List<dynamic> messages = data?['messages'] ?? [];

        setState(() {
          chatHistory = messages
              .map((message) => {
                    'role': message['role'] as String,
                    'content': message['content'] as String,
                  })
              .toList();
        });
      }
    } catch (e) {
      print('Error loading chat history: $e');
    }
  }

  // Save a message to Firestore in a messages array
  Future<void> _saveMessageToFirestore(String role, String content) async {
    try {
      // Get the current document for the user
      final chatDocRef = _firestore.collection('chats').doc(widget.uid);

      // Create a message map
      final newMessage = {'role': role, 'content': content};

      // Update the document with a new message in the messages array
      await chatDocRef.set({
        'messages': FieldValue.arrayUnion([newMessage]),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error saving message to Firestore: $e');
    }
  }

  // Clear chat history in Firestore and locally
  void _clearChatHistory() async {
    setState(() {
      chatHistory.clear();
    });

    try {
      // Clear the messages array in Firestore for the specific user
      await _firestore.collection('chats').doc(widget.uid).update({
        'messages': [],
      });
    } catch (e) {
      print('Error clearing chat history: $e');
    }
  }

  // Handle sending a message
  void _sendMessage() async {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      _animationController.forward().then((_) {
        _animationController.reset();
      });

      // Save user message locally and in Firestore
      setState(() {
        chatHistory.add({"role": "user", "content": text});
      });
      _controller.clear();
      await _saveMessageToFirestore('user', text);

      // Get the AI response and save it locally and in Firestore
      String response = await chatGPTService.getChatResponse(text, chatHistory);
      setState(() {
        chatHistory.add({"role": "assistant", "content": response});
      });
      await _saveMessageToFirestore('assistant', response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.blue),
            onPressed: _clearChatHistory,
          )
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 60),
                itemBuilder: (context, index) {
                  final entry = chatHistory[index];
                  final isUser = entry['role'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[600] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        entry['content'] ?? '',
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              color: Colors.grey[100],
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Message Elixir 😊",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: null,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: child,
                        );
                      },
                      child: CustomUpArrowButton(
                        onPressed: _sendMessage,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomUpArrowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;

  const CustomUpArrowButton({
    Key? key,
    required this.onPressed,
    this.size = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_upward,
            color: Colors.white,
            size: size * 0.6,
          ),
        ),
      ),
    );
  }
}
