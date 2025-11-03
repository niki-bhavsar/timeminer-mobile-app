import 'package:time_miner/data/entity/login_entity.dart';

sealed class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String message;
  LoginSuccessState({required this.message});
}
class LoginMultipleFirmState extends LoginState {
  final List<MultiFirmUser> multiFirrms;
  final String message;

   LoginMultipleFirmState({
    required this.multiFirrms,
    required this.message,
  });
}
class LoginErrorState extends LoginState {
  final String error;
  final int code;

  LoginErrorState({required this.error, required this.code});
}
