import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/repository/contact_repository.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/screens/dashboard/contact_tab/widget/contacts_tab_list.dart';

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
      create: (_) => ContactsTabCubit(
        contactRepository: context.read<ContactRepository>(),
        sessionPref: context.read<SessionPref>(),
      )..loadContactsData(),
      child: _ContactViewScaffold(),
    );
  }
}

class _ContactViewScaffold extends StatefulWidget {
  const _ContactViewScaffold();

  @override
  State<_ContactViewScaffold> createState() => _ContactViewScaffoldState();
}

class _ContactViewScaffoldState extends State<_ContactViewScaffold> {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
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
        title: const Text(
          'Contacts',
          // style: TextStyle(
          //   color: Color(0xFF16686A),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 22,
          // ),
        ),
        // backgroundColor: Colors.white,
        // elevation: 1,
        // automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              _showSearch ? Icons.close : Icons.search,
                color: Colors.white
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
            icon: const Icon(
                Icons.refresh,
                color: Colors.white
            ),
            onPressed: () {
              context.read<ContactsTabCubit>().syncContactsData();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showSearch)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search contacts...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
          Expanded(child: ContactsTabList(searchQuery: _searchQuery)),
        ],
      ),
    );
  }
}
