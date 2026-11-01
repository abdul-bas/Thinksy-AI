import 'package:equatable/equatable.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';


class LoginState extends Equatable {
  final FormStatus status;
  final bool isPasswordVisible;
  final String? errorMessage;

  const LoginState({
    this.status = FormStatus.initial,
    this.isPasswordVisible = false,
    this.errorMessage,
  });

  LoginState copyWith({
    FormStatus? status,
    bool? isPasswordVisible,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, isPasswordVisible, errorMessage];
}