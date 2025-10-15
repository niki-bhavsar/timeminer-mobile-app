import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String email;
  final String phone;
  bool isBillable;

  Contact({
    required this.name,
    required this.email,
    required this.phone,
    this.isBillable = false,
  });
}

class ContactsTabScreen extends StatefulWidget {
  const ContactsTabScreen({super.key});

  @override
  State<ContactsTabScreen> createState() => _ContactsTabScreenState();
}

class _ContactsTabScreenState extends State<ContactsTabScreen> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  bool _loading = true;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContactsFromApi();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchContactsFromApi() async {
    setState(() {
      _loading = true;
    });

    // TODO: Replace with your real API call
    await Future.delayed(const Duration(seconds: 1));
    List<Contact> apiContacts = [
      Contact(
        name: 'Alex Smith',
        email: 'alexsmith145@gmail.com',
        phone: '(123) 456-7894',
        isBillable: true,
      ),
      Contact(
        name: 'Agata Mccormick',
        email: 'kallie.blackwood@gmail.com',
        phone: '(728) 202-2707',
        isBillable: true,
      ),
      // Add more contacts as needed
    ];

    // Simulate system contacts (newly added, not in API)
    List<Contact> systemContacts = [
      Contact(
        name: 'New System Contact',
        email: 'new.contact@gmail.com',
        phone: '(555) 123-4567',
        isBillable: false, // Default to non-billable
      ),
    ];

    // Merge API and system contacts, avoiding duplicates
    List<Contact> mergedContacts = [
      ...apiContacts,
      ...systemContacts.where((sys) =>
        !apiContacts.any((api) => api.phone == sys.phone)),
    ];

    setState(() {
      _contacts = mergedContacts;
      _filteredContacts = List.from(mergedContacts);
      _loading = false;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = List.from(_contacts);
      } else {
        _filteredContacts = _contacts.where((contact) {
          return contact.name.toLowerCase().contains(query) ||
              contact.email.toLowerCase().contains(query) ||
              contact.phone.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _toggleBillable(int index, bool? value) {
    setState(() {
      _filteredContacts[index].isBillable = value ?? false;
      // Also update the main list
      final mainIndex = _contacts.indexWhere(
        (c) => c.phone == _filteredContacts[index].phone,
      );
      if (mainIndex != -1) {
        _contacts[mainIndex].isBillable = value ?? false;
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
            onPressed: _fetchContactsFromApi,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        itemCount: _filteredContacts.length,
        itemBuilder: (context, index) {
          final contact = _filteredContacts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              title: Text(
                contact.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.email),
                  Text(contact.phone),
                ],
              ),
              trailing: Checkbox(
                value: contact.isBillable,
                onChanged: (val) => _toggleBillable(index, val),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                activeColor: const Color(0xFF16686A),
              ),
            ),
          );
        },
      ),
      
    );
  }
}