

import 'package:thinksy_ai/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  const SignIn(this.repository);

  Future<void> call({required String email, required String password}) {
    return repository.signIn(email: email, password: password);
  }
}