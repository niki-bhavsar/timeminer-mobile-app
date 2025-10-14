import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/common_filled_button.dart';
import 'package:time_miner/screens/login/login_cubit.dart';
import 'package:time_miner/screens/login/state/login_state.dart';
import 'package:time_miner/utils/validators.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormView> {
  bool _obscurePasswordText = true;

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Form(
      key: loginCubit.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email*',
              border: OutlineInputBorder(),
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            controller: loginCubit.emailTextController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: loginCubit.autoValidateMode,
            validator: (value) => Validators.email(value),
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: IconButton(
                  icon: Icon(
                    _obscurePasswordText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePasswordText = !_obscurePasswordText;
                    });
                  },
                ),
              ),
              labelText: context.l10n.set_password_screen_passwordInput_hint,
              border: OutlineInputBorder(),
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            obscureText: _obscurePasswordText,
            controller: loginCubit.passwordTextController,
            textInputAction: TextInputAction.done,
            autovalidateMode: loginCubit.autoValidateMode,
            validator: (value) => Validators.password(value),
          ),
          const SizedBox(height: 20),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginErrorState) {
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
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CommonFilledButton(
              title: context.l10n.login,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              textColor: Theme.of(context).colorScheme.primary,
               onPressed: (){
                context.hideKeyboard();
                loginCubit.handleLoginClickEvent();
            }
            ),
            ),
        ],
      ),
    );
  }
}
