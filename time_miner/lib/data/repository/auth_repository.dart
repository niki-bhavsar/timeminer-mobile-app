import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'package:time_miner/data/service/model/call_result.dart';

abstract interface class AuthRepository {
  bool isLoggedIn();

  Future<CallResult<LoginEntity>> login({required String username, required String password});

  Future<CallResult<BaseEntity>> checkAppVersion();

  Future<CallResult<BaseEntity>> logout();
}
