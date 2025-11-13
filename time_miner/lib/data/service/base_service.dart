import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:time_miner/app/app_env.dart';
import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/service/client/firebase_interceptor.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/utils/app_utils.dart';

import 'client/auth_interceptor.dart';
import 'exception/http_exception.dart';
import 'model/call_result.dart';

class BaseService {
  Dio? dio;

  BaseService() {
    final options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 3),
      responseType: ResponseType.plain,
      receiveDataWhenStatusError: true,
      validateStatus: (status) {
        return status != null && status >= 200 && status < 500;
      }
    );
    dio = Dio(options);
    dio?.interceptors.add(AuthInterceptor());
    // dio?.interceptors.add(FirebaseInterceptor());
  }

  Uri toApiUri(String path, {Map<String, String>? params}) {
    params ??= {};
    return Uri.parse(AppEnv.baseUrl + path).replace(queryParameters: params);
  }

  Future<CallResult<T>> safeMultipartApiCall<T>({
    required Uri uri,
    Map<String, dynamic>? params,
    required Map<String, String> files,
    required T Function(String arg) jsonParser,
    String? contentType = 'application/x-www-form-urlencoded',
  }) async {
    try {
      Logger.root.fine("Request Params: $params");

      Map<String, dynamic> formParam = {};
      params?.forEach((key, value) {
        formParam[key] = value;
      });

      await Future.forEach(files.entries, (entry) async {
        formParam[entry.key] = await MultipartFile.fromFile(entry.value);
      });

      dio?.options.headers['Content-Type'] = contentType;
      Response? response = await dio?.post(uri.toString(), data: FormData.fromMap(formParam));

      _handleResponse(response);

      return Success(jsonParser.call(response?.data.toString() ?? ""));
    } on Exception catch (exception, stacktrace) {
      return _parseError(exception, stacktrace);
    } catch (error, stacktrace) {
      // executed for errors of all types other than Exception
      return _parseError(error, stacktrace);
    }
  }

  Future<CallResult<T>> safePostApiCall<T>({
    required Uri uri,
    required Map<String, dynamic> params,
    required T Function(String arg) jsonParser,
    Map<String, String>? headers,
    String? contentType = 'application/json',
  }) async {
    try {
      Logger.root.fine("Request Params: $params");

      if (headers != null) {
        headers.forEach((key, value) {
          dio?.options.headers[key] = value;
        });
      }

      dio?.options.headers['Content-Type'] = contentType;
      Response? response = await dio?.post(uri.toString(), data: params);
      _handleResponse(response);
      return Success(jsonParser.call(response?.data.toString() ?? ""));
      
    } on Exception catch (exception, stacktrace) {
      debugPrint("exception Data post: ${exception.toString()}");
      return _parseError(exception, stacktrace);
    } catch (error, stacktrace) {
      debugPrint("error Data post: ${error.toString()}");
      // executed for errors of all types other than Exception
      return _parseError(error, stacktrace);
    }
  }

  Future<CallResult<T>> safePutApiCall<T>({
    required Uri uri,
    required Map<String, dynamic> params,
    required T Function(String arg) jsonParser,
    String? contentType = 'application/json',
  }) async {
    try {
      // Logger.root.info("Request Params: $params");
      dio?.options.headers['Content-Type'] = contentType;
      Response? response = await dio?.put(uri.toString(), data: params);
      debugPrint("Response Data: ${response?.data}");

      return Success(jsonParser.call(response?.data.toString() ?? ""));
    } on Exception catch (exception, stacktrace) {
      return _parseError(exception, stacktrace);
    } catch (error, stacktrace) {
      // executed for errors of all types other than Exception
      return _parseError(error, stacktrace);
    }
  }

  Future<CallResult<T>> safeDeleteApiCall<T>({
    required Uri uri,
    required Map<String, dynamic> params,
    required T Function(String arg) jsonParser,
    Map<String, String>? headers,
    String? contentType = 'application/x-www-form-urlencoded',
  }) async {
    try {
      Logger.root.info("Request Params: $params");
      if (headers != null) {
        headers.forEach((key, value) {
          dio?.options.headers[key] = value;
        });
      }
      Response? response = await dio?.delete(uri.toString(), data: params);

      _handleResponse(response);

      return Success(jsonParser.call(response?.data.toString() ?? ""));
    } on Exception catch (exception, stacktrace) {
      return _parseError(exception, stacktrace);
    } catch (error, stacktrace) {
      // executed for errors of all types other than Exception
      return _parseError(error, stacktrace);
    }
  }

  Future<CallResult<T>> safeGetApiCall<T>({
    required Uri uri,
    required T Function(String arg) jsonParser,
    Map<String, String>? headers,
  }) async {
    try {
      dio?.options.headers = null;
      if (headers != null) {
        headers.forEach((key, value) {
          dio?.options.headers[key] = value;
        });
      }
      Response? response = await dio?.get(uri.toString());

      _handleResponse(response);

      return Success(jsonParser.call(response?.data.toString() ?? ""));
    } on Exception catch (exception, stacktrace) {
      return _parseError(exception, stacktrace);
    } catch (error, stacktrace) {
      // executed for errors of all types other than Exception
      return _parseError(error, stacktrace);
    }
  }

  Future<CallResult<T>> _parseError<T>(dynamic error, dynamic stacktrace) async {
    Logger.root.info("Error: $error \nStacktrace: $stacktrace");

    if (!(await AppUtils.isConnected())) {
      return Failure("It seems you're not online. Try Again.", error: ErrorCause.networkError);
    } else if (error is SocketException) {
      return Failure(
        "Failed to connect to server. Please try again later.",
        error: ErrorCause.socketError,
      );
    } else if (error is TimeoutException) {
      return Failure("Connection timeout. Please try again.", error: ErrorCause.timeoutError);
    } else if (error is HttpException) {
      return Failure(
        error.cause,
        code: error.code,
        entity: error.entity,
        error: ErrorCause.timeoutError,
      );
    } else if (error is DioException) {
      // Handle connection errors (DNS lookup failures, network unreachable, etc.)
      if (error.type == DioExceptionType.connectionError || 
          error.type == DioExceptionType.connectionTimeout ||
          error.error is SocketException) {
        return Failure(
          "Failed to connect to server. Please check your internet connection and try again.",
          error: ErrorCause.socketError,
        );
      }
      // Handle timeout errors
      if (error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return Failure("Connection timeout. Please try again.", error: ErrorCause.timeoutError);
      }
      // Handle other DioException types (response errors, etc.)
      try {
        HttpException? exception = _handleResponse(error.response);
        if (exception != null) {
          return Failure(
            exception.cause,
            code: exception.code,
            entity: exception.entity,
            error: ErrorCause.timeoutError,
          );
        }
        return _genericFailure(error.response);
      } catch (e) {
        return _genericFailure(error.response);
      }
    } else if (error is Exception) {
      return Failure(error.toString(), error: ErrorCause.unknownError);
    } else {
      return Failure(error.toString(), error: ErrorCause.unknownError);
    }
  }

  HttpException? _handleResponse(Response? response) {
    const defaultMsg = "Something went wrong!";
    final statusCode = response?.statusCode ?? 0;
    debugPrint("Response Status Code***: $statusCode");
    if (statusCode == 500) {
      return HttpException(cause: defaultMsg, code: statusCode, error: ErrorCause.serverError);
    } else if (statusCode == 401) {
      GetIt.instance.get<SessionPref>().clear();

      return HttpException(
        cause: "You're logged out. Please login again.",
        code: statusCode,
        error: ErrorCause.authError,
      );
    } else if (statusCode == 200) {
      final baseEntity = baseEntityFromJson(response?.data);
      if (!baseEntity.isSuccess) {
        throw HttpException(
          cause: baseEntity.message.replaceAll("\\n", "\n"),
          code: statusCode,
          entity: baseEntity,
          error: ErrorCause.clientError,
        );
      }
    }
    
     else if (statusCode != 200) {
      final baseEntity = baseEntityFromJson(response?.data);
      return HttpException(
        cause: baseEntity.message.replaceAll("\\n", "\n"),
        code: statusCode,
        entity: baseEntity,
        error: ErrorCause.clientError,
      );
    }
    return null;
  }

  CallResult<T> _genericFailure<T>(Response? response) => Failure(
    response?.statusMessage ?? "Something went wrong!",
    code: response?.statusCode ?? 0,
    error: ErrorCause.unknownError,
  );
}
