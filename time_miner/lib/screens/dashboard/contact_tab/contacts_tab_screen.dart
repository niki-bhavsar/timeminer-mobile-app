import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/screens/common/permission_decline.dart';
import 'package:time_miner/screens/contacts/model/contact_selection_model.dart';

class ContactsTabScreen extends StatefulWidget {
  const ContactsTabScreen({super.key});

  @override
  State<ContactsTabScreen> createState() => _ContactsTabScreenState();
}

class _ContactsTabScreenState extends State<ContactsTabScreen> {
  List<ContactSelection> _contactSelections = [];
  List<ContactSelection> _filteredSelections = [];
  bool _permissionDenied = false;
  bool _loading = true;
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
        _contactSelections = contacts.map((c) => ContactSelection(contact: c)).toList();
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

  Future<void> _syncContacts() async {
    // TODO: Send updated _contacts list to your API
    // For now, just show a dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sync'),
        content: const Text('Contacts synced successfully!'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_permissionDenied) {
      return PermissionDecline(
        message: "Permission denied. Please enable contacts permission in settings.",
        onSetting: openAppSettings,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search contacts...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Color(0xFF16686A),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Text(
                'Contacts',
                style: TextStyle(
                  color: Color(0xFF16686A),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search, color: Color(0xFF16686A)),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) {
                  _searchController.clear();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF16686A)),
            onPressed: _syncContacts,
          ),
        ],
      ),
      body: ListView.builder(
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
    );
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
}
