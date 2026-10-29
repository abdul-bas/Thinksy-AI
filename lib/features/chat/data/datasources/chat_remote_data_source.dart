import 'package:dio/dio.dart';
import 'package:thinksy_ai/core/constants/api_constants.dart';
import 'package:thinksy_ai/core/error/failure.dart';
import 'package:thinksy_ai/features/chat/domain/entities/chat_reply.dart';

abstract class ChatRemoteDataSource {
  Future<ChatReply> sendMessage({
    required String message,
    String? previousInteractionId,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  const ChatRemoteDataSourceImpl(this.dio);

  @override
  Future<ChatReply> sendMessage({
    required String message,
    String? previousInteractionId,
  }) async {
    if (ApiConstants.apiKey.isEmpty) {
      throw const Failure(
        'Missing API key. Run the app with --dart-define=GEMINI_API_KEY=${ApiConstants.apiKey}',
      );
    }

    final body = <String, dynamic>{
      'model': ApiConstants.model,
      'input': [
        {'type': 'text', 'text': message},
      ],
    };
    if (previousInteractionId != null && previousInteractionId.isNotEmpty) {
      body['previous_interaction_id'] = previousInteractionId;
    }

    try {
      final response = await dio.post<dynamic>(
        ApiConstants.interactionsPath,
        data: body,
      );
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const Failure('Unexpected response from the server.');
      }
      final text = extractText(data);
      if (text.isEmpty) {
        throw const Failure('The model returned an empty response.');
      }
      final id = data['id'];
      return ChatReply(text: text, interactionId: id is String ? id : null);
    } on DioException catch (error) {
      print('............................................... $error');
      throw Failure(describeDioError(error));
    }
  }

  String extractText(Map<String, dynamic> data) {
    final outputs = data['outputs'];
    if (outputs is List) {
      for (final item in outputs.reversed) {
        final text = readText(item);
        if (text.isNotEmpty) return text;
      }
    }
    final steps = data['steps'];
    if (steps is List) {
      final buffer = StringBuffer();
      for (final step in steps) {
        if (step is Map && step['type'] == 'user_input') continue;
        buffer.write(readText(step));
      }
      return buffer.toString().trim();
    }
    return '';
  }

  String readText(dynamic node) {
    if (node is Map) {
      final text = node['text'];
      if (text is String && text.trim().isNotEmpty) return text.trim();
      final content = node['content'];
      if (content is List) {
        final buffer = StringBuffer();
        for (final part in content) {
          buffer.write(readText(part));
        }
        return buffer.toString().trim();
      }
    }
    return '';
  }

  String describeDioError(DioException error) {
    final data = error.response?.data;
    if (data is Map && data['error'] is Map) {
      final message = (data['error'] as Map)['message'];
      if (message is String && message.isNotEmpty) return message;
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The request timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return 'Something went wrong (${error.response?.statusCode ?? 'network'}).';
    }
  }
}
