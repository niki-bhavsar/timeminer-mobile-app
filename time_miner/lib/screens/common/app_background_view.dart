import 'package:flutter/material.dart';

class FullscreenAssetImage extends StatelessWidget {
  final String assetPath;

  const FullscreenAssetImage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: Image.asset(assetPath, fit: BoxFit.cover));
  }
}
