import 'package:call_log/call_log.dart';

class CallLogFetcher {
  static Future<List<Map<String, dynamic>>> getCallLogsBetween(
      DateTime startDate, DateTime endDate) async {
    try {
      // Fetch call logs starting from `startDate`
      final Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: startDate.millisecondsSinceEpoch,
        dateTo: endDate.millisecondsSinceEpoch,
      );

      // Transform and normalize call logs
      final List<_TmpCall> tmp = entries.map((e) {
        final int ts = e.timestamp ?? 0;
        final String callTypeRaw = (e.callType ?? '').toString().toLowerCase();

        // Normalize call type for consistent API representation
        final String type = callTypeRaw.contains('out') || callTypeRaw.contains('made')
            ? 'outgoing'
            : callTypeRaw.contains('miss')
                ? 'missed'
                : 'incoming';

        return _TmpCall(
          ts: ts,
          item: {
            'name': e.name ?? e.number ?? 'Unknown',
            'number': e.number ?? '',
            'type': type,
            'timestamp': DateTime.fromMillisecondsSinceEpoch(ts).toIso8601String(),
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
