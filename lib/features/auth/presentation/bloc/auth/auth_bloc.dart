import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/features/auth/domain/entities/auth_user.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/sign_out.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/watch_auth_state.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final WatchAuthState watchAuthState;
  final SignOut signOut;

  AuthBloc({required this.watchAuthState, required this.signOut})
    : super(const AuthState()) {
    on<AuthStarted>(onAuthStarted);
    on<SignOutRequested>(onSignOutRequested);
  }

  Future<void> onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    await Future.delayed(Duration(seconds: 3));
    return emit.forEach<AuthUser?>(
      watchAuthState(),
      onData: (user) {
        if (user == null) {
          return const AuthState(status: AuthStatus.unauthenticated,isCompleated: true);
        }
        return AuthState(status: AuthStatus.authenticated, user: user,isCompleated: true);
      },
      onError: (error, stackTrace) {
        return const AuthState(status: AuthStatus.unauthenticated,isCompleated: true);
      },
    );
  }

  Future<void> onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await signOut();
  }
}
