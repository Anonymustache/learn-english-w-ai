import 'package:dio/dio.dart';

class ApiConstants {
  static const String prompt =
      '''You'll be given a theme and your task is to send back 10 random words in English and selected language related to the theme without any unnecessary comments strictly in a full JSON format: {
    "theme": "theme",
    "language": "selectedLanguage",
    "words": [
      {"english": "word_1", "translation": "translation_1"},
    ]
  }''';

  static const String apiToken = String.fromEnvironment('API_KEY');

  static const String url = "https://api.groq.com/openai/v1/chat/completions";
  static final Options options = Options(
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiToken",
    },
  );
}
