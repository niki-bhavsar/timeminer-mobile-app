import 'package:flutter/material.dart';

class SyncToggleView extends StatelessWidget {
  final String label;
  final bool value;
  final Function (bool) onChanged;

  const SyncToggleView({
    super.key,
    required this.onChanged,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF16686A),
        ),
      ],
    );
  }
}
