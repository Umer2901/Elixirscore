// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_elixirscore/services/chat_services.dart';
import 'package:flutter_application_elixirscore/constants/key.dart';

class ChatProvider with ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final ChatGPTService chatGPTService = ChatGPTService(OPENAI_API_KEY);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  List<Map<String, String>> _chatHistory = [];
  List<Map<String, String>> get chatHistory => _chatHistory;

  void loadChatHistory(String uid) async {
    try {
      final doc = await firestore.collection('chats').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        final List<dynamic> messages = data?['messages'] ?? [];

        _chatHistory = messages
            .map((message) => {
                  'role': message['role'] as String,
                  'content': message['content'] as String,
                })
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading chat history: $e');
    }
  }

  Future<void> saveMessageToFirestore(String uid, String role, String content) async {
    try {
      final chatDocRef = firestore.collection('chats').doc(uid);
      final newMessage = {'role': role, 'content': content};

      await chatDocRef.set({
        'messages': FieldValue.arrayUnion([newMessage]),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error saving message to Firestore: $e');
    }
  }

  void clearChatHistory(String uid) async {
    _chatHistory.clear();
    notifyListeners();

    try {
      await firestore.collection('chats').doc(uid).update({
        'messages': [],
      });
    } catch (e) {
      print('Error clearing chat history: $e');
    }
  }

  Future<void> sendMessage(String uid) async {
    String text = controller.text.trim();
    if (text.isNotEmpty) {
      _chatHistory.add({"role": "user", "content": text});
      controller.clear();
      notifyListeners();
      await saveMessageToFirestore(uid, 'user', text);

      String response = await chatGPTService.getChatResponse(text, _chatHistory);
      _chatHistory.add({"role": "assistant", "content": response});
      notifyListeners();
      await saveMessageToFirestore(uid, 'assistant', response);
    }
  }
}
