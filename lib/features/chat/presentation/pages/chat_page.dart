import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:thinksy_ai/features/chat/presentation/bloc/chat_event.dart';
import 'package:thinksy_ai/features/chat/presentation/bloc/chat_state.dart';
import 'package:thinksy_ai/features/chat/presentation/widgets/chat_input.dart';
import 'package:thinksy_ai/features/chat/presentation/widgets/empty_chat_view.dart';
import 'package:thinksy_ai/features/chat/presentation/widgets/message_bubble.dart';
import 'package:thinksy_ai/features/chat/presentation/widgets/typing_indicator.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thinksy AI',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (previous, current) =>
                previous.messages.isEmpty != current.messages.isEmpty,
            builder: (context, state) {
              if (state.messages.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'New chat',
                icon: const Icon(Icons.add_comment_outlined),
                onPressed: () =>
                    context.read<ChatBloc>().add(const ChatCleared()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.messages.isEmpty && !state.isLoading) {
                  return EmptyChatView(
                    onSuggestionSelected: (text) =>
                        context.read<ChatBloc>().add(MessageSubmitted(text)),
                  );
                }
                final reversed = state.messages.reversed.toList();
                final extra = state.isLoading ? 1 : 0;
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  itemCount: reversed.length + extra,
                  itemBuilder: (context, index) {
                    if (state.isLoading && index == 0) {
                      return const TypingIndicator();
                    }
                    final message = reversed[index - extra];
                    return MessageBubble(
                      key: ValueKey(message.id),
                      message: message,
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              return ChatInput(
                isLoading: state.isLoading,
                onSubmitted: (text) =>
                    context.read<ChatBloc>().add(MessageSubmitted(text)),
              );
            },
          ),
        ],
      ),
    );
  }
}