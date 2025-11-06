import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/service/contact_sync_services.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';

abstract interface class ContactRepository {
  Future<CallResult<BaseEntity>> syncContacts({required List<Map<String, dynamic>> contacts});
}

base class ContactRepositoryImpl implements ContactRepository {
  final ContactSyncServices contacService;
  final SessionPref sessionPref;

  ContactRepositoryImpl({required this.contacService, required this.sessionPref});

  @override
  Future<CallResult<BaseEntity>> syncContacts({required List<Map<String, dynamic>> contacts}) async{

    CallResult<BaseEntity> response = await contacService.syncContacts(contacts: contacts);
    if (response is Success<BaseEntity>) {
      final result = response.data;
      if(result.isSuccess){
        return Success(result);
      }
      else{
        return Failure(response.data.message);
      }

    }
    return response;
  }
}