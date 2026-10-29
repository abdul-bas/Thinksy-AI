import 'package:equatable/equatable.dart';
import 'package:thinksy_ai/features/chat/domain/entities/chat_message.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? interactionId;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.interactionId,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? interactionId,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      interactionId: interactionId ?? this.interactionId,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, interactionId];
}