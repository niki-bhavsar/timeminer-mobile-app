import 'package:another_telephony/telephony.dart';
import 'package:flutter/material.dart';

class SmsFetcher {
  static final Telephony telephony = Telephony.instance;

  static Future<List<Map<String, dynamic>>> getMessagesBetween(
      DateTime startDate, DateTime endDate) async {
    try {
      // Fetch inbox and sent SMS
      final List<SmsMessage> inboxMessages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE, SmsColumn.TYPE],
      );

      final List<SmsMessage> sentMessages = await telephony.getSentSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE, SmsColumn.TYPE],
      );

      // Merge and sort (newest first)
      final List<SmsMessage> allMessages = [...inboxMessages, ...sentMessages];
      allMessages.sort((a, b) {
        final aDate = DateTime.fromMillisecondsSinceEpoch(a.date ?? 0);
        final bDate = DateTime.fromMillisecondsSinceEpoch(b.date ?? 0);
        return bDate.compareTo(aDate);
      });

      // Filter messages within the date range
      final end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);

      final List<SmsMessage> filteredMessages = allMessages.where((msg) {
        final msgDate = DateTime.fromMillisecondsSinceEpoch(msg.date ?? 0);
        return (msgDate.isAfter(startDate) || msgDate.isAtSameMomentAs(startDate)) &&
               (msgDate.isBefore(end) || msgDate.isAtSameMomentAs(end));
      }).toList();

      // Map to a list of simple JSON objects (for API sync)
      final List<Map<String, dynamic>> mappedMessages = filteredMessages.map((msg) {
        return {
          'id': '${msg.address}_${msg.date}',
          'address': msg.address ?? '',
          'body': msg.body ?? '',
          'date': msg.date ?? 0,
          'type': (msg.type?.index ?? 0) == 1 ? "Inbox" : "Sent", // 1=inbox, 2=sent
        };
      }).toList();
     debugPrint('Fetched $mappedMessages messages between $startDate and $end');
      return mappedMessages;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
}
