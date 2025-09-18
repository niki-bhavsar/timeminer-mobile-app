import 'package:flutter/material.dart';

class HighlightedEmailText extends StatelessWidget {
  final String template; // localized string with {email}
  final String email;
  final TextStyle? style;
  final TextStyle? emailStyle;
  final TextAlign textAlign;

  const HighlightedEmailText({
    super.key,
    required this.template,
    required this.email,
    this.style,
    this.emailStyle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final parts = template.split("{email}");

    final defaultStyle =
        style ??
        Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary);

    final boldStyle = emailStyle ?? defaultStyle?.copyWith(fontWeight: FontWeight.bold);

    return Text.rich(
      TextSpan(
        children: [
          if (parts.isNotEmpty) TextSpan(text: parts.first, style: defaultStyle),
          TextSpan(text: email, style: boldStyle),
          if (parts.length > 1) TextSpan(text: parts.last, style: defaultStyle),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
