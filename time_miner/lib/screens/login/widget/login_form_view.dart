import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserCredentials();
    });
  }

  Future<void> _loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');
    final savedRemember = prefs.getBool('remember_me') ?? false;

    if (savedRemember && mounted) {
      final loginCubit = context.read<LoginCubit>();
      setState(() {
        loginCubit.emailTextController.text = savedEmail ?? '';
        loginCubit.passwordTextController.text = savedPassword ?? '';
        rememberMe = true;
      });
    }
  }

  Future<void> _handleRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final loginCubit = context.read<LoginCubit>();

    if (value) {
      await prefs.setString('email', loginCubit.emailTextController.text);
      await prefs.setString('password', loginCubit.passwordTextController.text);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('remember_me', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState && rememberMe) {
          await _handleRememberMe(true);
        }
      },
      child: Form(
        key: loginCubit.formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email*', border: OutlineInputBorder()),
              style: Theme.of(context).textTheme.bodyLarge,
              controller: loginCubit.emailTextController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: loginCubit.autoValidateMode,
              validator: (value) => Validators.email(value),
              autofillHints: const [AutofillHints.email],
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
              style: Theme.of(context).textTheme.bodyLarge,
              obscureText: _obscurePasswordText,
              controller: loginCubit.passwordTextController,
              textInputAction: TextInputAction.done,
              autovalidateMode: loginCubit.autoValidateMode,
              validator: (value) => Validators.password(value),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: Colors.black,
                  value: rememberMe,
                  onChanged: (value) async {
                    setState(() => rememberMe = value ?? false);
                    await _handleRememberMe(value ?? false);
                  },
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  side: const BorderSide(color: Colors.white, width: 1.5),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  context.l10n.rememberMe,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 8),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginErrorState) {
                  return Column(
                    children: [
                      // const SizedBox(height: 14),
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
            SizedBox(
              width: double.infinity,
              child: CommonFilledButton(
                title: context.l10n.login,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                textColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  context.hideKeyboard();
                  loginCubit.handleLoginClickEvent();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
