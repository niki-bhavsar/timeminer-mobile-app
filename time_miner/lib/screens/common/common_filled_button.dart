import 'package:flutter/material.dart';

class CommonFilledButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final BorderSide? side;

  const CommonFilledButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.width,
    this.side
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width ?? double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          side:side,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: textColor ?? theme.colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}
