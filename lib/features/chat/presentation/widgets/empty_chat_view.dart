import 'package:flutter/material.dart';
import 'package:thinksy_ai/core/constants/app_constants.dart';

class EmptyChatView extends StatelessWidget {
  final ValueChanged<String> onSuggestionSelected;

  const EmptyChatView({super.key, required this.onSuggestionSelected});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: scheme.primaryContainer,
              child: Icon(
                Icons.auto_awesome,
                size: 36,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Hi, I am Thinksy',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask me anything and I will do my best to help.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                for (final suggestion in AppConstants.suggestions)
                  ActionChip(
                    label: Text(suggestion),
                    onPressed: () => onSuggestionSelected(suggestion),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}