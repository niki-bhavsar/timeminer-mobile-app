import 'package:flutter/material.dart';
import 'package:time_miner/data/entity/sync_contacts_entity.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/dashboard/home_screen.dart';

void showFailedContactsDialog(
  BuildContext context,
  List<FailedContact> failedContacts,
) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title:  Text(context.l10n.failed_contacts_title),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.failed_contacts_message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: failedContacts.length,
                itemBuilder: (context, index) {
                  final failed = failedContacts[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            failed.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (failed.email != null &&
                              failed.email!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Email: ${failed.email}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          if (failed.phoneNumbers.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Phone: ${failed.phoneNumbers.join(", ")}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.error.withAlpha(30),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    failed.error,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.error,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            context.navigate(const HomeScreen());
          },
          child:  Text(context.l10n.action_ok),
        ),
      ],
    ),
  );
}
