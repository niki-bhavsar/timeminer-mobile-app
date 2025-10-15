import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/common/permission_decline.dart';
import 'package:time_miner/screens/contacts/model/contact_selection_model.dart';
import 'package:time_miner/screens/contacts/widget/contact_sync_button.dart';
import 'package:time_miner/screens/dashboard/home_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<ContactSelection> _contactSelections = [];
  List<ContactSelection> _filteredSelections = [];
  bool _loading = true;
  bool _permissionDenied = false;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchContacts() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        _contactSelections = contacts
            .map((c) => ContactSelection(contact: c))
            .toList();
        _filteredSelections = List.from(_contactSelections);
        _loading = false;
        _permissionDenied = false;
      });
    } else {
      setState(() {
        _loading = false;
        _permissionDenied = true;
      });
    }
  }

  void _onContactChecked(int index, bool checked) {
    setState(() {
      _filteredSelections[index].isSelected = checked;
      // Also update the main list for consistency
      final originalIndex = _contactSelections.indexWhere(
        (c) => c.contact.identifier == _filteredSelections[index].contact.identifier,
      );
      if (originalIndex != -1) {
        _contactSelections[originalIndex].isSelected = checked;
      }
    });
  }

  void _onSync() {
    context.navigate(const HomeScreen());
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSelections = List.from(_contactSelections);
      } else {
        _filteredSelections = _contactSelections.where((selection) {
          final name = selection.contact.displayName?.toLowerCase() ?? '';
          final phone = selection.contact.phones?.isNotEmpty == true
              ? selection.contact.phones!.first.value?.toLowerCase() ?? ''
              : '';
          return name.contains(query) || phone.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_permissionDenied) {
      return PermissionDecline(
        message: "Permission denied. Please enable contacts permission in settings.",
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
      body: Column(
        children: [
          if (_showSearch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withAlpha(20),
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
              itemCount: _filteredSelections.length,
              itemBuilder: (context, index) {
                final selection = _filteredSelections[index];
                final contact = selection.contact;
                final name = contact.displayName ?? 'No Name';
                return CheckboxListTile(
                  value: selection.isSelected,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (val) => _onContactChecked(index, val ?? false),
                  title: Text(name),
                  subtitle: contact.phones != null && contact.phones!.isNotEmpty
                      ? Text(contact.phones!.first.value ?? '')
                      : null,
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContactSyncButton(onContactSync: _onSync),
            ),
          ),
        ],
      ),
    );
  }
}