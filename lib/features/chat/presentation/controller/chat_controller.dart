

import 'package:flutter/material.dart';

class ChatController {
  static void submit(
    TextEditingController controller,
    bool isLoading,
    void Function(String) onSubmitted,
  ) {
    final text = controller.text.trim();

    if (text.isEmpty || isLoading) return;

    onSubmitted(text);
    controller.clear();
  }
  
 static double dotOpacity(int index, AnimationController controller) {
    final shifted = (controller.value - index * 0.2) % 1.0;
    final wave = shifted < 0.5 ? shifted * 2 : (1 - shifted) * 2;
    return 0.3 + 0.7 * wave;
  }

}
