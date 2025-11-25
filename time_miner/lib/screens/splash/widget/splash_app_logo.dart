import 'package:flutter/material.dart';
import 'package:time_miner/theme/assets.dart';

import '../../../widget/svg_icons.dart';

class SplashAppLogo extends StatelessWidget {
  const SplashAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(
        11,
        17,
        34,
        1.0,
      ), // Dark teal background to prevent white flash
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(image: AssetImage(Assets.splashBG), fit: BoxFit.cover),
          Center(child: SvgIcon(SvgIcons.splashIcon, size: 180)),
        ],
      ),
    );
  }
}
