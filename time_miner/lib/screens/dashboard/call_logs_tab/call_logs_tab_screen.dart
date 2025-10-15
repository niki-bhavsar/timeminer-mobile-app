import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/screens/common/permission_decline.dart';
// import 'package:call_log/call_log.dart'; // Uncomment if using real call log data

class CallLogsTabScreen extends StatefulWidget {
  const CallLogsTabScreen({super.key});

  @override
  State<CallLogsTabScreen> createState() => _CallLogsTabScreenState();
}

class _CallLogsTabScreenState extends State<CallLogsTabScreen> {
  bool _loading = true;
  bool _permissionDenied = false;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  List<CallLogItem> _callLogs = [];
  List<CallLogItem> _filteredCallLogs = [];

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCallLogs() async {
    var status = await Permission.phone.request();
    if (status.isGranted) {
      // For real data, use the call_log plugin here.
      // Iterable<CallLogEntry> entries = await CallLog.get();
      setState(() {
        _callLogs = _mockCallLogs;
        _filteredCallLogs = List.from(_mockCallLogs);
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
        _filteredCallLogs = List.from(_callLogs);
      } else {
        _filteredCallLogs = _callLogs.where((log) {
          return log.name.toLowerCase().contains(query) ||
              log.number.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Icon _callTypeIcon(String type) {
    switch (type) {
      case 'incoming':
        return const Icon(Icons.call_received, color: Color(0xFF16686A), size: 20);
      case 'outgoing':
        return const Icon(Icons.call_made, color: Color(0xFF16686A), size: 20);
      case 'missed':
        return const Icon(Icons.call_missed, color: Colors.red, size: 20);
      default:
        return const Icon(Icons.call, color: Colors.grey, size: 20);
    }
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
        message: "Permission denied. Please enable call log permission in settings.",
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
                  hintText: 'Search call logs...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Color(0xFF16686A),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Text(
                'Call Log',
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
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        itemCount: _filteredCallLogs.length,
        itemBuilder: (context, index) {
          final log = _filteredCallLogs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              leading: _callTypeIcon(log.type),
              title: Text(
                log.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(log.number),
              trailing: Text(
                log.time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              onTap: () {
                // TODO: Show call log details
              },
            ),
          );
        },
      ),
    );
  }
}

// Mock call log model and data
class CallLogItem {
  final String name;
  final String number;
  final String type; // 'incoming', 'outgoing', 'missed'
  final String time;
  final int duration; // in seconds

  CallLogItem({
    required this.name,
    required this.number,
    required this.type,
    required this.time,
    required this.duration,
  });
}

final List<CallLogItem> _mockCallLogs = [
  CallLogItem(
    name: 'Alex Smith',
    number: '(123) 456-7894',
    type: 'incoming',
    time: 'Today 06:12 AM',
    duration: 120,
  ),
  CallLogItem(
    name: 'Agata Mccormick',
    number: '(728) 202-2707',
    type: 'outgoing',
    time: 'Today 11:10 AM',
    duration: 60,
  ),
  CallLogItem(
    name: 'Alex Smith',
    number: '(123) 456-7894',
    type: 'incoming',
    time: 'Yesterday 06:55 AM',
    duration: 90,
  ),
  CallLogItem(
    name: 'Agata Mccormick',
    number: '(728) 202-2707',
    type: 'outgoing',
    time: 'Yesterday 10:10 PM',
    duration: 45,
  ),
  CallLogItem(
    name: 'Alex Smith',
    number: '(123) 456-7894',
    type: 'incoming',
    time: 'Oct 6, 10:16 PM',
    duration: 30,
  ),
  CallLogItem(
    name: 'Agata Mccormick',
    number: '(728) 202-2707',
    type: 'outgoing',
    time: 'Oct 5, 10:10 PM',
    duration: 20,
  ),
  CallLogItem(
    name: 'Alex Smith',
    number: '(123) 456-7894',
    type: 'incoming',
    time: 'Oct 5, 5:20 PM',
    duration: 10,
  ),
];