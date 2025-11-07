import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/service/base_service.dart';
import 'package:time_miner/data/service/model/call_result.dart';

import '../entity/contacts_entity.dart';

class ContactSyncServices extends BaseService {
  Future<CallResult<BaseEntity>> syncContacts({required List<Map<String, dynamic>> contacts}) {
    final uri = toApiUri("contacts/sync");
    final params = <String, dynamic>{};
    params["contacts"] = contacts;
    return safePostApiCall<BaseEntity>(
      uri: uri,
      params: params,
      jsonParser: baseEntityFromJson,
    );
  }

  Future<CallResult<ContactsEntity>> getContacts() {
    final uri = toApiUri("contacts");
    return safeGetApiCall<ContactsEntity>(
      uri: uri,
      jsonParser: contactsEntityFromJson,
    );
  }
}