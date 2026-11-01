import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/error/failure.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';

import '../../../domain/usecases/sign_in.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignIn signIn;

  LoginBloc({required this.signIn}) : super(const LoginState()) {
    on<LoginSubmitted>(onLoginSubmitted);
    on<LoginPasswordVisibilityToggled>(onPasswordVisibilityToggled);
  }

  Future<void> onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status == FormStatus.loading) return;
    emit(state.copyWith(status: FormStatus.loading));
    try {
      await signIn(email: event.email.trim(), password: event.password);
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

  void onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }
}