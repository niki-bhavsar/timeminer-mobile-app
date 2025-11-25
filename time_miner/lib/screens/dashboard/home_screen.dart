import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/contacts_entity.dart';
import 'package:time_miner/data/repository/contact_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/screens/common/sync_manager.dart';
import 'package:time_miner/screens/dashboard/account_tab/account_tab_screen.dart';
import 'package:time_miner/screens/dashboard/call_logs_tab/call_logs_tab_screen.dart';
import 'package:time_miner/screens/dashboard/contact_tab/contacts_tab_screen.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/sync_data_screen.dart';
import 'package:time_miner/screens/dashboard/messagings_tab/messagings_tab_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _syncInitialized = false;
  bool _contactsFetched = false;

  @override
  void initState() {
    super.initState();
    if (!_syncInitialized) {
      _syncInitialized = true;
      debugPrint("🚀 Starting background sync from HomeScreen");
      SyncManager.instance.startBackgroundSync();
    }
    _fetchContactsFromApi();
  }

  Future<void> _fetchContactsFromApi() async {
    if (_contactsFetched) return;

    // Fetch contacts silently in the background without any UI indicators
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fire and forget - no await, no blocking, completely silent
      _fetchContactsInBackground();
    });
  }

  Future<void> _fetchContactsInBackground() async {
    try {
      final contactRepository = context.read<ContactRepository>();
      final sessionPref = context.read<SessionPref>();

      debugPrint("📞 Fetching contacts from API in background...");
      final result = await contactRepository.getContacts();

      if (result is Success<ContactsEntity>) {
        await sessionPref.setContacts(result.data);
        _contactsFetched = true; // Update flag without setState (no UI impact)
      } else if (result is Failure<ContactsEntity>) {
        debugPrint("Failed to fetch contacts: ${result.cause}");
      }
    } catch (e) {
      debugPrint("Error fetching contacts: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const List<Widget> _pages = <Widget>[
    AccountTabScreen(),
    MessagingTabScreen(),
    CallLogsTabScreen(),
    ContactsTabScreen(),
    SyncDataScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   color: Colors.transparent,
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onSecondary.withAlpha(50),
              size: 22,
            ),
            if (label.isNotEmpty && isActive) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    double bottomPadding = bottomInset > 0 ? 26.0 : 40.0;

    return ValueListenableBuilder<bool>(
      valueListenable:
          SyncManager.instance.isSyncing, // 👈 Listen for sync changes
      builder: (context, isSyncing, _) {
        return Scaffold(
          body: Column(
            children: [
              // 🔄 Syncing banner
              if (isSyncing)
                Container(
                  width: double.infinity,
                  color: Colors.amber.shade100,
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: const Center(
                    child: Text(
                      "🔄 Syncing in progress...",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              // Main tab content
              Expanded(child: _pages[_selectedIndex]),
            ],
          ),

          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Container(
              height: 80,
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).colorScheme.secondary,
                border: Border.all(
                  color:  Theme.of(context).colorScheme.onPrimaryContainer, // <-- added border color
                  width: 1,                       // adjust thickness if needed
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black,
                //     blurRadius: 8,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        0,
                        Icons.account_circle,
                        'Account',
                        _selectedIndex == 0,
                      ),
                      _buildNavItem(
                        1,
                        Icons.message,
                        'Messaging',
                        _selectedIndex == 1,
                      ),
                      _buildNavItem(
                        2,
                        Icons.call,
                        'Call Logs',
                        _selectedIndex == 2,
                      ),
                      _buildNavItem(
                        3,
                        Icons.contacts,
                        'Contacts',
                        _selectedIndex == 3,
                      ),
                      _buildNavItem(4, Icons.sync, 'Sync', _selectedIndex == 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
