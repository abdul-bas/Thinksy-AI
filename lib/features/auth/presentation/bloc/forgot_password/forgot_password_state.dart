import 'package:equatable/equatable.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';


class ForgotPasswordState extends Equatable {
  final FormStatus status;
  final String? errorMessage;

  const ForgotPasswordState({
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({FormStatus? status, String? errorMessage}) {
    return ForgotPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}