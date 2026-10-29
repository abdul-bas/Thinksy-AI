
import 'package:flutter/material.dart';
import 'package:thinksy_ai/features/chat/domain/entities/chat_message.dart';

class Bubble extends StatelessWidget {
  const new({
    super.key,
    required this.background,
    required this.isUser,
    required this.message,
    required this.foreground,
  });

  final Color background;
  final bool isUser;
  final ChatMessage message;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 20),
          ),
        ),
        child: SelectableText(
          message.text,
          style: TextStyle(color: foreground, fontSize: 16, height: 1.4),
        ),
      ),
    );
  }
}