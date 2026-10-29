

import 'package:thinksy_ai/features/chat/domain/entities/chat_reply.dart';

abstract class ChatRepository {
  
  Future<ChatReply> sendMessage({
    required String message,
    String? previousInteractionId,
  });
}