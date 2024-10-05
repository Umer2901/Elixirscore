import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/key.dart';
import 'package:flutter_application_elixirscore/providers/chat_services.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // Replace with your OpenAI API key.
  final ChatGPTService chatGPTService = ChatGPTService(OPENAI_API_KEY);

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "content": _controller.text});
      _isLoading = true;
    });

    String response = await chatGPTService.getChatResponse(_controller.text);

    setState(() {
      _messages.add({"role": "assistant", "content": response});
      _isLoading = false;
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elixir'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['role'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message['role'] == 'user'
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['content'] ?? '',
                        style: TextStyle(
                          color: message['role'] == 'user'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _controller, name: 'Elixir',
                    hintText: "Message Elixir",
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
