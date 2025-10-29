import 'dart:developer';
import 'dart:io';

import 'package:another_telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/screens/common/common_methods.dart';
import 'package:time_miner/screens/common/permission_decline.dart';

class MessagingTabScreen extends StatefulWidget {
  const MessagingTabScreen({super.key});

  @override
  State<MessagingTabScreen> createState() => _MessagingTabScreenState();
}

class _MessagingTabScreenState extends State<MessagingTabScreen> {
  bool _loading = true;
  bool _permissionDenied = false;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> _messages = [];
  List<SmsMessage> _filteredMessages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    if (!Platform.isAndroid) {
      setState(() {
        _loading = false;
        _permissionDenied = true;
      });
      return;
    }

    // request SMS permission via telephony
    final bool? granted = await telephony.requestSmsPermissions;
    if (granted != true) {
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
      final List<SmsMessage> inboxMessages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE, SmsColumn.TYPE],
      );

      final List<SmsMessage> sentMessages = await telephony.getSentSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE, SmsColumn.TYPE],
      );

      final List<SmsMessage> allMessages = [...inboxMessages, ...sentMessages];

      // sort newest-first and take top 50 (adjust as needed)
      allMessages.sort((a, b) {
        final aDate = toDate(a.date);
        final bDate = toDate(b.date);
        return bDate.compareTo(aDate);
      });

      // final List<SmsMessage> page = inbox.take(50).toList();
      final DateTime startDate = DateTime(2025, 10, 1);
      final DateTime endDate = DateTime(2025, 10, 31);

      final List<SmsMessage> page = allMessages.where((msg) {
        final messageDate = DateTime.fromMillisecondsSinceEpoch(msg.date ?? 0);
        return messageDate.isAfter(startDate) && messageDate.isBefore(endDate);
      }).toList();

      if (!mounted) return;
      setState(() {
        _messages = page;
        _filteredMessages = List.from(_messages);
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _messages = [];
        _loading = false;
      });
      debugPrint('Failed to fetch SMS: $e');
    }
  }

  DateTime toDate(Object? d) {
    if (d == null) return DateTime.fromMillisecondsSinceEpoch(0);
    if (d is DateTime) return d;
    if (d is int) return DateTime.fromMillisecondsSinceEpoch(d);
    if (d is String) {
      final intVal = int.tryParse(d);
      if (intVal != null) return DateTime.fromMillisecondsSinceEpoch(intVal);
      try {
        return DateTime.parse(d);
      } catch (_) {
        return DateTime.fromMillisecondsSinceEpoch(0);
      }
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMessages = List.from(_messages);
      } else {
        _filteredMessages = _messages.where((msg) {
          return msg.address!.toLowerCase().contains(query) ||
              msg.body!.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_permissionDenied) {
      return PermissionDecline(
        message: "Permission denied. Please enable messaging permission in settings.",
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
                  hintText: 'Search messages...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Color(0xFF16686A),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Text(
                'Messaging',
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
        itemCount: _filteredMessages.length,
        itemBuilder: (context, index) {
          final msg = _filteredMessages[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              title: Text(
                msg.address ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(msg.body ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: Text(
                CommonMethods.formatTimestamp(msg.date ?? 0),
                //toDate(msg.date).toUtc().toString(),
                style: const TextStyle(fontSize: 12),
              ),
              onTap: () {
                // TODO: Open message details
              },
            ),
          );
        },
      ),
    );
  }
}
