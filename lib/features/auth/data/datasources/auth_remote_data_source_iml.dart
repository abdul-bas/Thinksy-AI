
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thinksy_ai/core/error/auth_error_handler.dart';
import 'package:thinksy_ai/core/error/failure.dart';
import 'package:thinksy_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:thinksy_ai/features/auth/domain/entities/auth_user.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  const AuthRemoteDataSourceImpl(this.firebaseAuth);

  AuthUser? mapUser(User? user) {
    if (user == null) return null;
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  @override
  Stream<AuthUser?> watchAuthState() {
    return firebaseAuth.userChanges().map(mapUser);
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw Failure(describeError(error));
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (error) {
      throw Failure(describeError(error));
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      throw Failure(describeError(error));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      throw Failure(describeError(error));
    }
  }

}