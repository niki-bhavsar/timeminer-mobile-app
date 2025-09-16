import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/signup/signup_cubit.dart';
import 'package:time_miner/screens/signup/state/signup_state.dart';

class SignupFormView extends StatefulWidget {
  const SignupFormView({super.key});

  @override
  State<SignupFormView> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupFormView> {
  @override
  Widget build(BuildContext context) {
    final signupCubic = context.read<SignupCubit>();
    return Form(
      key: signupCubic.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10), // height control
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: signupCubic.emailTextController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: signupCubic.autoValidateMode,
            validator: _emailValidator,
            autofillHints: const [AutofillHints.email],
          ),
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              if (state is SignupErrorState) {
                return Column(
                  children: [
                    const SizedBox(height: 14),
                    Text(
                      state.error,
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.error),
                      textAlign: TextAlign.left,
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                // AnalyticsEvent.login.logEvent();
                context.hideKeyboard();
                signupCubic.handleSignupClickEvent();
              },
              child: Text(context.l10n.get_started),
            ),
          ),
        ],
      ),
    );
  }

  String? _emailValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return context.l10n.loginScreen_emailInput_emptyError;
    }
    return null;
  }
}
