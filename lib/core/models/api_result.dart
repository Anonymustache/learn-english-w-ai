import 'package:english_learning/core/models/quiz.dart';

class ApiResult {}

class ApiError extends ApiResult {
  final String error;

  ApiError({
    required this.error,
  });
}

class ApiResponse extends ApiResult {
  final Quiz data;

  ApiResponse({
    required this.data,
  });
}