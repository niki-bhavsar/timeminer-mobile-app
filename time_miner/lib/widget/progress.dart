import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const ProgressView({required this.child, this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        AbsorbPointer(absorbing: isLoading, child: child),
        if (isLoading) _loading(),
      ],
    );
  }

  Widget _loading() {
    return const Center(
      child: ClipRect(
        child: SizedBox(width: 90, height: 90, child: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
