import 'package:flutter/material.dart';

class SyncToggleView extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

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
            style:  TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
            )
        ),
        Switch(
            value: value,
            onChanged: onChanged,
          activeTrackColor: Theme.of(
            context,
          ).colorScheme.onSecondaryContainer,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.white24,
        ),
      ],
    );
  }
}
