import 'dart:math';

import 'package:english_learning/config/colors.dart';
import 'package:english_learning/config/widgets.dart';
import 'package:english_learning/core/models/quiz.dart';
import 'package:english_learning/features/test/bloc/test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatefulWidget {
  static const routeName = '/testPage';

  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TestBloc _bloc = TestBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = ModalRoute.of(context)!.settings.arguments as String;
    _bloc.add(LoadEvent(theme: theme));
  }

  List<Word> getRandomWords(List<Word> words, int questionNo) {
    final correctWord = words[questionNo];
    final uniqueWords = <String, Word>{};

    for (final word in words) {
      final key = word.translation.trim().toLowerCase();

      if (key != correctWord.translation.trim().toLowerCase()) {
        uniqueWords.putIfAbsent(key, () => word);
      }
    }

    final candidates = uniqueWords.values.toList()..shuffle();

    if (candidates.length < 3) {
      throw _bloc.close();
    }

    return [...candidates.take(3), correctWord]..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inputController = TextEditingController();

    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: Widgets.appBar,
        body: Center(
          child: BlocBuilder<TestBloc, TestState>(
            builder: (context, state) {
              return switch (state) {
                TestLoaded() => () {
                    final Word word = state.quiz.words[state.questionNo];
                    final bool isFieldOption = Random().nextBool();

                    late List<Word> options;
                    if (!isFieldOption) {
                      options =
                          getRandomWords(state.quiz.words, state.questionNo);
                    }

                    inputController.clear();

                    return Widgets.scaffoldContainer(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Widgets.text("Вопрос #${state.questionNo + 1}",
                              size: 24),
                          SizedBox(
                            height: 10,
                          ),
                          Widgets.text(
                              'Как будет "${word.english}" на ${state.quiz.language}?',
                              size: 18),
                          SizedBox(
                            height: 10,
                          ),
                          isFieldOption
                              ? Widgets.field("Введите ответ", inputController)
                              : Column(
                                  children: [
                                    ...options.map((option) => Widgets.button(
                                          option.translation,
                                          () => _bloc.add(
                                            NextQuestionEvent(
                                              answer: option.translation,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                          isFieldOption
                              ? Widgets.button(
                                  state.questionNo ==
                                          state.quiz.words.length - 1
                                      ? "Окончить"
                                      : "Проверить",
                                  () => _bloc.add(
                                    NextQuestionEvent(
                                      answer: inputController.text,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    );
                  }(),
                TestPassed() => () {
                    List<Word> words = state.quiz.words;
                    int correctWords = 0;
                    for (final Word word in words) {
                      if (word.isCorrect()) {
                        correctWords += 1;
                      }
                    }

                    words.sort(
                      (a, b) => a.isCorrect() ? 0 : 1,
                    );

                    return Column(
                      children: [
                        Widgets.text("Ты прошёл! Счет: $correctWords/10.",
                            size: 24),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: words.length,
                            itemBuilder: (context, index) {
                              Word word = words[index];
                              final bool isCorrect = word.isCorrect();

                              Widget answerContent;
                              if (isCorrect) {
                                answerContent = Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryMainAccent
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Widgets.text("Ответ: ${word.answer}"),
                                );
                              } else {
                                answerContent = Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Widgets.text("У вас:"),
                                            Widgets.text(
                                              word.answer.isEmpty
                                                  ? "(пусто)"
                                                  : word.answer,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryMainAccent
                                              .withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Widgets.text("Правильно:"),
                                            Widgets.text(word.translation),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return Card(
                                color: AppColors.secondaryBackgroundColor,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isCorrect
                                        ? AppColors.primaryMainAccent
                                        : Colors.redAccent,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            isCorrect
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                            color: isCorrect
                                                ? AppColors.primaryMainAccent
                                                : Colors.redAccent,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Widgets.text(word.english),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      answerContent,
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }(),
                TestInitial() => CircularProgressIndicator(),
                TestLoading() => CircularProgressIndicator(),
                TestError() => Text(
                    state.error,
                    style: TextStyle(color: Colors.white),
                  ),
                _ => Text(
                    "Error 404",
                    style: TextStyle(color: Colors.white),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
