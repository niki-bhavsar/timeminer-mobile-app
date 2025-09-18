import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/timeminer_app_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/login/login_cubit.dart';
import 'package:time_miner/screens/login/state/login_state.dart';
import 'package:time_miner/screens/login/widget/forgot_password_button.dart';
import 'package:time_miner/screens/login/widget/login_form_view.dart';
import 'package:time_miner/screens/login/widget/signup_button.dart';
import 'package:time_miner/screens/signup/signup_screen.dart';
import 'package:time_miner/widget/progress.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(authRepository: context.read()),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (previous, current) {
            return current is LoginSuccessState;
          },
          listener: (context, state) {
            if (state is LoginSuccessState) {
              //context.navigate(SetPasswordSkipScreen(email: context.read<LoginCubit>().emailTextController.text));
            }
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is LoginLoadingState,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight, maxWidth: 600),
                      child: IntrinsicHeight(child: _LoginLayout()),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginLayout extends StatelessWidget {
  const _LoginLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // A background image or content
            const FullscreenAssetImage(assetPath: 'assets/images/background.png'),

            // A semi-glassy card in the center
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    TimeMinerAppLogo(),
                    const SizedBox(height: 24),
                    Text(
                      context.l10n.welcome,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      context.l10n.login_description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    LoginFormView(),
                    const SizedBox(height: 10),
                    ForgotPasswordButton(),
                    SignUpPrompt(
                      onSignUp: () {
                        context.navigate(const SignupScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
