import 'package:equatable/equatable.dart';

class ChatReply extends Equatable {
  final String text;
  final String? interactionId;

  const ChatReply({required this.text, this.interactionId});

  @override
  List<Object?> get props => [text, interactionId];
}