import 'package:flutter/material.dart';
import 'package:thinksy_ai/features/chat/presentation/controller/chat_controller.dart';

class ChatInput extends StatefulWidget {
  final bool isLoading;
  final ValueChanged<String> onSubmitted;

  const ChatInput({
    super.key,
    required this.isLoading,
    required this.onSubmitted,
  });

  @override
  State<ChatInput> createState() => ChatInputState();
}

class ChatInputState extends State<ChatInput> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.send,
                onSubmitted: (value) =>ChatController.submit(controller,widget.isLoading,widget.onSubmitted),
                decoration: InputDecoration(
                  hintText: 'Ask Thinksy anything...',
                  filled: true,
                  fillColor: scheme.surfaceContainerHigh,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: widget.isLoading ? null :()=> ChatController.submit(controller,widget.isLoading,widget.onSubmitted),
              icon: widget.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.arrow_upward_rounded),
              style: IconButton.styleFrom(minimumSize: const Size(52, 52)),
            ),
          ],
        ),
      ),
    );
  }
}