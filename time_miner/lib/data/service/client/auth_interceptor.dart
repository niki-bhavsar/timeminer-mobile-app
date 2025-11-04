import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../../shared_pref/session_pref.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Logger.root.info('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers['Accept'] = 'application/json';

    final sessionPref = GetIt.instance.get<SessionPref>();
    if (sessionPref.isLoggedIn()) {
      options.headers['Authorization'] = "Bearer ${sessionPref.getAuthToken()}";
      options.headers['X-Firm-Code'] = sessionPref.getFirmCode();
    }

    if (kDebugMode) {
      options.headers.forEach((key, value) {
        Logger.root.info('HEADERS[$key] => $value');
      });

      if (options.data != null) Logger.root.info('BODY => ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.root.info('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    Logger.root.info('RESPONSE => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Logger.root.info('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    Logger.root.info('ERROR 123  => ${err.response?.data}');
    super.onError(err, handler);
  }
}
