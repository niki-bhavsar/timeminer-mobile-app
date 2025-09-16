import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/timeminer_appLogo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/sendLink/send_link_screen.dart';
import 'package:time_miner/screens/signup/signup_cubit.dart';
import 'package:time_miner/screens/signup/state/signup_state.dart';
import 'package:time_miner/screens/signup/widget/signup_form_view.dart';
import 'package:time_miner/widget/progress.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(authRepository: context.read()),
      child: const _SignupScreen(),
    );
  }
}

class _SignupScreen extends StatelessWidget {
  const _SignupScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SignupCubit, SignupState>(
          listenWhen: (previous, current) {
            return current is SignupSuccessState;
          },
          listener: (context, state) {
            if (state is SignupSuccessState) {
              context.navigate(
                SendLinkScreen(),
              );
            }
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is SignupLoadingState,
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

                    // Title
                    Text(
                      context.l10n.welcome,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Description
                    Text(
                      context.l10n.login_description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SignupFormView(),
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
