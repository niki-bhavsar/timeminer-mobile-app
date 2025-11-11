import 'package:another_telephony/telephony.dart';

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
      final List<SmsMessage> filteredMessages = allMessages.where((msg) {
        final msgDate = DateTime.fromMillisecondsSinceEpoch(msg.date ?? 0);
        return (msgDate.isAfter(startDate) || msgDate.isAtSameMomentAs(startDate)) &&
               (msgDate.isBefore(endDate) || msgDate.isAtSameMomentAs(endDate));
      }).toList();

      // Map to a list of simple JSON objects (for API sync)
      final List<Map<String, dynamic>> mappedMessages = filteredMessages.map((msg) {
        return {
          'address': msg.address ?? '',
          'body': msg.body ?? '',
          'date': msg.date != null
              ? DateTime.fromMillisecondsSinceEpoch(msg.date!).toIso8601String()
              : null,
          'type': msg.type?.index ?? 0, // 1=inbox, 2=sent
        };
      }).toList();

      return mappedMessages;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
}
