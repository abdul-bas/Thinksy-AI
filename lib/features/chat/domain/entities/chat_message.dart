import 'package:equatable/equatable.dart';
import 'package:thinksy_ai/core/enum/chat_role.dart';


class ChatMessage extends Equatable {
  final String id;
  final String text;
  final ChatRole role;
  final bool isError;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.role,
    this.isError = false,
  });

  @override
  List<Object?> get props => [id, text, role, isError];
}