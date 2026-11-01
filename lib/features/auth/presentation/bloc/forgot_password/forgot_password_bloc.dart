import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/error/failure.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/send_password_reset.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final SendPasswordReset sendPasswordReset;

  ForgotPasswordBloc({required this.sendPasswordReset})
      : super(const ForgotPasswordState()) {
    on<ForgotPasswordSubmitted>(onForgotPasswordSubmitted);
  }

  Future<void> onForgotPasswordSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state.status == FormStatus.loading) return;
    emit(state.copyWith(status: FormStatus.loading));
    try {
      await sendPasswordReset(event.email.trim());
      emit(state.copyWith(status: FormStatus.success));
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: failure.message,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: 'Unexpected error. Please try again.',
        ),
      );
    }
  }
}