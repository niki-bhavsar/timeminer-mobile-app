import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/common_methods.dart';
import 'package:time_miner/screens/common/timeminer_app_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/contacts/contacts_screen.dart';
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
              context.navigate(const ContactsScreen());
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
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        maxWidth: 600,
                      ),
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
      body: Stack(
          children: [
            // A background image or content
            const FullscreenAssetImage(
              assetPath: 'assets/images/background.png',
            ),

            // A semi-glassy card in the center
            Center(
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 34),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(80, 217, 217, 217),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceTint, //.withValues(alpha: 0.5),
                          width: 3,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo
                          TimeMinerAppWhiteLogo(),
                          const SizedBox(height: 24),
                          Text(
                            context.l10n.welcome,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                
                          // Description
                          Text(
                            context.l10n.login_description,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          LoginFormView(),
                          const SizedBox(height: 10),
                          ForgotPasswordButton(),
                          SignUpPrompt(
                            onSignUp: () {
                              // redirect on timeminer signup page
                              CommonMethods.launchURL(
                                  'https://www.timeminer.com');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
