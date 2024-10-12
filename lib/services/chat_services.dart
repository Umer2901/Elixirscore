// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:io'; // Import to handle network exceptions
import 'package:flutter_application_elixirscore/constants/key.dart'; // Make sure this file contains your API key
import 'package:http/http.dart' as http;
import 'dart:async';

class ChatGPTService {
  final String apiKey;
  final String apiUrl = "https://api.openai.com/v1/chat/completions";

  // Constructor to initialize the API key
  ChatGPTService(this.apiKey);

  // Method to get ChatGPT response with two required arguments
  Future<String> getChatResponse(String message, List<Map<String, String>> chatHistory) async {
    int maxRetries = 5;
    int retryCount = 0;
    int retryDelay = 2; // Initial delay in seconds

    while (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $OPENAI_API_KEY', // Ensure this is the correct API key
          },
          body: jsonEncode({
            "model": "chatgpt-4o-latest", // Use "gpt-3.5-turbo" if you don't have access to gpt-4
            "messages": [
              {
                "role": "system",
                "content": "You are Elixir, a personalized health assistant focused on longevity, happiness, and accountability. "
                    "You should refer to yourself as Elixir in all responses. Always address yourself as 'Elixir' instead of OpenAI. "
                    "Respond using individual sentences instead of paragraphs unless necessary. Avoid using long paragraphs. Use emojis where relevant and always ask for emoji reactions. "
                    "If the response has multiple points, separate them into many messages. Be sure to give clear, actionable advice. "
                    "If the user is upset, encourage them to give feedback in their profile."
              },
              ...chatHistory.map((entry) => {"role": entry['role'], "content": entry['content']}),
              {"role": "user", "content": message}
            ],
            "max_tokens": 200, // Increased max_tokens for longer responses
            "temperature": 0.7, // Adjust for more creative responses
            "top_p": 0.9, // Ensure more deterministic responses
          }),
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(utf8.decode(response.bodyBytes)); // Use UTF-8 decoding
          print("API Response: ${jsonResponse['choices'][0]['message']['content']}"); // Log response for debugging
          return jsonResponse['choices'][0]['message']['content'].trim();
        } else if (response.statusCode == 429) {
          int retryAfter = int.tryParse(response.headers['retry-after'] ?? '1') ?? retryDelay;
          print('Rate limit exceeded. Retrying after $retryAfter seconds...');
          await Future.delayed(Duration(seconds: retryAfter));
          retryCount++;
        } else if (response.statusCode == 404) {
          print("Error: 404 - Endpoint or model not found. Check your API URL and model name.");
          return "Error: 404 - Endpoint or model not found. Please check your API URL and model name.";
        } else if (response.statusCode == 401) {
          print("Error: 401 - Unauthorized. Please check your API key.");
          return "Error: 401 - Unauthorized. Please check your API key.";
        } else if (response.statusCode == 403) {
          print("Error: 403 - Forbidden. Please ensure you have access to this model.");
          return "Error: 403 - Forbidden. Please ensure you have access to this model.";
        } else {
          print("Error: ${response.statusCode} - ${response.reasonPhrase}");
          return "Error: ${response.statusCode} - ${response.reasonPhrase}";
        }
      } catch (e) {
        if (e is SocketException) {
          print("Network error: $e");
        } else {
          print("Exception: $e");
        }
        retryCount++;
        await Future.delayed(Duration(seconds: retryDelay * retryCount)); // Increase delay between retries
      }
    }
    return "Error: Exceeded maximum retry attempts. Please try again later.";
  }
}