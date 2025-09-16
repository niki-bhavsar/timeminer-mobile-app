import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/highlighted_email_text.dart';
import 'package:time_miner/screens/link_resend/link_resend_screen.dart';
import 'package:time_miner/screens/common/timeminer_appLogo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/signup/signup_cubit.dart';
import 'package:time_miner/screens/signup/state/signup_state.dart';
import 'package:time_miner/widget/progress.dart';

class SendLinkScreen extends StatelessWidget {

  const SendLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(authRepository: context.read()),
      child: _SendLinkScreen(),
    );
  }
}

class _SendLinkScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SignupCubit, SignupState>(
          listenWhen: (previous, current) {
            return current is SignupInvitationLinkSuccessState;
          },
          listener: (context, state) {
            if (state is SignupInvitationLinkSuccessState) {
              context.navigate(LinkResendScreen());
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
                      constraints: BoxConstraints(minHeight: constraints.maxHeight, maxWidth: 600),
                      child: IntrinsicHeight(child: _SendLinkLayout()),
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

class _SendLinkLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signupCubic = context.read<SignupCubit>();
    String signUpEmail = GetIt.instance.get<SessionPref>().getSignUpEmail();
    print("********** signUpEmail2 ********** $signUpEmail");
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
                    HeaderLogo(assetPath: "assets/images/sendLink.png"),
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
                      context.l10n.complete_your_account,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),

                    HighlightedEmailText(template: context.l10n.send_mail_description("{email}"), email: signUpEmail),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          // AnalyticsEvent.login.logEvent();
                          context.hideKeyboard();
                          signupCubic.handleSendInvitationClickEvent();
                        },
                        child: Text(context.l10n.send_link),
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
