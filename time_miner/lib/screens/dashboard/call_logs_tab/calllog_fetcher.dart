import 'package:call_log/call_log.dart';
import 'package:flutter/widgets.dart';

class CallLogFetcher {
  static Future<List<Map<String, dynamic>>> getCallLogsBetween(
      DateTime startDate, DateTime endDate) async {
    try {
      // Fetch call logs starting from `startDate`
      final end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);

      final Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: startDate.millisecondsSinceEpoch,
        dateTo: end.millisecondsSinceEpoch,
      );

      // Transform and normalize call logs
      final List<_TmpCall> tmp = entries.map((e) {
        final int ts = e.timestamp ?? 0;
        final String callTypeRaw = (e.callType ?? '').toString().toLowerCase();

        debugPrint('Raw call type******: $callTypeRaw');

        // Normalize call type for consistent API representation
       String type = callTypeRaw.contains('out') || callTypeRaw.contains('made')
            ? 'outgoing'
            : callTypeRaw.contains('incoming')
                ? 'incoming'
                : 'missed';
        if(e.duration == 0){
          type = "missed";
          debugPrint('Zero second call type: $type');
        }
        return _TmpCall(
          ts: ts,
          item: {
            'id':'${e.number}_${e.timestamp}',
            'name': e.name ?? e.number ?? 'Unknown',
            'number': e.number ?? '',
            'type': type,
            'timestamp': ts,
            'duration': e.duration ?? 0,
          },
        );
      }).toList();

      // Sort newest-first
      tmp.sort((a, b) => b.ts.compareTo(a.ts));

      // Map to plain list for API payload
      final List<Map<String, dynamic>> finalLogs =
          tmp.map((t) => t.item).toList();

      return finalLogs;
    } catch (e) {
      print('Error fetching call logs: $e');
      return [];
    }
  }
}

class _TmpCall {
  final int ts;
  final Map<String, dynamic> item;

  _TmpCall({required this.ts, required this.item});
}
