import 'package:flutter/material.dart';

import 'package:thinksy_ai/features/auth/presentation/bloc/auth/auth_state.dart';

import 'package:thinksy_ai/features/auth/presentation/pages/login_page.dart';
import 'package:thinksy_ai/features/chat/presentation/pages/chat_page.dart';
class SplashController {
  void authValidate(BuildContext context, AuthState state) {
    switch (state.status) {
      case AuthStatus.unknown:
        break;

      case AuthStatus.authenticated:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatPage(),
          ),
        );
        break;

      case AuthStatus.unauthenticated:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
        break;

      default:
        break;
    }
  }
}