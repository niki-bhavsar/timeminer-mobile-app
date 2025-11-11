import 'package:equatable/equatable.dart';
import 'package:time_miner/data/entity/sync_history_entity.dart';

class DataSyncState extends Equatable {
  final bool isLoading;
  final bool isSyncing;
  final bool isMessageSyncEnable;
  final bool isCallLogsSyncEnable;
  final int currentPage;
  final bool hasMore;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<SyncHistoryItem> syncHistory;
  final String? error;

  const DataSyncState({
    this.isLoading = false,
    this.isSyncing = false,
    this.isMessageSyncEnable = true,
    this.isCallLogsSyncEnable = true,
    this.currentPage = 1,
    this.hasMore = false,
    this.startDate,
    this.endDate,
    this.syncHistory = const [],
    this.error,
    
  });

  DataSyncState copyWith({
    bool? isLoading,
    bool? isSyncing,
    bool? isMessageSyncEnable,
    bool? isCallLogsSyncEnable,
    int? currentPage,
    bool? hasMore,
    DateTime? startDate,
    DateTime? endDate,
    List<SyncHistoryItem>? syncHistory,
    String? error,
  }) {
    return DataSyncState(
      isLoading: isLoading ?? this.isLoading,
      isSyncing: isSyncing ?? this.isSyncing,
      isMessageSyncEnable: isMessageSyncEnable ?? this.isMessageSyncEnable,
      isCallLogsSyncEnable: isCallLogsSyncEnable ?? this.isCallLogsSyncEnable,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      syncHistory: syncHistory ?? this.syncHistory,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSyncing, isMessageSyncEnable, isCallLogsSyncEnable,currentPage, startDate, endDate, syncHistory, error];
}