import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'package:time_miner/data/repository/auth_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/screens/forgot_password/state/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController emailTextController = TextEditingController();

  final AuthRepository authRepository;

  ForgotPasswordCubit({required this.authRepository})
    : super(ForgotPasswordInitialState());

  void handleForgotPasswordClickEvent(String? firmId) async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(ForgotPasswordLoadingState());
      CallResult<BaseEntity> response = await authRepository.forgotPassword(
        email: emailTextController.text.trim(),
        firmId: firmId,
      );

      if (response is FailureWithMultipleFirm<BaseEntity>) {
        final firmsList = (response.data.data?["firms"] as List<dynamic>? ?? [])
            .map((e) => FirmInfo.fromJson(e))
            .toList();
        emit(
          ForgotPasswordMultipleFirmState(
            multiFirrms: firmsList,
            message: response.data.message,
          ),
        );
      } else if (response is Success<BaseEntity>) {
        emit(ForgotPasswordSuccessState(message: response.data.message));
      }
      if (response is Failure<BaseEntity>) {
        emit(
          ForgotPasswordErrorState(error: response.cause, code: response.code),
        );
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  @override
  Future<void> close() {
    emailTextController.dispose();
    return super.close();
  }
}
