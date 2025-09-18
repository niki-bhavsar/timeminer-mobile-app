import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/common_filled_button.dart';
import 'package:time_miner/screens/common/highlighted_email_text.dart';
import 'package:time_miner/screens/common/positioned_back_button.dart';
import 'package:time_miner/screens/signup/signup_cubit.dart';
import 'package:time_miner/screens/common/timeminer_app_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/set_password/set_password_screen.dart';
import 'package:time_miner/screens/signup/state/signup_state.dart';
import 'package:time_miner/widget/progress.dart';

class LinkResendScreen extends StatelessWidget {
  const LinkResendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(authRepository: context.read()),
      child: _LinkResendScreen(),
    );
  }
}

class _LinkResendScreen extends StatelessWidget {
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
                      child: IntrinsicHeight(child: _LinkResendLayout()),
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

class _LinkResendLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signupCubic = context.read<SignupCubit>();
    String signUpEmail = GetIt.instance.get<SessionPref>().getSignUpEmail();
    print("********** signUpEmail ********** $signUpEmail");
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // A background image or content
            const FullscreenAssetImage(
              assetPath: 'assets/images/background.png',
            ),
            PositionedBackButton(),
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
                    HeaderLogo(assetPath: "assets/images/resend_link.png"),
                    const SizedBox(height: 24),
                    Text(
                      context.l10n.step_1,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Title
                    Text(
                      context.l10n.look_inbox,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    const SizedBox(height: 5),

                    // Description
                    HighlightedEmailText(
                      template: context.l10n.look_inbox_description("{email}"),
                      email: signUpEmail,
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CommonFilledButton(
                        title: context.l10n.resend_link,
                        onPressed: () {
                          context.hideKeyboard();
                          signupCubic.handleSignupClickEvent();
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: CommonFilledButton(
                        title: context.l10n.create_password,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onTertiary,
                        side: BorderSide(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary, // ✅ Border color
                          width: 1, // border thickness
                        ),
                        onPressed: () {
                          context.navigate(SetPasswordScreen());
                        },
                        textColor: Theme.of(context).colorScheme.primary,
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
