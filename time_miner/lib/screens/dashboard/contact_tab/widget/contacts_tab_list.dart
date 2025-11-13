import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/sync_contacts_entity.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import '../../../../data/entity/contacts_entity.dart';
import '../../../../widget/progress.dart';
import '../../../login/login_screen.dart';
import '../bloc/contacts_tab_state.dart';
import '../contacts_tab_cubit.dart';
import 'contacts_tab_state_view.dart';

class ContactsTabList extends StatefulWidget {
  const ContactsTabList({super.key});

  @override
  State<ContactsTabList> createState() => _ContactsTabListState();
}

class _ContactsTabListState extends State<ContactsTabList> {
  Widget _buildContactTile(ContactItem contact, VoidCallback onChanged) {
    final name = contact.name ?? 'No Name';
    return CheckboxListTile(
      value: contact.mineStatus,
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: (val) {
        contact.mineStatus = val ?? false;
        onChanged();
      },
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (contact.email != null && contact.email!.isNotEmpty)
            Text(contact.email!),
          if (contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty)
            Text(contact.phoneNumbers!.first.phoneNumber ?? ''),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showFailedContactsDialog(
    BuildContext context,
    List<FailedContact> failedContacts,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.failed_contacts_title),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
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
            },
            child: Text(context.l10n.action_ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsTabCubit, ContactsTabState>(
      listener: (context, state) {
        if (state is ContactsTabErrorState && state.isAuthError) {
          context.navigateAndReplace(const LoginScreen());
        } else if (state is ContactsTabErrorState) {
          context.showSnackBar(state.error);
        } else if (state is ContactsTabSyncSuccessState) {
          if (state.failedContacts != null &&
              state.failedContacts!.isNotEmpty) {
            // Show dialog with failed contacts
            _showFailedContactsDialog(context, state.failedContacts!);
          } else {
            context.showSnackBar(state.message);
          }
        }
      },
      builder: (context, state) {
        final bloc = context.read<ContactsTabCubit>();
        final hasSynced = bloc.syncedContacts.isNotEmpty;
        final hasUnsynced = bloc.unsyncedContacts.isNotEmpty;

        if (hasSynced || hasUnsynced) {
          return ProgressView(
            isLoading: state is ContactsTabLoadingState,
            child: ListView.builder(
              itemCount:
                  (hasUnsynced ? 1 : 0) +
                  bloc.unsyncedContacts.length +
                  (hasSynced ? 1 : 0) +
                  bloc.syncedContacts.length,
              itemBuilder: (context, index) {
                // Unsynced contacts section (shown first)
                if (hasUnsynced && index == 0) {
                  return _buildSectionHeader(
                    'Unsynced Contacts',
                    bloc.unsyncedContacts.length,
                  );
                }

                // Unsynced contacts list
                if (hasUnsynced &&
                    index > 0 &&
                    index <= bloc.unsyncedContacts.length) {
                  final contactIndex = index - 1;
                  return _buildContactTile(
                    bloc.unsyncedContacts[contactIndex],
                    () => setState(() {}),
                  );
                }

                // Synced contacts section (shown after unsynced)
                final unsyncedSectionSize = hasUnsynced
                    ? bloc.unsyncedContacts.length + 1
                    : 0;
                if (hasSynced && index == unsyncedSectionSize) {
                  return _buildSectionHeader(
                    'Synced Contacts',
                    bloc.syncedContacts.length,
                  );
                }

                // Synced contacts list
                if (hasSynced && index > unsyncedSectionSize) {
                  final contactIndex = index - unsyncedSectionSize - 1;
                  return _buildContactTile(
                    bloc.syncedContacts[contactIndex],
                    () => setState(() {}),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          );
        } else {
          return ContactsTabStateView(state: state);
        }
      },
    );
  }
}
