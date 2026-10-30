import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final bool isCompleted;

  const SplashState({this.isCompleted = false});

  @override
  List<Object?> get props => [isCompleted];
}