import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_elixirscore/providers/chat_provider.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    String uid = Get.arguments as String;
    Provider.of<ChatProvider>(context, listen: false).loadChatHistory(uid);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            Get.back();
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
            onPressed: () {
              // Get the UID again to clear the chat history for this user
              String uid = Get.arguments as String;
              chatProvider.clearChatHistory(uid);
            },
          )
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatProvider.chatHistory.length,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 60),
                itemBuilder: (context, index) {
                  final entry = chatProvider.chatHistory[index];
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
                        controller: chatProvider.controller,
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
                        onPressed: () {
                          String uid = Get.arguments as String;
                          chatProvider.sendMessage(uid);
                        },
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
