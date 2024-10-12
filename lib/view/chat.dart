import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/key.dart';
import 'package:flutter_application_elixirscore/providers/chat_services.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ChatGPTService chatGPTService = ChatGPTService(OPENAI_API_KEY);
  List<Map<String, String>> chatHistory = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
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

  void _loadChatHistory() async {
    // Implement chat history loading logic here if needed
    setState(() {});
  }

  void _clearChatHistory() {
    setState(() {
      chatHistory.clear();
    });
  }

  void _sendMessage() async {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      _animationController.forward().then((_) {
        _animationController.reset();
      });
      setState(() {
        chatHistory.add({"role": "user", "content": text});
      });
      _controller.clear();
      String response = await chatGPTService.getChatResponse(text, chatHistory);
      setState(() {
        chatHistory.add({"role": "assistant", "content": response});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Image.asset(
          'assets/images/eye.png',
          height: 30,
          color: Colors.red,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.blue),
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
                        decoration: InputDecoration(
                          hintText: "Message Elixir 😊",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        decoration: BoxDecoration(
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