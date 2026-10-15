part of 'test_bloc.dart';

class TestState {}

class TestInitial extends TestState {}

class TestLoading extends TestState {}

class TestLoaded extends TestState {
  final Quiz quiz;
  final int questionNo;

  TestLoaded({
    required this.quiz,
    this.questionNo = 0,
  });
}

class TestError extends TestState {
  final String error;

  TestError({
    required this.error,
  });
}

class TestPassed extends TestState {
  final Quiz quiz;

  TestPassed({
    required this.quiz,
  });
}