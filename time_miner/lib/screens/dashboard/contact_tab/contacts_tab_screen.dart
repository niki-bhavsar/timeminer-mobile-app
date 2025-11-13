import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/screens/contacts/model/contact_selection_model.dart';
import 'package:time_miner/screens/dashboard/contact_tab/bloc/contacts_tab_state.dart';
import 'package:time_miner/screens/dashboard/contact_tab/widget/contacts_tab_list.dart';
import 'package:time_miner/screens/dashboard/contact_tab/widget/contacts_tab_state_view.dart';

import '../../../data/entity/contacts_entity.dart';
import '../../../data/repository/contact_repository.dart';
import '../../../widget/progress.dart';
import 'contacts_tab_cubit.dart';

class ContactsTabScreen extends StatefulWidget {
  const ContactsTabScreen({super.key});

  @override
  State<ContactsTabScreen> createState() => _ContactsTabScreenState();
}

class _ContactsTabScreenState extends State<ContactsTabScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ContactsTabCubit(contactRepository: context.read<ContactRepository>())
            ..fetchContactsData(),
      child: const _ContactViewScaffold(),
    );
  }
}

class _ContactViewScaffold extends StatefulWidget {
  const _ContactViewScaffold({super.key});

  @override
  State<_ContactViewScaffold> createState() => _ContactViewScaffoldState();
}

class _ContactViewScaffoldState extends State<_ContactViewScaffold> {
  List<ContactSelection> _contactSelections = [];
  List<ContactSelection> _filteredSelections = [];
  List<ContactItem> contactListItem = [];
  bool _permissionDenied = false;
  bool _loading = true;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _fetchContacts();
    // _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
    // if (_loading) {
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }
    // if (_permissionDenied) {
    //   return PermissionDecline(
    //     message: "Permission denied. Please enable contacts permission in settings.",
    //     onSetting: openAppSettings,
    //   );
    // }
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
            icon: Icon(
              _showSearch ? Icons.close : Icons.search,
              color: Color(0xFF16686A),
            ),
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
            // onPressed: _syncContacts,
            onPressed: () {
              context.read<ContactsTabCubit>().syncContactsData();
            },
          ),
        ],
      ),
      body: ContactsTabList(),
    );
  }
}
