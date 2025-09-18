import 'package:flutter/material.dart';
import 'package:time_miner/l10n/app_localizations.dart';
import 'package:time_miner/screens/splash/splash_screen.dart';
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
      home: const SplashScreen(),
    );
  }
}
