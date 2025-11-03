import 'package:time_miner/data/entity/base_entity.dart';

sealed class CallResult<T> {}

class Success<T> extends CallResult<T> {
  T data;

  Success(this.data);
}

class LoginFailure<T> extends CallResult<T> {
  T data;
  LoginFailure(this.data,);
}

class Failure<T> extends CallResult<T> {
  String cause;
  int code;
  BaseEntity? entity;
  T? data;
  ErrorCause? error;

  Failure(this.cause, {this.code = 0, this.entity, this.error, this.data});

  bool isAuthError() => code == 401;
}

class NetworkError<T> extends CallResult<T> {}

enum ErrorCause {
  networkError,
  socketError,
  timeoutError,
  serverError,
  clientError,
  authError,
  unknownError,
}
