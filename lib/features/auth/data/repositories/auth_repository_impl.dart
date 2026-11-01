import 'package:thinksy_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:thinksy_ai/features/auth/domain/entities/auth_user.dart';
import 'package:thinksy_ai/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<AuthUser?> watchAuthState() => remoteDataSource.watchAuthState();

  @override
  Future<void> signIn({required String email, required String password}) {
    return remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) {
    return remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> sendPasswordReset(String email) {
    return remoteDataSource.sendPasswordReset(email);
  }

  @override
  Future<void> signOut() => remoteDataSource.signOut();
}