import 'package:flutter/material.dart';
import 'package:thinksy_ai/core/enum/chat_role.dart';
import 'package:thinksy_ai/features/chat/domain/entities/chat_message.dart';
import 'package:thinksy_ai/features/chat/presentation/widgets/bubble.dart';



class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isUser = message.role == ChatRole.user;

    final Color background;
    final Color foreground;
    if (message.isError) {
      background = scheme.errorContainer;
      foreground = scheme.onErrorContainer;
    } else if (isUser) {
      background = scheme.primary;
      foreground = scheme.onPrimary;
    } else {
      background = scheme.surfaceContainerHigh;
      foreground = scheme.onSurface;
    }

    

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: scheme.primaryContainer,
              child: Icon(
                message.isError ? Icons.error_outline : Icons.auto_awesome,
                size: 18,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Bubble(background: background, isUser: isUser, message: message, foreground: foreground),
          if (isUser) const SizedBox(width: 4),
        ],
      ),
    );
  }
}
