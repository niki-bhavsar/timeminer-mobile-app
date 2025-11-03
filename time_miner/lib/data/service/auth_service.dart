import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'base_service.dart';
import 'model/call_result.dart';

class AuthService extends BaseService {
  Future<CallResult<LoginEntity>> login(String username, String password, String? firmId) {
    final params = <String, String>{};
    params["email"] = username;
    params["password"] = password;
    if (firmId != null) {
      params["firm_code"] = firmId;
    }

    final uri = toApiUri("login");
    return safePostApiCall<LoginEntity>(uri: uri, jsonParser: loginEntityFromJson, params: params);
  }

  Future<CallResult<BaseEntity>> checkAppVersion() {
    final params = <String, String>{};
    final uri = toApiUri("checkappversion");
    return safePostApiCall<BaseEntity>(uri: uri, jsonParser: baseEntityFromJson, params: params);
  }

  Future<CallResult<BaseEntity>> logout() {
    final uri = toApiUri("logout");
    return safeDeleteApiCall(uri: uri, params: {}, jsonParser: baseEntityFromJson);
  }
}
