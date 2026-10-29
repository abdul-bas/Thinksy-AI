

import 'package:thinksy_ai/features/chat/domain/entities/chat_reply.dart';
import 'package:thinksy_ai/features/chat/domain/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  const SendMessage(this.repository);

  Future<ChatReply> call({
    required String text,
    String? previousInteractionId,
  }) {
    return repository.sendMessage(
      message: text,
      previousInteractionId: previousInteractionId,
    );
  }
}