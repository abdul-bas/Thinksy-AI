import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/enum/chat_role.dart';
import 'package:thinksy_ai/core/error/failure.dart';
import 'package:thinksy_ai/features/chat/domain/entities/chat_message.dart';
import 'package:thinksy_ai/features/chat/domain/usecases/send_message.dart';
import 'package:thinksy_ai/features/chat/presentation/bloc/chat_event.dart';
import 'package:thinksy_ai/features/chat/presentation/bloc/chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessage sendMessage;

  ChatBloc({required this.sendMessage}) : super(const ChatState()) {
    on<MessageSubmitted>(onMessageSubmitted);
    on<ChatCleared>(onChatCleared);
  }

  String newId() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> onMessageSubmitted(
    MessageSubmitted event,
    Emitter<ChatState> emit,
  ) async {
    final text = event.text.trim();
    if (text.isEmpty || state.isLoading) return;

    final userMessage = ChatMessage(
      id: newId(),
      text: text,
      role: ChatRole.user,
    );
    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isLoading: true,
      ),
    );

    try {
      final reply = await sendMessage(
        text: text,
        previousInteractionId: state.interactionId,
      );
      final assistantMessage = ChatMessage(
        id: newId(),
        text: reply.text,
        role: ChatRole.assistant,
      );
      emit(
        state.copyWith(
          messages: [...state.messages, assistantMessage],
          isLoading: false,
          interactionId: reply.interactionId,
        ),
      );
    } on Failure catch (failure) {
      emit(appendError(failure.message));
    } catch (error) {
      emit(appendError('Unexpected error. Please try again.'));
    }
  }

  ChatState appendError(String message) {
    final errorMessage = ChatMessage(
      id: newId(),
      text: message,
      role: ChatRole.assistant,
      isError: true,
    );
    return state.copyWith(
      messages: [...state.messages, errorMessage],
      isLoading: false,
    );
  }

  void onChatCleared(ChatCleared event, Emitter<ChatState> emit) {
    emit(const ChatState());
  }
}