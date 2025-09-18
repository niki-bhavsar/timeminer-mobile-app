import 'package:flutter/material.dart';

class PositionedBackButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;

  const PositionedBackButton({super.key, this.color = Colors.white, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 8,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: color,
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        tooltip: 'Back',
      ),
    );
  }
}
