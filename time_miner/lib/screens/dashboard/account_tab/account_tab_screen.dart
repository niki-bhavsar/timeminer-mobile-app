import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/data/repository/auth_repository.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/dashboard/account_tab/account_block.dart';
import 'package:time_miner/screens/dashboard/account_tab/state/account_state.dart';
import 'package:time_miner/screens/dashboard/account_tab/widget/account_tab_view.dart';
import 'package:time_miner/screens/login/login_screen.dart';
import 'package:time_miner/widget/progress.dart';

class AccountTabScreen extends StatelessWidget {
  const AccountTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _requestCallLogPermission();
    return Scaffold(

      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Account',
          // style: TextStyle(
          //   color: Color(0xFF16686A),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 22,
          // ),
        ),
        // backgroundColor: Colors.white,
        // elevation: 1,
        // automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (_) =>
            AccountBlock(authRepository: context.read<AuthRepository>()),
        child: BlocConsumer<AccountBlock, AccountState>(
          listenWhen: (previous, current) {
            return current is SettingLogoutState;
          },
          listener: (context, state) {
            final sessionPref = GetIt.instance.get<SessionPref>();
            sessionPref.setLoggedIn(false);
            sessionPref.clear();
            context.navigateAndReplace(const LoginScreen());
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is SettingLoadingState,
              child: AccountTabView(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _requestCallLogPermission() async {
    try {
      final _ = await Permission.phone.request();
    } catch (e) {
      // Handle error
    }
  }
}
