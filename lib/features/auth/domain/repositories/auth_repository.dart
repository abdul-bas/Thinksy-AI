

import 'package:thinksy_ai/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
 
  Stream<AuthUser?> watchAuthState();

 
  Future<void> signIn({required String email, required String password});

  Future<void> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> sendPasswordReset(String email);

  Future<void> signOut();
}