import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/login_entity.dart';

sealed class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccessState({required this.message});
}
class ForgotPasswordMultipleFirmState extends ForgotPasswordState {
  final List<FirmInfo> multiFirrms;
  final String message;

   ForgotPasswordMultipleFirmState({
    required this.multiFirrms,
    required this.message,
  });
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String error;
  final int code;

  ForgotPasswordErrorState({required this.error, required this.code});
}
