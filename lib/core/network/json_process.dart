import 'dart:convert';

import 'package:english_learning/core/models/quiz.dart';

class JsonProcess {
  static Quiz throwError(String error) {
    return Quiz(
      theme: "",
      language: "",
      words: [],
      error: error,
    );
  }

  static Quiz processData(String data) {
    if (data.substring(0, 7) == "```json") {
      data = data.substring(7);
    }

    if (data.substring(data.length - 3, data.length) == "```") {
      data = data.substring(0, data.length - 3);
    }

    late Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(data);
    } catch (error) {
      return throwError("Json decode error: $error");
    }

    if (!jsonData.containsKey("theme") || jsonData["theme"] == null) {
      return throwError("Missing theme!");
    }
    if (!jsonData.containsKey("language") || jsonData["language"] == null) {
      return throwError("Missing language!");
    }
    if (!jsonData.containsKey("words") || jsonData["words"] == null) {
      return throwError("Missing words!");
    }

    for (int index = jsonData["words"].length - 1; index >= 0; index--) {
      Map word = jsonData["words"][index];
      jsonData["words"][index] = Word(
        english: word["english"],
        translation: word["translation"],
      );
    }

    List<Word> parsedWords = [];
    jsonData["words"].forEach((word) => parsedWords.add(word));

    return Quiz(
      theme: jsonData["theme"],
      language: jsonData["language"],
      words: parsedWords,
    );
  }
}
