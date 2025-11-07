import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/service/contact_sync_services.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import '../entity/contacts_entity.dart';

abstract interface class ContactRepository {
  Future<CallResult<BaseEntity>> syncContacts({required List<Map<String, dynamic>> contacts});
  Future<CallResult<ContactsEntity>> getContacts();
}

base class ContactRepositoryImpl implements ContactRepository {
  final ContactSyncServices contactService;
  final SessionPref sessionPref;

  ContactRepositoryImpl({required this.contactService, required this.sessionPref});

  @override
  Future<CallResult<BaseEntity>> syncContacts({required List<Map<String, dynamic>> contacts}) async{

    CallResult<BaseEntity> response = await contactService.syncContacts(contacts: contacts);
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

  @override
  Future<CallResult<ContactsEntity>> getContacts() async{

    CallResult<ContactsEntity> response = await contactService.getContacts();
    if (response is Success<ContactsEntity>) {
      final result = response;
      print("RESPNSE::::$response");
      // if(result.isSuccess){
      //   return Success(result);
      // }
      // else{
      //   return Failure(response.data.message);
      // }

    }
    return response;
  }
}
