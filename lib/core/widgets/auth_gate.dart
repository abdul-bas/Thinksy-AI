import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:thinksy_ai/features/auth/presentation/pages/login_page.dart';
import 'package:thinksy_ai/features/chat/presentation/pages/chat_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.unknown:
            break;

          case AuthStatus.authenticated:
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const ChatPage()),
              (route) => false,
            );
            break;

          case AuthStatus.unauthenticated:
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
            break;
        }
      },
      child: child
    );
  }
}
