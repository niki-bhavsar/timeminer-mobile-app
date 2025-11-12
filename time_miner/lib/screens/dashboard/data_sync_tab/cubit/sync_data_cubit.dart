import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/sync_history_entity.dart';
import 'package:time_miner/data/repository/sync_data_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/screens/common/sync_manager.dart';
import 'package:time_miner/screens/dashboard/call_logs_tab/calllog_fetcher.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/state/sync_state.dart';
import 'package:time_miner/screens/dashboard/messagings_tab/sms_fetcher.dart';

class SyncDataCubit extends Cubit<DataSyncState> {
  final SyncDataRepository syncDataRepository;

  SyncDataCubit({required this.syncDataRepository})
    : super(
        DataSyncState(
          startDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
          endDate: DateTime.now(),
        ),
      );

  void toggleMessages(bool value) =>
      emit(state.copyWith(isMessageSyncEnable: value));

  void toggleCallLogs(bool value) =>
      emit(state.copyWith(isCallLogsSyncEnable: value));

  void setStartDate(DateTime? date) => emit(state.copyWith(startDate: date));
  void setEndDate(DateTime? date) => emit(state.copyWith(endDate: date));

  Future<void> fetchHistoryData({bool loadMore = false}) async {
    if (state.isLoading || (!state.hasMore && loadMore)) return;

    emit(state.copyWith(isLoading: true));

    final page = loadMore ? state.currentPage + 1 : 1;

    final response = await syncDataRepository.getHistory(page);

    if (response is Success<SyncHistoryEntity>) {
      final totalPages = response.data.data.syncHistory.pagination.total;
      final newItems = response
          .data
          .data
          .syncHistory
          .items; // adjust depending on your model
      final hasMore =
          totalPages > state.currentPage; // or check response.data.hasMore flag

      emit(
        state.copyWith(
          isLoading: false,
          currentPage: page,
          hasMore: hasMore,
          syncHistory: loadMore
              ? [...state.syncHistory, ...newItems]
              : newItems,
        ),
      );
    } else if (response is Failure<SyncHistoryEntity>) {
      emit(state.copyWith(isLoading: false, error: response.cause));
    }
  }

  Future<void> syncData() async {
    if (!state.isMessageSyncEnable && !state.isCallLogsSyncEnable) {
      emit(
        state.copyWith(
          error: "Please enable Message Sync or Call Logs Sync to continue",
        ),
      );
      return;
    }
    if (state.startDate!.isAfter(state.endDate!)) {
      emit(state.copyWith(error: "Start date must be before end date"));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      // 1️⃣ Create sync request
      final syncInfo = await _createSyncRequest();
      if(syncInfo != null){
        emit(state.copyWith(isLoading: false, error: null));
        await SyncManager.instance.startBackgroundSync();
      }
      else{
        return;
      }
      

      // debugPrint("syncInfo $syncInfo");
      // if (syncInfo == null) return; // already handled error inside

      // final data = await _fetchLocalData();
      // final messages = data['messages']!;
      // final callLogs = data['callLogs']!;

      // await _updateSyncStatus(
      //     syncInfo['syncId'] ?? 0,
      //     2,
      //     2,
      //   );

      // if (messages.isNotEmpty) {
      //   final messageSynced = await _syncMessages(messages);
      //   if (!messageSynced) return;
      //   await _updateSyncStatus(
      //     syncInfo['syncId'] ?? 0,
      //     syncInfo['callStatus'] ?? 0,
      //     2,
      //   );
      // }
      // if (callLogs.isNotEmpty) {
      //   final callSynced = await _syncCallLogs(callLogs);
      //   if (!callSynced) return;
      //   await _updateSyncStatus(
      //     syncInfo['syncId'] ?? 0,
      //     2,
      //     syncInfo['messageStatus'] ?? 0,
      //   );
      // }
      // emit(state.copyWith(isSyncing: false, error: null));
    } catch (e) {
      emit(state.copyWith(isSyncing: false, error: e.toString()));
    }
  }

  Future<Map<String, int>?> _createSyncRequest() async {
    final response = await syncDataRepository.createSync(
      state.startDate.toString(),
      state.endDate.toString(),
      state.isMessageSyncEnable,
      state.isCallLogsSyncEnable,
    );

    if (response is Success<BaseEntity>) {
      if (!response.data.isSuccess) {
        emit(state.copyWith(isSyncing: false, error: response.data.message));
        return null;
      }

      final data = response.data.data as Map<String, dynamic>;
      return {
        'syncId': data['sync_log_id'] ?? 0,
        'callStatus': data['calls_status'] ?? 0,
        'messageStatus': data['messages_status'] ?? 0,
      };
    }

    emit(state.copyWith(isSyncing: false, error: "Failed to create sync"));
    return null;
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchLocalData() async {
    List<Map<String, dynamic>> messages = [];
    List<Map<String, dynamic>> callLogs = [];

    if (state.isMessageSyncEnable) {
      messages = await SmsFetcher.getMessagesBetween(
        state.startDate!,
        state.endDate!,
      );
    }

    if (state.isCallLogsSyncEnable) {
      callLogs = await CallLogFetcher.getCallLogsBetween(
        state.startDate!,
        state.endDate!,
      );
    }

    return {'messages': messages, 'callLogs': callLogs};
  }

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

  Future<bool> _syncMessages(List<Map<String, dynamic>> messages) async {
    const int chunkSize = 500;
    final chunks = _chunkList(messages, chunkSize);

    for (var chunk in chunks) {
      final response = await syncDataRepository.syncData(
        messages: chunk,
        calllogs: null,
      );
      if (response is Failure<BaseEntity>) {
        emit(state.copyWith(isSyncing: false, error: response.cause));
        return false;
      }
    }
    return true;
  }

  Future<bool> _syncCallLogs(List<Map<String, dynamic>> callLogs) async {
    const int chunkSize = 500;
    final chunks = _chunkList(callLogs, chunkSize);

    for (var chunk in chunks) {
      final response = await syncDataRepository.syncData(
        messages: null,
        calllogs: chunk,
      );
      if (response is Failure<BaseEntity>) {
        emit(state.copyWith(isSyncing: false, error: response.cause));
        return false;
      }
    }
    return true;
  }

  Future<void> _updateSyncStatus(
    int syncId,
    int callStatus,
    int messageStatus,
  ) async {
    final response = await syncDataRepository.updateHistory(
      syncId,
      callStatus,
      messageStatus,
    );

    if (response is Success<BaseEntity>) {
      if (!response.data.isSuccess) {
        emit(
          state.copyWith(
            isSyncing: false,
            error: "Failed to update sync status",
          ),
        );
      }
    } else if (response is Failure<BaseEntity>) {
      emit(state.copyWith(isSyncing: false, error: response.cause));
    }
  }
}
