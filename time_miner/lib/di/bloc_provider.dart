import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SessionPref>(create: (context) => GetIt.instance.get<SessionPref>()),
        // RepositoryProvider<AuthRepository>(
        //   create: (context) => AuthRepositoryImpl(
        //     authService: AuthService(),
        //     sessionPref: context.read<SessionPref>(),
        //   ),
        // ),
      ],
      child: child,
    );
  }
}
