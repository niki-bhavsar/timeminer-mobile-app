import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/common_filled_button.dart';
import 'package:time_miner/screens/set_password/set_password_cubit.dart';
import 'package:time_miner/screens/set_password/state/set_password_state.dart';
import 'package:time_miner/utils/validators.dart';

class SetPasswordFormView extends StatefulWidget {
  const SetPasswordFormView({super.key});

  @override
  State<SetPasswordFormView> createState() => _SetPasswordFormState();
}

class _SetPasswordFormState extends State<SetPasswordFormView> {
  bool _obscurePasswordText = true;
  bool _obscureConfirmPasswordText = true;

  @override
  Widget build(BuildContext context) {
    final setPasswordCubit = context.read<SetPasswordCubit>();
    return Form(
      key: setPasswordCubit.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: setPasswordCubit.emailTextController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: setPasswordCubit.autoValidateMode,
            validator: (value) => Validators.email(value),
            autofillHints: const [AutofillHints.email],
            enabled: false,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Firm Name',
              border: OutlineInputBorder(),
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: setPasswordCubit.firmNameTextController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            autovalidateMode: setPasswordCubit.autoValidateMode,
            validator: (value) => Validators.firmNameValidator(value),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(
                    _obscurePasswordText
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
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
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: _obscurePasswordText,
            controller: setPasswordCubit.passwordTextController,
            textInputAction: TextInputAction.next,
            autovalidateMode: setPasswordCubit.autoValidateMode,
            validator: (value) => Validators.password(value),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(
                    _obscureConfirmPasswordText
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPasswordText =
                          !_obscureConfirmPasswordText;
                    });
                  },
                ),
              ),
              labelText:
                  context.l10n.set_password_screen_confirm_passwordInput_hint,
                  border: OutlineInputBorder(),
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: _obscureConfirmPasswordText,
            controller: setPasswordCubit.confirmPasswordTextController,
            textInputAction: TextInputAction.done,
            autovalidateMode: setPasswordCubit.autoValidateMode,
            validator: (value) => Validators.confirmPasswordValidator(
              value,
              setPasswordCubit.passwordTextController.text,
            ),
          ),
          BlocBuilder<SetPasswordCubit, SetPasswordState>(
            builder: (context, state) {
              if (state is SetPasswordErrorState) {
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
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: CommonFilledButton(
              title: context.l10n.next,
              onPressed: () {
                context.hideKeyboard();
                setPasswordCubit.handleSetPasswordClickEvent();
              },
            ),
          ),
        ],
      ),
    );
  }
}
