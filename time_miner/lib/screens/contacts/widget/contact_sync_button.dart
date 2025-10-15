import 'package:flutter/material.dart';
import 'package:time_miner/extension/build_context_extension.dart';

class ContactSyncButton extends StatelessWidget {
  final VoidCallback? onContactSync;
  const ContactSyncButton({super.key, this.onContactSync});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Adjust radius as needed
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
          ),
          onPressed: () {
            context.hideKeyboard();
            if (onContactSync != null) onContactSync!();
          },
          child: Text(
            context.l10n.contact_sync,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
