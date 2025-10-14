import 'package:flutter/material.dart';

class TimeMinerAppLogo extends StatelessWidget {
  const TimeMinerAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/appLogo.png", // replace with your logo asset
      height: 60,
    );
  }
}

class TimeMinerAppWhiteLogo extends StatelessWidget {
  const TimeMinerAppWhiteLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/app_logo_white.png", // replace with your logo asset
      height: 40,
    );
  }
}

class HeaderLogo extends StatelessWidget {
  final String assetPath;

  const HeaderLogo({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath, fit: BoxFit.contain, height: 120);
  }
}
