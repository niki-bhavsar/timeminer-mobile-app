import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/screens/common/permission_decline.dart';
import 'package:call_log/call_log.dart'; // Uncomment if using real call log data

class _TmpCall {
  final int ts;
  final CallLogItem item;
  _TmpCall({required this.ts, required this.item});
}

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
    // request proper permission for call logs
    final status = await Permission.phone.request();
    if (!mounted) return;

    if (!status.isGranted) {
      setState(() {
        _loading = false;
        _permissionDenied = true;
      });
      return;
    }

    setState(() {
      _loading = true;
      _permissionDenied = false;
    });

    try {
      // fetch system call logs (requires <uses-permission android:name="android.permission.READ_CALL_LOG"/> in AndroidManifest)
      final Iterable<CallLogEntry> entries = await CallLog.get();

      // map and sort newest-first
      final List<CallLogItem> logs = entries.map((e) {
        final ts = e.timestamp;
        final timeStr = _formatTimestamp(ts);
        final callTypeRaw = (e.callType ?? '').toString().toLowerCase();
        final type = callTypeRaw.contains('out') || callTypeRaw.contains('made')
            ? 'outgoing'
            : callTypeRaw.contains('miss')
            ? 'missed'
            : 'incoming';

        return CallLogItem(
          name: e.name ?? (e.number ?? 'Unknown'),
          number: e.number ?? '',
          type: type,
          time: timeStr,
          duration: (e.duration ?? 0),
        );
      }).toList();

      logs.sort((a, b) {
        // try to parse timestamp back from time string not ideal - use original entries order instead:
        // safer approach: build from entries with timestamp preserved
        return 0; // placeholder, we'll re-build using entries with timestamps below
      });

      // Better: rebuild using entries with timestamp for correct ordering:
      final List<_TmpCall> tmp = entries.map((e) {
        final ts = e.timestamp ?? 0;
        final callTypeRaw = (e.callType ?? '').toString().toLowerCase();
        final type = callTypeRaw.contains('out') || callTypeRaw.contains('made')
            ? 'outgoing'
            : callTypeRaw.contains('miss')
            ? 'missed'
            : 'incoming';
        return _TmpCall(
          ts: ts,
          item: CallLogItem(
            name: e.name ?? (e.number ?? 'Unknown'),
            number: e.number ?? '',
            type: type,
            time: _formatTimestamp(ts),
            duration: (e.duration ?? 0),
          ),
        );
      }).toList();

      tmp.sort((a, b) => b.ts.compareTo(a.ts));
      final List<CallLogItem> finalLogs = tmp.map((t) => t.item).toList();

      if (!mounted) return;
      setState(() {
        _callLogs = finalLogs;
        _filteredCallLogs = List.from(finalLogs);
        _loading = false;
        _permissionDenied = false;
      });
    } catch (e, st) {
      debugPrint('CallLog.get failed: $e\n$st');
      if (!mounted) return;
      setState(() {
        _loading = false;
        _permissionDenied = false;
        _callLogs = [];
        _filteredCallLogs = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to read call logs: ${e.toString()}')),
      );
    }
  }

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null || timestamp == 0) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = months[dt.month];
    final day = dt.day;
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$month $day, $hour:$minute $ampm';
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
        return const Icon(
          Icons.call_received,
          color: Color(0xFF16686A),
          size: 20,
        );
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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_permissionDenied) {
      return PermissionDecline(
        message:
            "Permission denied. Please enable call log permission in settings.",
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
