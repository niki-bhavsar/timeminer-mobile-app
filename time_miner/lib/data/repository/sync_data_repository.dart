import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/sync_history_entity.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/data/service/sync_data_service.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';

abstract interface class SyncDataRepository {
  Future<CallResult<BaseEntity>> syncData({
    List<Map<String, dynamic>>? messages,
    List<Map<String, dynamic>>? calllogs,
  });
  Future<CallResult<BaseEntity>> syncCallLogs(
    String syncLogId,
    List<Map<String, dynamic>>? calllogs,
  );
  Future<CallResult<SyncHistoryEntity>> getHistory(int page);
  Future<CallResult<BaseEntity>> createSync(
    String startDate,
    String endDate,
    bool isMessageSync,
    bool isCallLogSync,
  );
  Future<CallResult<BaseEntity>> updateHistory(
    int synLogId,
    int callLogsStatus,
    int messagesStatus,
  );
}

base class SyncDataRepositoryImpl implements SyncDataRepository {
  final SyncDataService syncDataService;
  final SessionPref sessionPref;

  SyncDataRepositoryImpl({
    required this.syncDataService,
    required this.sessionPref,
  });

  @override
  Future<CallResult<BaseEntity>> syncData({
    List<Map<String, dynamic>>? messages,
    List<Map<String, dynamic>>? calllogs,
  }) async {
    CallResult<BaseEntity> response = await syncDataService.syncData(
      messagesData: messages,
      callLogsData: calllogs,
    );
    if (response is Success<BaseEntity>) {
      final result = response.data;
      if (result.isSuccess) {
        return Success(result);
      } else {
        return Failure(response.data.message);
      }
    }
    return response;
  }

  @override
  Future<CallResult<BaseEntity>> syncCallLogs(
    String syncLogId,
    List<Map<String, dynamic>>? calllogs,
  ) async {
    CallResult<BaseEntity> response = await syncDataService.syncCallLogs(
      syncId: syncLogId,
      callLogsData: calllogs,
    );
    if (response is Success<BaseEntity>) {
      final result = response.data;
      if (result.isSuccess) {
        return Success(result);
      } else {
        return Failure(response.data.message);
      }
    }
    return response;
  }

  @override
  Future<CallResult<SyncHistoryEntity>> getHistory(int page) async {
    CallResult<SyncHistoryEntity> response = await syncDataService.getHistory(
      page,
    );
    if (response is Success<SyncHistoryEntity>) {}
    return response;
  }

  @override
  Future<CallResult<BaseEntity>> updateHistory(
    int syncLogId,
    int callLogsStatus,
    int messageStatus,
  ) async {
    CallResult<BaseEntity> response = await syncDataService.updateHistory(
      syncLogId,
      callLogsStatus,
      messageStatus,
    );
    if (response is Success<BaseEntity>) {}
    return response;
  }

  @override
  Future<CallResult<BaseEntity>> createSync(
    String startDate,
    String endDate,
    bool isMessageSync,
    bool isCallLogSync,
  ) async {
    CallResult<BaseEntity> response = await syncDataService.createSync(
      startDate,
      endDate,
      isMessageSync,
      isCallLogSync,
    );
    if (response is Success<BaseEntity>) {}
    return response;
  }
}
