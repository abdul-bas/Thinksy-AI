import 'package:dio/dio.dart';
import 'package:thinksy_ai/core/constants/api_constants.dart';


class DioClient {
  const DioClient();

  Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 90),
        sendTimeout: const Duration(seconds: 30),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-goog-api-key': ApiConstants.apiKey,
        },
      ),
    );
  }
}