import 'package:flutter/foundation.dart';
import 'package:groq/groq.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GroqService {
  static const String _apiKeyKey = 'groq_api_key';
  Groq? _groq;

  Groq? get client => _groq;

  // Initialize with API key from secure storage or .env file
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    String? apiKey = prefs.getString(_apiKeyKey);

    debugPrint('GroqService: Initializing...');
    debugPrint(
        'GroqService: API key from prefs: ${apiKey?.isNotEmpty == true ? "FOUND" : "NOT FOUND"}');

    // If not found in shared preferences, try to get from .env file
    if (apiKey == null || apiKey.isEmpty) {
      apiKey = dotenv.env['GROQ_API_KEY'];
      debugPrint(
          'GroqService: API key from .env: ${apiKey?.isNotEmpty == true ? "FOUND" : "NOT FOUND"}');

      if (apiKey != null && apiKey.isNotEmpty) {
        // Save the API key from .env to shared preferences for future use
        await prefs.setString(_apiKeyKey, apiKey);
      }
    }

    if (apiKey != null && apiKey.isNotEmpty) {
      final groqConfiguration = Configuration(
        model: "openai/gpt-oss-120b", // Using the requested model
        temperature: 0.7,
        seed: 10,
      );
      final newGroq = Groq(
        apiKey: apiKey,
        configuration: groqConfiguration,
      );

      // IMPORTANT: startChat() must be called BEFORE setCustomInstructionsWith()
      newGroq.startChat();

      newGroq.setCustomInstructionsWith(
        "Just answer in plain text. Do not use any markdown formatting or output.",
      );

      _groq = newGroq;
      debugPrint('GroqService: Client initialized successfully');
    } else {
      debugPrint('GroqService: No API key found during initialization');
    }
  }

  // Set API key and initialize client
  Future<void> setApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyKey, apiKey);

    final groqConfiguration = Configuration(
      model: "openai/gpt-oss-120b", // Using the requested model
      temperature: 0.7,
      seed: 10,
    );
    final newGroq = Groq(
      apiKey: apiKey,
      configuration: groqConfiguration,
    );

    // IMPORTANT: startChat() must be called BEFORE setCustomInstructionsWith()
    newGroq.startChat();

    newGroq.setCustomInstructionsWith(
      "Just answer in plain text. Do not use any markdown formatting or output.",
    );

    _groq = newGroq;
  }

  // Check if API key is configured
  Future<bool> isConfigured() async {
    final prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString(_apiKeyKey);
    return apiKey != null && apiKey.isNotEmpty;
  }

  // Clear API key
  Future<void> clearApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_apiKeyKey);
    _groq = null;
  }
}

// Singleton instance
final groqService = GroqService();
