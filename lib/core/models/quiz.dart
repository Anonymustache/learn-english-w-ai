class Word {
  final String english;
  final String translation;
  String answer;

  Word({
    required this.english,
    required this.translation,
    this.answer = "",
  });

  bool isCorrect() => translation.toLowerCase() == answer.toLowerCase();
}

class Quiz {
  final String theme;
  final String language;
  final String? error;
  List<Word> words;

  Quiz({
    required this.theme,
    required this.language,
    required this.words,
    this.error,
  });
}
