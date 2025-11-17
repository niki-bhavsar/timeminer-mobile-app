import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/sync_history_entity.dart';
import 'package:time_miner/data/service/base_service.dart';
import 'package:time_miner/data/service/model/call_result.dart';

class SyncDataService extends BaseService {
  Future<CallResult<BaseEntity>> syncData({
    required List<Map<String, dynamic>>? messagesData,
    required List<Map<String, dynamic>>? callLogsData,
  }) {
    final uri = toApiUri("data/sync");
    final params = <String, dynamic>{};
    if (messagesData != null) {
      params["message"] = messagesData;
    }
    if (callLogsData != null) {
      params["call_logs"] = callLogsData;
    }

    return safePostApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> syncCallLogs({
    required String syncId,
    required List<Map<String, dynamic>>? callLogsData,
  }) {
    final uri = toApiUri("calls/sync");
    final params = <String, dynamic>{};
    params["sync_log_id"] = syncId;
    if (callLogsData != null) {
      params["call_logs"] = callLogsData;
    }

    return safePostApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> syncMessages({
    required String syncId,
    required List<Map<String, dynamic>>? messagesData,
  }) {
    final uri = toApiUri("messages/sync");
    final params = <String, dynamic>{};
    params["sync_log_id"] = syncId;
    if (messagesData != null) {
      params["messages"] = messagesData;
    }

    return safePostApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }

  Future<CallResult<SyncHistoryEntity>> getHistory(int page) {
    final uri = toApiUri("sync/history").replace(queryParameters: {
      'page':page.toString()
    });
    return safeGetApiCall<SyncHistoryEntity>(
      uri: uri,
      jsonParser: syncHistoryEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> updateHistory(
    int syncId,
    int callLogsStatus,
    int messageStatus,
  ) {
    final uri = toApiUri("sync/status");
    final params = <String, dynamic>{};
    params["sync_log_id"] = syncId;
    params["calls_status"] = callLogsStatus;
    params["messages_status"] = messageStatus;
    return safePutApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }

  Future<CallResult<BaseEntity>> createSync(
    String startDate,
    String endDate,
    bool syncMsgLogs,
    bool syncCallLogs,
  ) {
    final uri = toApiUri("sync");
    final params = <String, dynamic>{};
    params["start_date"] = startDate;
    params["end_date"] = endDate;
    params["sync_messages"] = syncMsgLogs;
    params["sync_calls"] = syncCallLogs;

    return safePostApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }
}
