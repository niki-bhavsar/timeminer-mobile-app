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
  final String searchQuery;

  const ContactsTabList({super.key, this.searchQuery = ''});

  @override
  State<ContactsTabList> createState() => _ContactsTabListState();
}

class _ContactsTabListState extends State<ContactsTabList> {
  List<ContactItem> _filterContacts(List<ContactItem> contacts, String query) {
    if (query.isEmpty) {
      return contacts;
    }

    final lowerQuery = query.toLowerCase();
    return contacts.where((contact) {
      // Search in name
      final name = contact.name?.toLowerCase() ?? '';
      if (name.contains(lowerQuery)) {
        return true;
      }

      // Search in email
      final email = contact.email?.toLowerCase() ?? '';
      if (email.contains(lowerQuery)) {
        return true;
      }

      // Search in phone numbers
      if (contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty) {
        for (var phone in contact.phoneNumbers!) {
          final phoneNumber = phone.phoneNumber?.toLowerCase() ?? '';
          if (phoneNumber.contains(lowerQuery)) {
            return true;
          }
        }
      }

      return false;
    }).toList();
  }

  Widget _buildContactTile(ContactItem contact, VoidCallback onChanged) {
    final name = contact.name ?? 'No Name';
    return CheckboxListTile(
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // square corner like screenshot
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.onSurface, // border when unchecked
        width: 2,
      ),
      activeColor: Theme.of(context).colorScheme.onSecondaryContainer,     // checkbox border + background when checked
      checkColor: Colors.white,
      value: contact.mineStatus,
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: (val) {
        contact.mineStatus = val ?? false;
        onChanged();
      },
      title: Text(
          name,
        style:  TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),

      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (contact.email != null && contact.email!.isNotEmpty)
            Text(
                contact.email!,
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface
              ),
            ),
          if (contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty)
            Text(
                contact.phoneNumbers!.first.phoneNumber ?? '',
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Container(
      color: Theme.of(context).colorScheme.onSurface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,  color: Theme.of(context).colorScheme.primary),
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
        title: Text(
          context.l10n.failed_contacts_title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
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
                      color: Theme.of(context).colorScheme.onSurface,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              failed.name,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
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
            child: Text(
                context.l10n.action_ok,
              style: TextStyle(color: Colors.white),
            ),
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
          context.showSnackBar(state.error, context);
        } else if (state is ContactsTabSyncSuccessState) {
          if (state.failedContacts != null &&
              state.failedContacts!.isNotEmpty) {
            // Show dialog with failed contacts
            _showFailedContactsDialog(context, state.failedContacts!);
          } else {
            context.showSnackBar(state.message, context);
          }
        }
      },
      builder: (context, state) {
        final bloc = context.read<ContactsTabCubit>();

        // Filter contacts based on search query
        final filteredUnsynced = _filterContacts(
          bloc.unsyncedContacts,
          widget.searchQuery,
        );
        final filteredSynced = _filterContacts(
          bloc.syncedContacts,
          widget.searchQuery,
        );

        final hasSynced = filteredSynced.isNotEmpty;
        final hasUnsynced = filteredUnsynced.isNotEmpty;

        if (bloc.syncedContacts.isNotEmpty ||
            bloc.unsyncedContacts.isNotEmpty) {
          return ProgressView(
            isLoading: state is ContactsTabLoadingState,
            child: (hasSynced || hasUnsynced)
                ? ListView.builder(
                    itemCount:
                        (hasUnsynced ? 1 : 0) +
                        filteredUnsynced.length +
                        (hasSynced ? 1 : 0) +
                        filteredSynced.length,
                    itemBuilder: (context, index) {
                      // Unsynced contacts section (shown first)
                      if (hasUnsynced && index == 0) {
                        return _buildSectionHeader(
                          'Unsynced Contacts',
                          filteredUnsynced.length,
                        );
                      }

                      // Unsynced contacts list
                      if (hasUnsynced &&
                          index > 0 &&
                          index <= filteredUnsynced.length) {
                        final contactIndex = index - 1;
                        return _buildContactTile(
                          filteredUnsynced[contactIndex],
                          () => setState(() {}),
                        );
                      }

                      // Synced contacts section (shown after unsynced)
                      final unsyncedSectionSize = hasUnsynced
                          ? filteredUnsynced.length + 1
                          : 0;
                      if (hasSynced && index == unsyncedSectionSize) {
                        return _buildSectionHeader(
                          'Synced Contacts',
                          filteredSynced.length,
                        );
                      }

                      // Synced contacts list
                      if (hasSynced && index > unsyncedSectionSize) {
                        final contactIndex = index - unsyncedSectionSize - 1;
                        return _buildContactTile(
                          filteredSynced[contactIndex],
                          () => setState(() {}),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No contacts found matching "${widget.searchQuery}"',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          );
        } else {
          return ContactsTabStateView(state: state);
        }
      },
    );
  }
}
