import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/dashboard/home_screen.dart';
import 'package:time_miner/screens/login/login_screen.dart';
import 'package:time_miner/screens/splash/splash_cubit.dart';
import 'package:time_miner/screens/splash/state/splash_state.dart';
import 'package:time_miner/screens/splash/widget/splash_app_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(
        76,
        92,
        105,
        1.0,
      ), // Dark teal background to prevent white flash
      body: BlocProvider(
        create: (_) => SplashCubit(sessionPref: context.read<SessionPref>())..setup(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashFetchedState) {
              if (state.isLoggedIn) {
                context.navigateAndReplace(const HomeScreen());
                // TODO: Before GO LIVE, Modify this to redirect on Login screen even if already loggd in
              } else {
                context.navigateAndReplace(const LoginScreen());
              }
            }
          },
          child: const SplashAppLogo(),
        ),
      ),
    );
  }
}
