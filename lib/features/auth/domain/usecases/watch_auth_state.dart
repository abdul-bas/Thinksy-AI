

import 'package:thinksy_ai/features/auth/domain/entities/auth_user.dart';
import 'package:thinksy_ai/features/auth/domain/repositories/auth_repository.dart';

class WatchAuthState {
  final AuthRepository repository;

  const WatchAuthState(this.repository);

  Stream<AuthUser?> call() => repository.watchAuthState();
}