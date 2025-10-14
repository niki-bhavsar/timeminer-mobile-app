import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/timeminer_app_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/forgot_password/forgot_password_cubit.dart';
import 'package:time_miner/screens/forgot_password/state/forgot_password_state.dart';
import 'package:time_miner/screens/forgot_password/widget/forgot_password_form_view.dart';
import 'package:time_miner/widget/progress.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(authRepository: context.read()),
      child: _ForgotPasswordScreen(),
    );
  }
}

class _ForgotPasswordScreen extends StatelessWidget {
  const _ForgotPasswordScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listenWhen: (previous, current) {
            return current is ForgotPasswordSuccessState;
          },
          listener: (context, state) {
            if (state is ForgotPasswordSuccessState) {
              //context.navigate(SetPasswordSkipScreen(email: context.read<LoginCubit>().emailTextController.text));
            }
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is ForgotPasswordLoadingState,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        maxWidth: 600,
                      ),
                      child: IntrinsicHeight(child: _ForgotPasswordLayout()),
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

class _ForgotPasswordLayout extends StatelessWidget {
  const _ForgotPasswordLayout();

  @override
  Widget build(BuildContext context) {
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surfaceTint,//.withValues(alpha: 0.5),
                      width: 3,
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withValues(alpha: 0.1),
                    //     blurRadius: 10,
                    //     offset: const Offset(0, 4),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      TimeMinerAppWhiteLogo(),
                      const SizedBox(height: 24),
                      Text(
                        context.l10n.forgot_password_screen_title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        context.l10n.forgot_password_screen_description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ForgotPasswordFormView(),
                    ],
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
