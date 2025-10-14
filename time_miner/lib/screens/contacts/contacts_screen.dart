import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:time_miner/screens/common/permission_decline.dart';
import 'package:time_miner/screens/contacts/model/contact_selection_model.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<ContactSelection> _contactSelections = [];
  final Set<String> _selectedContactIds = {};
  bool _loading = true;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
  var status = await Permission.contacts.request();

  if (status.isGranted) {
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        _contactSelections = contacts
            .map((c) => ContactSelection(contact: c))
            .toList();
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

  void _onContactChecked(int index, bool checked)  {
    setState(() {
       _contactSelections[index].isSelected = checked;
    });
  }

  void _onSync() {
    final billable = _contactSelections.where((c) => c.isSelected).toList();
    final nonBillable = _contactSelections.where((c) => !c.isSelected).toList();

    // TODO: Sync logic here
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sync Result'),
        content: Text(
          'Billable: ${billable.length}\nNon-billable: ${nonBillable.length}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_permissionDenied) {
       return PermissionDecline(message: "Permission denied. Please enable contacts permission in settings.", onSetting: openAppSettings);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _contactSelections.length,
              itemBuilder: (context, index) {
                final selection = _contactSelections[index];
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
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSync,
                  child: const Text('Sync'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}