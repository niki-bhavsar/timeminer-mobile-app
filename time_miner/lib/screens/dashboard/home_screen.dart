import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? Theme.of(context).colorScheme.onSecondary
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

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.secondary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
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
  }
}
