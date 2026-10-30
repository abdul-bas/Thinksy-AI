import 'package:flutter/widgets.dart';
import 'package:thinksy_ai/features/chat/presentation/pages/chat_page.dart';

class SplashController {
  
static  void openChat(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ChatPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}