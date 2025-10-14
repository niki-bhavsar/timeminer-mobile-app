import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/forgot_password/forgot_password_screen.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: TextButton(
        onPressed: () {
          // AnalyticsEvent.login.logEvent();
          context.hideKeyboard();
          context.navigate(const ForgotPasswordScreen());
          //LoginCubit.ha();R
        },
        child: Text(
          context.l10n.forgot_password,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.onPrimary,
            decorationColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
