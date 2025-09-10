import 'package:flutter/material.dart';

class AppDialog {
  final String? title;
  final String message;
  final String positiveText;
  final String? negativeText;
  final VoidCallback? onPositiveClick;
  final VoidCallback? onNegativeClick;
  final bool cancellable;

  AppDialog({
    required this.message,
    required this.positiveText,
    this.title,
    this.negativeText,
    this.onPositiveClick,
    this.onNegativeClick,
    this.cancellable = true,
  });

  Future show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: cancellable,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return PopScope(
              canPop: cancellable,
              child: AlertDialog(
                title: title == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(title ?? "", style: Theme.of(context).textTheme.titleMedium),
                      ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(message, style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
                actions: <Widget>[
                  if (negativeText != null)
                    TextButton(
                      child: Text(
                        negativeText ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onNegativeClick?.call();
                      },
                    ),
                  TextButton(
                    child: Text(
                      positiveText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onPositiveClick?.call();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
