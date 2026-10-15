part of 'test_bloc.dart';

class TestEvent {}

class LoadEvent extends TestEvent {
  final String theme;

  LoadEvent({
    required this.theme,
  });
}

class NextQuestionEvent extends TestEvent {
  final String answer;

  NextQuestionEvent({
    required this.answer,
  });
}

class ErrorEvent extends TestEvent {
  final String error;

  ErrorEvent({
    required this.error,
  });
}
