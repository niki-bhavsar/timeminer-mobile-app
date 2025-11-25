import 'package:flutter/cupertino.dart';
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
    required String email,
    required String password,
    String? firmId,
  }) async {
    CallResult<LoginEntity> response = await authService.login(
      email,
      password,
      firmId,
    );

    if (response is Success<LoginEntity>) {
      final loginResponse = response.data;
      if (loginResponse.isLoginSuccess) {
        sessionPref.setAuthToken(loginResponse.token ?? '');
        sessionPref.setLoggedIn(true);
        sessionPref.setFirmCode(loginResponse.user?.firmCode.toString() ?? '');
        sessionPref.setSignUpEmail(loginResponse.user?.email ?? '');
        sessionPref.setSignUpUserName(loginResponse.user?.name ?? '');
        sessionPref.setUserProfile(loginResponse.user?.imagePath);
        return Success(loginResponse);
      }
      if (loginResponse.isMultiFirmCase) {
        return FailureWithMultipleFirm(loginResponse);
      }
      return Failure(response.data.message);
    }

    return response;
  }

  @override
  Future<CallResult<BaseEntity>> forgotPassword({
    required String email,
    String? firmId,
  }) async {
    CallResult<BaseEntity> response = await authService.forgotPassword(
      email,
      firmId,
    );
    if (response is Success<BaseEntity>) {
      final result = response.data;

      // Case 3: Success
      if (result.isSuccess) {
        return Success(result);
      }

      // Case 2: Multiple firms
      if (result.hasMultipleAccounts) {
        return FailureWithMultipleFirm(result);
      }

      // Case 1: User not found
      return Failure(response.data.message);
    }
    if (response is Failure<BaseEntity>) {
      return Failure(response.cause);
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
    if (response is Success<BaseEntity>) {
      sessionPref.setLoggedIn(false);
       
    }
    return response;
  }

  @override
  Future<CallResult<BaseEntity>> getUserDetail() async{
    final response = await authService.getUserDetail();
    if (response is Success<BaseEntity>) {
       final loginResponse = response.data.data;
       final userInfo = loginResponse?["user"];
      sessionPref.setUserProfile(userInfo["image_path"]);

      if(userInfo["status"] == false){
        sessionPref.clear();
      }
    }
    return response;
  }
}
