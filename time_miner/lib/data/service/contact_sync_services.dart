import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/service/base_service.dart';
import 'package:time_miner/data/service/model/call_result.dart';

class ContactSyncServices extends BaseService {
  Future<CallResult<BaseEntity>> syncContacts({required List<Map<String, dynamic>> contacts}) {
    final uri = toApiUri("sync-contacts");
    final params = <String, dynamic>{};
    params["contacts"] = contacts;
    return safePostApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }
}