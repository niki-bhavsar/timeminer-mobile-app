import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/screens/common/permission_decline.dart';
import 'package:time_miner/screens/contacts/contacts_cubit.dart';
import 'package:time_miner/screens/contacts/state/contact_sync_state.dart';
import 'package:time_miner/screens/contacts/widget/contact_sync_button.dart';
import 'package:time_miner/widget/progress.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactCubit(contactRepository: context.read())..fetchContacts(),
      child: const _ContactsView(),
    );
  }
}

class _ContactsView extends StatefulWidget {
  const _ContactsView();

  @override
  State<_ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<_ContactsView> {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<ContactCubit>().search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactState>(
      listener: (context, state) {
        if (state.status == ContactStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contacts synced successfully!')),
          );
        }
        if (state.status == ContactStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error occurred')),
          );
        }
      },
      builder: (context, state) {
        if (state.status == ContactStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == ContactStatus.permissionDenied) {
          return PermissionDecline(
            message:
                "Permission denied. Please enable contacts permission in settings.",
            onSetting: openAppSettings,
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Contacts'),
            actions: [
              IconButton(
                icon: Icon(_showSearch ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _showSearch = !_showSearch;
                    if (!_showSearch) {
                      _searchController.clear();
                    }
                  });
                },
              ),
            ],
          ),
          body: ProgressView(
            isLoading: state.status == ContactStatus.syncing,
            child: Column(
              children: [
                if (_showSearch)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search contacts...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 0.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Here are the contacts we found, select which are billable and then click the Sync button in the bottom.',
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: state.filteredContacts.length,
                    itemBuilder: (context, index) {
                      final selection = state.filteredContacts[index];
                      final contact = selection.contact;
                      final name = contact.displayName ?? 'No Name';
                      final emails = contact.emails ?? [];

                      return CheckboxListTile(
                        value: selection.isSelected,
                        onChanged: (val) =>
                            context.read<ContactCubit>().toggleSelection(
                              contact.identifier ?? '',
                              val ?? false,
                            ),
                        title: Text(name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (emails.isNotEmpty)
                              Text(
                                emails
                                    .map((e) => e.value)
                                    .whereType<String>()
                                    .join(', '),
                              ),
                            if (contact.phones != null &&
                                contact.phones!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(contact.phones!.first.value ?? ''),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ContactSyncButton(
                      onContactSync: context.read<ContactCubit>().syncContacts,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
