import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/app/app_setup.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';

import 'state/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SessionPref sessionPref;

  SplashCubit({required this.sessionPref}) : super(SplashInitialState());

  Future<void> setup() async {
    // Post launch setup
    await appSetup.postLaunchSetup();

    // Check if user is logged in or not
    bool isLoggedIn = sessionPref.isLoggedIn();
    if (isLoggedIn) {
      // TODO: Check app version
    }

    isLoggedIn = sessionPref.isLoggedIn();
    emit(SplashFetchedState(isLoggedIn: isLoggedIn));
  }
}
