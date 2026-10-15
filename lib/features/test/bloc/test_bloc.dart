import 'package:english_learning/core/functions/sound.dart';
import 'package:english_learning/core/models/quiz.dart';
import 'package:english_learning/core/network/api_client.dart';
import 'package:english_learning/core/models/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'test_state.dart';
part 'test_event.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<ErrorEvent>((event, emit) async {
        emit(TestError(error: event.error));
    });

    on<LoadEvent>((event, emit) async {
      emit(TestLoading());

      final ApiResult response = await ApiClient.postRequest(event.theme);
      if (response is ApiResponse) {
        emit(TestLoaded(quiz: response.data));
      } else if (response is ApiError) {
        add(ErrorEvent(error: response.error));
      }
    });

    on<NextQuestionEvent>((event, emit) async {
      final TestState currentState = state;

      if (currentState is TestLoaded) {
        final List<Word> words = currentState.quiz.words;
        final Word word = words[currentState.questionNo];

        word.answer = event.answer;

        if (word.isCorrect()) {
          await Sound.playSound("sounds/ding.mp3");
        } else {
          await Sound.playSound("sounds/error.mp3");
        }

        if (currentState.questionNo + 1 < words.length) {
          emit(
            TestLoaded(
              quiz: currentState.quiz,
              questionNo: currentState.questionNo + 1,
            ),
          );
        } else {
          emit(TestPassed(quiz: currentState.quiz));
        }
      }
    });
  }
}
