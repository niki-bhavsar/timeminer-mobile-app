import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StateView extends StatelessWidget {
  final String? title;
  final String? message;
  final String? icon;
  final String? action;
  final VoidCallback? onAction;

  const StateView({this.title, this.message, this.icon, this.action, this.onAction, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (icon != null) SvgPicture.asset(icon!, width: 124, height: 124),
          const SizedBox(height: 16),
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          if (title != null) const SizedBox(height: 8),
          if (message != null)
            Text(
              message ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),
            ),
          if (message != null) const SizedBox(height: 16),
          if (action != null)
            ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
                backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                onAction?.call();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  action ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
