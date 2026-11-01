import 'package:equatable/equatable.dart';
import 'package:thinksy_ai/features/auth/domain/entities/auth_user.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final bool isCompleated;
  final AuthUser? user;

  const AuthState({this.status = AuthStatus.unknown, this.user,this.isCompleated =false});

  @override
  List<Object?> get props => [status, user];
}
