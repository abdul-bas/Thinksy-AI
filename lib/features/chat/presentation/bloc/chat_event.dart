import 'package:equatable/equatable.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class MessageSubmitted extends ChatEvent {
  final String text;

  const MessageSubmitted(this.text);

  @override
  List<Object?> get props => [text];
}

class ChatCleared extends ChatEvent {
  const ChatCleared();
}