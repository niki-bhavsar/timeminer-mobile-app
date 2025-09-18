import 'package:flutter/material.dart';

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
        const Text("Don't have an account? "),
        TextButton(
          onPressed: onSignUp,
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(2),
            minimumSize: const Size(30, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

// Example usage:
// Center(child: SignUpPrompt(onSignUp: () { /* navigate to signup */ }));
