import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? semanticLabel;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    Color? newColor = color;
    newColor ??= Theme.of(context).colorScheme.primary;
    return IconButton(
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: newColor.withAlpha(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        child: Icon(icon, size: 20, color: newColor, semanticLabel: semanticLabel),
      ),
      onPressed: onPressed,
    );
  }
}
