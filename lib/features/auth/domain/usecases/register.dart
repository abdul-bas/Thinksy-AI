

import 'package:thinksy_ai/features/auth/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  const Register(this.repository);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(name: name, email: email, password: password);
  }
}