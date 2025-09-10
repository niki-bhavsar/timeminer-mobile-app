import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension PlatformExtension on BuildContext {
  bool get isMobile =>
      Theme.of(this).platform == TargetPlatform.iOS ||
      Theme.of(this).platform == TargetPlatform.android ||
      Theme.of(this).platform == TargetPlatform.fuchsia;

  bool get isDesktop =>
      Theme.of(this).platform == TargetPlatform.macOS ||
      Theme.of(this).platform == TargetPlatform.windows ||
      Theme.of(this).platform == TargetPlatform.linux;

  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;

  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;

  bool get isFuchsia => Theme.of(this).platform == TargetPlatform.fuchsia;

  bool get isLinux => Theme.of(this).platform == TargetPlatform.linux;

  bool get isWindows => Theme.of(this).platform == TargetPlatform.windows;

  bool get isMacOS => Theme.of(this).platform == TargetPlatform.macOS;

  bool get isWeb => kIsWeb;
}
