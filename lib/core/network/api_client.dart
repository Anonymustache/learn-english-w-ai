import 'package:dio/dio.dart';
import 'package:english_learning/core/models/api_result.dart';
import 'package:english_learning/core/models/quiz.dart';
import 'package:english_learning/core/network/api_constants.dart';
import 'package:english_learning/core/network/json_process.dart';

class ApiClient {
  static Dio dio = Dio();

  static Future<ApiResult> postRequest(String theme) async {
    try {
      Response response = await dio.post(
        ApiConstants.url,
        options: ApiConstants.options,
        data: {
          "model": "openai/gpt-oss-20b",
          "messages": [
            {
              "role": "system",
              "content": ApiConstants.prompt,
            },
            {
              "role": "user",
              "content": "Theme: $theme",
            },
          ],
        },
      );

      if (response.statusCode == 200) {
        final String unprocessedData =
            response.data["choices"][0]["message"]["content"];
        final Quiz processedData = JsonProcess.processData(unprocessedData);

        if (processedData.error != null) {
          return ApiError(
              error: "Json process error: ${processedData.error}");
        }

        return ApiResponse(data: processedData);
      } else {
        return ApiError(
          error:
              "Request error! Code: ${response.statusCode}, Error: ${response.statusMessage}",
        );
      }
    } on DioException catch (error) {
      return ApiError(error: "Dio exception: ${error.message ?? ""}");
    } finally {}
  }
}
