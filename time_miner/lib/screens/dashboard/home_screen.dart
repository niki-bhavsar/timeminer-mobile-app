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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50), // Reduced border radius
          child: SizedBox(
            height: 100,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              selectedItemColor: Theme.of(context).colorScheme.onSecondary,
              unselectedItemColor: Theme.of(
                context,
              ).colorScheme.onSecondary.withAlpha(50),
              iconSize: 28, // Optional: increase icon size for better centering
              items: const [
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    children: [Icon(Icons.account_circle)],
                  ),
                  label: 'Account',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Messaging',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: 'Call Logs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.sync), label: 'Sync'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
