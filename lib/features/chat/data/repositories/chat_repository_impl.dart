

import 'package:thinksy_ai/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:thinksy_ai/features/chat/domain/entities/chat_reply.dart';
import 'package:thinksy_ai/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  const ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChatReply> sendMessage({
    required String message,
    String? previousInteractionId,
  }) {
    return remoteDataSource.sendMessage(
      message: message,
      previousInteractionId: previousInteractionId,
    );
  }
}