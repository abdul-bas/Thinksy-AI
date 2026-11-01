

import 'package:thinksy_ai/features/auth/domain/repositories/auth_repository.dart';

class SendPasswordReset {
  final AuthRepository repository;

  const SendPasswordReset(this.repository);

  Future<void> call(String email) => repository.sendPasswordReset(email);
}