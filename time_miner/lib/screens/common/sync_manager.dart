import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:time_miner/data/repository/sync_data_repository.dart';
import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/sync_history_entity.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/screens/dashboard/call_logs_tab/calllog_fetcher.dart';
import 'package:time_miner/screens/dashboard/messagings_tab/sms_fetcher.dart';

enum SyncStatus { started, completed }

class SyncManager {
  // Singleton pattern
  SyncManager._();
  static final SyncManager instance = SyncManager._();

  // Inject repository using GetIt
  final syncDataRepository = GetIt.instance.get<SyncDataRepository>();

  bool _isRunning = false;
  final ValueNotifier<bool> isSyncing = ValueNotifier(false); // 👈 Notifier

  final _syncStatusController = StreamController<SyncStatus>.broadcast();

  Stream<SyncStatus> get syncStatusStream => _syncStatusController.stream;



  /// Starts background sync across all pending history items
  Future<void> startBackgroundSync() async {
    if (_isRunning) {
      debugPrint("🔄 SyncManager already running, skipping duplicate run.");
      return;
    }

    _isRunning = true;
    isSyncing.value = true;
    _syncStatusController.add(SyncStatus.started);
    debugPrint("🚀 Starting background sync process...");

    try {
      // Fetch all pending sync items across pages
      final pendingSyncs = await _fetchAllPendingSyncs();

      if (pendingSyncs.isEmpty) {
        debugPrint("✅ No pending syncs found.");
        return;
      }

      debugPrint("📦 Found ${pendingSyncs.length} pending sync(s).");
      for (final sync in pendingSyncs) {
        await _resumeSync(sync);
      }
    } catch (e, st) {
      debugPrint("❌ Background sync failed: $e\n$st");
    } finally {
      _isRunning = false;
      isSyncing.value = false; 
      _syncStatusController.add(SyncStatus.completed);
      debugPrint("✅ Background sync completed.");

    }
  }

  /// Fetch all pages from history and collect pending syncs
  Future<List<SyncHistoryItem>> _fetchAllPendingSyncs() async {
    int page = 1;
    bool hasMore = true;
    final pendingList = <SyncHistoryItem>[];

    while (hasMore) {
      final response = await syncDataRepository.getHistory(page);

      if (response is! Success<SyncHistoryEntity>) break;

      final history = response.data.data.syncHistory;
      if (history.items.isEmpty) break;

      // Filter pending syncs
      final pending = history.items.where(
        (item) =>
            ((item.messagesStatus != 2) ||
            (item.callsStatus != 2) && (item.status != 2)),
      );

      pendingList.addAll(pending);

      // Determine if we should fetch more pages
      hasMore = history.pagination.total > history.pagination.currentPage;
      page++;
    }

    return pendingList;
  }

  /// Resume a single sync operation
  Future<void> _resumeSync(SyncHistoryItem sync) async {
    debugPrint("🔁 Resuming sync ID ${sync.syncLogId}...");

    // 1️⃣ Sync messages if enabled & incomplete
    if (sync.syncMessages && sync.messagesStatus != 2) {
      final success = await _syncMessages(sync);
      if (success) {
        await syncDataRepository.updateHistory(
          sync.syncLogId,
          sync.callsStatus,
          2,
        );
        debugPrint("✅ Messages synced for ID ${sync.syncLogId}");
        sync.messagesStatus = 2;
      }
    }

    // 2️⃣ Sync call logs if enabled & incomplete
    if (sync.syncCalls && sync.callsStatus != 2) {
      final success = await _syncCallLogs(sync);
      if (success) {
        await syncDataRepository.updateHistory(
          sync.syncLogId,
          2,
          sync.messagesStatus,
        );
        debugPrint("✅ Call logs synced for ID ${sync.syncLogId}");
      }
    }

    debugPrint("✅ Sync ${sync.syncLogId} completed.");
  }

  /// Sync messages for the given sync range
  Future<bool> _syncMessages(SyncHistoryItem sync) async {
    final messages = await SmsFetcher.getMessagesBetween(
      sync.startDate,
      sync.endDate,
    );
    if (messages.isEmpty) {
      debugPrint("ℹ️ No messages to sync for ID ${sync.syncLogId}");
      return true;
    }

    final chunks = _chunkList(messages, 500);
    for (final chunk in chunks) {
      final response = await syncDataRepository.syncMessages(
        sync.syncLogId.toString(),
        chunk,
      );
      if (response is Failure<BaseEntity>) {
        debugPrint(
          "❌ Message sync failed for ID ${sync.syncLogId}: ${response.cause}",
        );
        return false;
      }
    }
    return true;
  }

  /// Sync call logs for the given sync range
  Future<bool> _syncCallLogs(SyncHistoryItem sync) async {
    final callLogs = await CallLogFetcher.getCallLogsBetween(
      sync.startDate,
      sync.endDate,
    );
    if (callLogs.isEmpty) {
      debugPrint("ℹ️ No call logs to sync for ID ${sync.syncLogId}");
      return true;
    }

    final chunks = _chunkList(callLogs, 500);
    for (final chunk in chunks) {
      final response = await syncDataRepository.syncCallLogs(sync.syncLogId.toString(), chunk);
      if (response is Failure<BaseEntity>) {
        debugPrint(
          "❌ Call log sync failed for ID ${sync.syncLogId}: ${response.cause}",
        );
        return false;
      }
    }
    return true;
  }

  /// Helper to split a list into smaller chunks
  List<List<Map<String, dynamic>>> _chunkList(
    List<Map<String, dynamic>> list,
    int size,
  ) {
    final chunks = <List<Map<String, dynamic>>>[];
    for (var i = 0; i < list.length; i += size) {
      chunks.add(
        list.sublist(i, i + size > list.length ? list.length : i + size),
      );
    }
    return chunks;
  }
}
