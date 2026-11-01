import 'package:equatable/equatable.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';



class RegisterState extends Equatable {
  final FormStatus status;
  final bool isPasswordVisible;
  final String? errorMessage;

  const RegisterState({
    this.status = FormStatus.initial,
    this.isPasswordVisible = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    FormStatus? status,
    bool? isPasswordVisible,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, isPasswordVisible, errorMessage];
}