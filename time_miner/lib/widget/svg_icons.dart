import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgIcons {
  appIcon("appIcon"),
  appLogo("appLogo"),
  appLogoWhite("appLogoWhite"),
  loginBackground("loginBackground"),
  splashIcon("splashIcon");

  final String slug;

  const SvgIcons(this.slug);

  String get assetPath => "assets/images/$slug.svg";
}

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.data, {super.key, this.color, this.size});

  final Color? color;
  final double? size;
  final SvgIcons data;

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    return SvgPicture.asset(
      data.assetPath,
      colorFilter: null,//ColorFilter.mode(color ?? theme.color!, BlendMode.srcIn),
      height: size ?? theme.size,
      width: size ?? theme.size,
      fit: BoxFit.contain,
    );
  }
}
