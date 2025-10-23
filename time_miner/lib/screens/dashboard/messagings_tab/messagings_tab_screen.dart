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
// //Fetch real device sms
// Future<void> _fetchMessages() async {
//   var status = await Permission.sms.request();
//   if (status.isGranted) {
//     SmsQuery query = SmsQuery();
//     List<SmsMessage> smsList = await query.getAllSms;
//     setState(() {
//       _messages = smsList.map((sms) => MessageItem(
//         sender: sms.sender ?? 'Unknown',
//         body: sms.body ?? '',
//         time: sms.date != null
//             ? "${sms.date!.toLocal()}"
//             : '',
//         avatarUrl: null,
//       )).toList();
//       _filteredMessages = List.from(_messages);
//       _loading = false;
//       _permissionDenied = false;
//     });
//   } else {
//     setState(() {
//       _loading = false;
//       _permissionDenied = true;
//     });
//   }
// }

  // Future<void> _fetchMessages() async {
  //   var status = await Permission.sms.request();
  //   if (status.isGranted) {
  //     setState(() {
  //       _messages = _mockMessages;
  //       _filteredMessages = List.from(_mockMessages);
  //       _loading = false;
  //       _permissionDenied = false;
  //     });
  //   } else {
  //     setState(() {
  //       _loading = false;
  //       _permissionDenied = true;
  //     });
  //   }
  // }

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
      // fetch inbox messages (check plugin docs if you want columns/filter/sort options)
      // this returns a list of SmsMessage
      final List<SmsMessage> inbox = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE],
        // you can add sort/filter options per package docs
        // Example: sort: [OrderBy(SmsColumn.DATE, sort: SortOrder.DESC)]
      );

      

      // sort newest-first and take top 50 (adjust as needed)
      inbox.sort((a, b) {
        final aDate = toDate(a.date);
        final bDate = toDate(b.date);
        return bDate.compareTo(aDate);
      });

      final List<SmsMessage> page = inbox.take(50).toList();

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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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
              // leading: msg.avatarUrl != null
              //     ? CircleAvatar(
              //         backgroundImage: AssetImage(msg.avatarUrl!),
              //         radius: 24,
              //       )
              //     : CircleAvatar(
              //         backgroundColor: Colors.grey[300],
              //         radius: 24,
              //         child: Icon(Icons.person, color: Colors.grey[600]),
              //       ),
              title: Text(
                msg.address ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                msg.body ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                CommonMethods.formatTimestamp(msg.date ?? 0),
                //toDate(msg.date).toUtc().toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
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

// ...existing MessageItem class and _mockMessages...

// Mock message model and data
class MessageItem {
  final String sender;
  final String body;
  final String time;
  final String? avatarUrl;

  MessageItem({
    required this.sender,
    required this.body,
    required this.time,
    this.avatarUrl,
  });
}

final List<MessageItem> _mockMessages = [
  MessageItem(
    sender: 'Alex Smith',
    body: "I'm in a meeting right now, I'll call you back later.",
    time: 'Today 06:12 AM',
    avatarUrl: 'assets/images/avatar1.jpg',
  ),
  MessageItem(
    sender: 'Agata Mccormick',
    body: "Hello guys, we have discussed about post-corona vacation plan and our decision is to go to Bali. ...",
    time: 'Today 11:10 AM',
    avatarUrl: null,
  ),
  MessageItem(
    sender: 'Alex Smith',
    body: "The next thing we will consider is how to create our own kitchen set in our office!..",
    time: 'Yesterday 06:55 AM',
    avatarUrl: 'assets/images/avatar1.jpg',
  ),
  MessageItem(
    sender: 'Sophie Lee',
    body: "Get unlimited access to the full library & pro features from ₹800/month — cancel anytime.",
    time: 'Yesterday 10:10 PM',
    avatarUrl: 'assets/images/avatar2.jpg',
  ),
  MessageItem(
    sender: 'Micheal Brown',
    body: "This template allows you to create pixel-perfect mockups that mimic system iOS alerts. There's...",
    time: 'Oct 7, 8:16 PM',
    avatarUrl: null,
  ),
  MessageItem(
    sender: 'Alex Smith',
    body: "The next thing we will consider is how to create our own kitchen set in our office!..",
    time: 'Oct 6, 10:16 PM',
    avatarUrl: 'assets/images/avatar1.jpg',
  ),
  MessageItem(
    sender: 'Sophie Lee',
    body: "Get unlimited access to the full library & pro features from ₹800/month — cancel anytime.",
    time: 'Oct 5, 10:10 PM',
    avatarUrl: 'assets/images/avatar2.jpg',
  ),
  MessageItem(
    sender: 'Micheal Brown',
    body: "This template allows you to create pixel-perfect mockups that mimic system iOS alerts. There's...",
    time: 'Oct 5, 5:20 PM',
    avatarUrl: null,
  ),
];