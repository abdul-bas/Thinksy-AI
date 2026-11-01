import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/error/failure.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/register.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_event.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register register;

  RegisterBloc({required this.register}) : super(const RegisterState()) {
    on<RegisterSubmitted>(onRegisterSubmitted);
    on<RegisterPasswordVisibilityToggled>(onPasswordVisibilityToggled);
  }

  Future<void> onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status == FormStatus.loading) return;
    emit(state.copyWith(status: FormStatus.loading));
    try {
      await register(
        name: event.name.trim(),
        email: event.email.trim(),
        password: event.password,
      );
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
    RegisterPasswordVisibilityToggled event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }
}