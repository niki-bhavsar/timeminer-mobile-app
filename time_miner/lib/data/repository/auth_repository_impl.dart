import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'package:time_miner/data/service/auth_service.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  final SessionPref sessionPref;

  AuthRepositoryImpl({required this.authService, required this.sessionPref});

  @override
  bool isLoggedIn() => sessionPref.isLoggedIn();

  @override
  Future<CallResult<LoginEntity>> login({
    required String username,
    required String password,
     String? firmId,
  }) async {
    CallResult<LoginEntity> response = await authService.login(username, password, firmId);
    sessionPref.setLoggedIn(true);
    
    if (response is Success<LoginEntity>) {
      final user = response.data.data;  
      // if (user) {
        sessionPref.setAuthToken(user?.token ?? "");
        sessionPref.setRepId(user?.user.id.toString() ?? "");
    }
  
    return response;
  }

  @override
  Future<CallResult<BaseEntity>> checkAppVersion() {
    return authService.checkAppVersion();
  }

  @override
  Future<CallResult<BaseEntity>> logout() async {
    final response = await authService.logout();
    sessionPref.setLoggedIn(false);
    if (response is Success<BaseEntity>) {
      sessionPref.setLoggedIn(false);
      //TODO: on distributor remove we have to remove distributor info also
    }
    return response;
  }
}
