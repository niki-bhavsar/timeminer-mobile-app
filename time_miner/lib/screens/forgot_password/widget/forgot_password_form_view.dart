import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/common_filled_button.dart';
import 'package:time_miner/screens/forgot_password/forgot_password_cubit.dart';
import 'package:time_miner/screens/forgot_password/state/forgot_password_state.dart';
import 'package:time_miner/utils/validators.dart';

class ForgotPasswordFormView extends StatefulWidget {
  const ForgotPasswordFormView({super.key});

  @override
  State<ForgotPasswordFormView> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordFormView> {
  @override
  Widget build(BuildContext context) {
    final forgotPasswordCubit = context.read<ForgotPasswordCubit>();
    return Form(
      key: forgotPasswordCubit.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration:  InputDecoration(
              labelText: 'Email*',
              border: OutlineInputBorder(),
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              filled: true,
            ),
            decoration: const InputDecoration(labelText: 'Email*', border: OutlineInputBorder()),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: forgotPasswordCubit.emailTextController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: forgotPasswordCubit.autoValidateMode,
            validator: (value) => Validators.email(value),
            autofillHints: const [AutofillHints.email],
            // enabled: false,
          ),
          const SizedBox(height: 24),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              if (state is ForgotPasswordErrorState) {
                return Column(
                  children: [
                    const SizedBox(height: 16),
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
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CommonFilledButton(
              title: context.l10n.forgot_password_screen_forgot_button_title,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              textColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                context.hideKeyboard();
                forgotPasswordCubit.handleForgotPasswordClickEvent(null);
              },
            ),
          ),

          // ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CommonFilledButton(
              title: context.l10n.back_button_title,
              backgroundColor: Colors.transparent,
              textColor: Colors.white,
              side: BorderSide(
                color: Color(0xFF324053),
                width: 1, // border thickness
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
