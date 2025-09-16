import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/timeminer_appLogo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/set_password/set_password_cubit.dart';
import 'package:time_miner/screens/set_password/state/set_password_state.dart';
import 'package:time_miner/screens/set_password/widget/set_password_form_view.dart';
import 'package:time_miner/screens/set_password_skip/set_password_skip_screen.dart';
import 'package:time_miner/widget/progress.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SetPasswordCubit(authRepository: context.read()),
      child: const _SetPasswordScreen(),
    );
  }
}

class _SetPasswordScreen extends StatelessWidget {
  const _SetPasswordScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SetPasswordCubit, SetPasswordState>(
          listenWhen: (previous, current) {
            return current is SetPasswordSuccessState;
          },
          listener: (context, state) {
            if (state is SetPasswordSuccessState) {
              context.navigate(SetPasswordSkipScreen(email: context.read<SetPasswordCubit>().emailTextController.text));
            }
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is SetPasswordLoadingState,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        maxWidth: 600,
                      ),
                      child: IntrinsicHeight(child: _SetPasswordLayout()),
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

class _SetPasswordLayout extends StatelessWidget {
  const _SetPasswordLayout();

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
                      context.l10n.step_2,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Title
                    Text(
                      context.l10n.set_password_title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      context.l10n.set_password_description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SetPasswordFormView(),
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
