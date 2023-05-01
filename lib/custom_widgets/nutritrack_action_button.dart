import 'package:flutter/material.dart';

@immutable
class NutriTrackActionButton extends StatelessWidget {
  const NutriTrackActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.tooltip,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        tooltip: tooltip,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
