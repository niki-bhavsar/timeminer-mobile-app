import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';

/// A small reusable widget that shows:
/// Don't have an account?  Sign Up
/// with "Sign Up" as a bold, underlined button.
class SignUpPrompt extends StatelessWidget {
  final VoidCallback? onSignUp;

  const SignUpPrompt({super.key, this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.signUpText,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        TextButton(
          onPressed: onSignUp,
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(4),
            minimumSize: const Size(30, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          child: Text(
            context.l10n.signUp,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.onPrimary,
              decorationColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

// Example usage:
// Center(child: SignUpPrompt(onSignUp: () { /* navigate to signup */ }));
