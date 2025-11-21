import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'base_service.dart';
import 'model/call_result.dart';

class AuthService extends BaseService {
  Future<CallResult<LoginEntity>> login(String email, String password, String? firmId) {
    final params = <String, String>{};
    params["email"] = email;
    params["password"] = password;
    if (firmId != null) {
      params["firm_code"] = firmId;
    }

    final uri = toApiUri("login");
    return safePostApiCall<LoginEntity>(uri: uri, jsonParser: loginEntityFromJson, params: params);
  }

  Future<CallResult<BaseEntity>> forgotPassword(String email, String?  firmId) {
    final params = <String, String>{};
    params["email"] = email;
     if (firmId != null) {
      params["firm_code"] = firmId;
    }
    final uri = toApiUri("forgot-password");
    return safePostApiCall<BaseEntity>(uri: uri, jsonParser: baseEntityFromJson, params: params);
  }

  Future<CallResult<BaseEntity>> checkAppVersion() async {
    final params = <String, String>{};
    final info = await PackageInfo.fromPlatform();
    params["platform"] = Platform.operatingSystem;
    params["current_version"] = info.version;
    final uri = toApiUri("check-update");
    return safePostApiCall<BaseEntity>(uri: uri, jsonParser: baseEntityFromJson, params: params);
  }

  Future<CallResult<BaseEntity>> logout() {
    final uri = toApiUri("logout");
    return safePostApiCall<BaseEntity>(uri: uri, params: {}, jsonParser: baseEntityFromJson);
  }

  Future<CallResult<BaseEntity>> getUserDetail() {
    final uri = toApiUri("me");
    return safeGetApiCall<BaseEntity>(uri: uri, jsonParser: baseEntityFromJson);
  }
}
