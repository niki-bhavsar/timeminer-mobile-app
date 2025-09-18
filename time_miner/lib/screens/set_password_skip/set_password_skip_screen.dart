import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/common_filled_button.dart';
import 'package:time_miner/screens/common/timeminer_app_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/signup/signup_cubit.dart';
import 'package:time_miner/screens/signup/state/signup_state.dart';
import 'package:time_miner/widget/progress.dart';

class SetPasswordSkipScreen extends StatelessWidget {
  final String email;

  const SetPasswordSkipScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(authRepository: context.read()),
      child: _SetPasswordSkipScreen(email: email),
    );
  }
}

class _SetPasswordSkipScreen extends StatelessWidget {
  final String email;

  const _SetPasswordSkipScreen({required this.email});

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
              // context.navigate(const BottomMenuScreen());
            }
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is SignupLoadingState,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        maxWidth: 600,
                      ),
                      child: IntrinsicHeight(
                        child: _SetPasswordSkipLayout(email: email),
                      ),
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

class _SetPasswordSkipLayout extends StatelessWidget {
  final String email;
  const _SetPasswordSkipLayout({required this.email});
  @override
  Widget build(BuildContext context) {
    final signupCubic = context.read<SignupCubit>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // A background image or content
            const FullscreenAssetImage(
              assetPath: 'assets/images/background.png',
            ),

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
                    HeaderLogo(assetPath: "assets/images/skip_logo.png"),
                    const SizedBox(height: 24),
                    Text(
                      context.l10n.step_2,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Title
                    Text(
                      context.l10n.set_password_skip_screen_title,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      context.l10n.set_password_skip_screen_description(email),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CommonFilledButton(
                        title: context.l10n.skip,
                        onPressed: () {
                          context.hideKeyboard();
                          signupCubic.handleSignupClickEvent();
                        },
                      ),
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
