import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/key.dart';
import 'package:flutter_application_elixirscore/providers/chat_services.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:flutter_application_elixirscore/constants/images.dart'; // Import AppImages class

// ChatScreen Widget
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatGPTService chatGPTService = ChatGPTService(OPENAI_API_KEY); // Use the constant API key
  List<Map<String, String>> chatHistory = []; // List to store chat history

  @override
  void initState() {
    super.initState();
    _loadChatHistory(); // Load chat history on screen initialization
  }

  // Method to load chat history (if needed)
  void _loadChatHistory() async {
    setState(() {});
  }

  // Clear chat history
  void _clearChatHistory() async {
    setState(() {
      chatHistory.clear();
    });
  }

  // Send message and get response
  void _sendMessage() async {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        chatHistory.add({"role": "user", "content": text});
      });
      String response = await chatGPTService.getChatResponse(text, chatHistory);
      setState(() {
        chatHistory.add({"role": "assistant", "content": response});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppImages.eye, // Use the asset path defined in AppImages
          height: 40, // Set the height for the icon
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearChatHistory, // Button to clear chat history
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display chat history
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  final entry = chatHistory[index];
                  return ListTile(
                    title: Align(
                      alignment: entry['role'] == 'user'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: entry['role'] == 'user'
                              ? Colors.blue[200]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "AppleColorEmoji", // Enable emoji support
                              color: Colors.black, // Text color
                            ),
                            children: [
                              TextSpan(text: entry['content']),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // TextField with Send Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Message Elixir 😊",
                    ),
                    keyboardType: TextInputType.multiline, // Multiline input
                    textInputAction: TextInputAction.newline, // Create new line on enter
                    textCapitalization: TextCapitalization.sentences, // Capitalize first letter
                    maxLines: null, // No limit on number of lines
                    style: const TextStyle(fontSize: 18), // Font size to support emojis
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage, // Send message on button press
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}