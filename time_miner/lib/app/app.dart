import 'package:flutter/material.dart';
import 'package:time_miner/l10n/app_localizations.dart';
import 'package:time_miner/screens/link_resend/link_resend_screen.dart';
import 'package:time_miner/screens/set_password_skip/set_password_skip_screen.dart';
import 'package:time_miner/screens/signup/signup_screen.dart';
import 'package:time_miner/screens/set_password/set_password_screen.dart';
import 'package:time_miner/screens/sendLink/send_link_screen.dart';
import 'package:time_miner/theme/theme.dart';

class TimeMinerApp extends StatelessWidget {
  const TimeMinerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Miner',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SignupScreen(),
    );
  }
}
