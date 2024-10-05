import 'dart:convert';
import 'package:flutter_application_elixirscore/constants/key.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ChatGPTService {
  final String apiKey;
  final String apiUrl = "https://api.openai.com/v1/chat/completions";

  ChatGPTService(this.apiKey);

  Future<String> getChatResponse(String message) async {
    int maxRetries = 5;
    int retryCount = 0;
    int retryDelay = 2; // Initial delay in seconds

    while (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $OPENAI_API_KEY',
          },
          body: jsonEncode({
            // Change the model name here
            "model": "gpt-4", // Use "gpt-4" or "gpt-3.5-turbo" instead
            "messages": [
              {"role": "user", "content": message}
            ],
            "max_tokens": 100,
          }),
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          return jsonResponse['choices'][0]['message']['content'].trim();
        } else if (response.statusCode == 429) {
          // Extract 'Retry-After' header if available
          int retryAfter = int.tryParse(response.headers['retry-after'] ?? '1') ?? retryDelay;
          print('Rate limit exceeded. Retrying after $retryAfter seconds...');
          await Future.delayed(Duration(seconds: retryAfter));
          retryCount++;
        } else if (response.statusCode == 404) {
          // Handle 404 Not Found Error
          print("Error: 404 - Endpoint or model not found. Check your API URL and model name.");
          return "Error: 404 - Endpoint or model not found. Please check the API URL and model name.";
        } else {
          print("Error: ${response.statusCode} - ${response.reasonPhrase}");
          return "Error: ${response.statusCode} - ${response.reasonPhrase}";
        }
      } catch (e) {
        print("Exception: $e");
        retryCount++;
        await Future.delayed(Duration(seconds: retryDelay * retryCount)); // Increase delay between retries
      }
    }
    return "Error: Exceeded maximum retry attempts. Please try again later.";
  }
}