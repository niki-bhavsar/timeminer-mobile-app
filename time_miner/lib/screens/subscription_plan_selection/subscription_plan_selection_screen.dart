import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/app_background_view.dart';
import 'package:time_miner/screens/common/common_filled_button.dart';
import 'package:time_miner/screens/common/timeminer_app_logo.dart';
import 'package:time_miner/screens/subscription_plan_selection/subcription_plan_cubit.dart';
import 'package:time_miner/screens/subscription_plan_selection/widget/subscription_plan_view.dart';

class SubscriptionPlanSelectionScreen extends StatelessWidget {
  const SubscriptionPlanSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubscriptionPlanCubit(),
      child: const _SubscriptionPlanSelectionView(),
    );
  }
}

class _SubscriptionPlanSelectionView extends StatelessWidget {
  const _SubscriptionPlanSelectionView();
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
                      context.l10n.step_3,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      context.l10n.plan_selection_screen_title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<SubscriptionPlanCubit, int>(
                      builder: (context, selectedIndex) {
                        final cubit = context.read<SubscriptionPlanCubit>();
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ...logo, title, etc...
                            ...List.generate(
                              cubit.plans.length,
                              (i) => SubscriptionPlanView(
                                plan: cubit.plans[i],
                                isSelected: selectedIndex == i,
                                onTap: () => cubit.selectPlan(i),
                              ),
                            ),
                            // ...Next button...
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: CommonFilledButton(
                        title: context.l10n.next,
                        onPressed: () {
                          context.hideKeyboard();
                          // loginCubit.handleLoginClickEvent();
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
