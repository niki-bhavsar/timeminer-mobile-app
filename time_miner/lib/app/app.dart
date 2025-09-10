import 'package:flutter/material.dart';
import 'package:time_miner/l10n/app_localizations.dart';
import 'package:time_miner/screens/login/login_screen.dart';
import 'package:time_miner/theme/theme.dart';

class TimeMinerRepApp extends StatelessWidget {
  const TimeMinerRepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Miner',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
