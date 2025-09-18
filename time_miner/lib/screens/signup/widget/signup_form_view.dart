import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/common_filled_button.dart';
import 'package:time_miner/screens/signup/signup_cubit.dart';
import 'package:time_miner/screens/signup/state/signup_state.dart';
import 'package:time_miner/utils/validators.dart';

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
            // height control
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: signupCubic.emailTextController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: signupCubic.autoValidateMode,
            validator: (value) => Validators.email(value),
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
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
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
            child: CommonFilledButton(
              title: context.l10n.get_started,
              onPressed: () {
                context.hideKeyboard();
                signupCubic.handleSignupClickEvent();
              },
            ),
          ),
        ],
      ),
    );
  }
}
