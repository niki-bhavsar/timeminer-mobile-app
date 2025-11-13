import 'package:time_miner/data/service/base_service.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import '../entity/contacts_entity.dart';
import '../entity/sync_contacts_entity.dart';

class ContactSyncServices extends BaseService {
  Future<CallResult<SyncContactsEntity>> syncContacts({
    required List<Map<String, dynamic>> contacts,
  }) {
    final uri = toApiUri("contacts/sync");
    final params = <String, dynamic>{};
    params["contacts"] = contacts;
    return safePostApiCall<SyncContactsEntity>(
      uri: uri,
      params: params,
      jsonParser: syncContactsEntityFromJson,
    );
  }

  Future<CallResult<ContactsEntity>> getContacts() {
    final uri = toApiUri("contacts", params: {"with_pagination": "0"});
    return safeGetApiCall<ContactsEntity>(
      uri: uri,
      jsonParser: contactsEntityFromJson,
    );
  }
}
