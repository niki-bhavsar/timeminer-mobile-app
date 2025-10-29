import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'package:time_miner/data/repository/auth_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/screens/forgot_password/state/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController emailTextController = TextEditingController();

  final AuthRepository authRepository;

  ForgotPasswordCubit({required this.authRepository}) : super(ForgotPasswordInitialState());

  void handleForgotPasswordClickEvent() async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(ForgotPasswordLoadingState());
      CallResult<LoginEntity> response = await authRepository.login(
        username: emailTextController.text.trim(),
        password: "",
      );
      // Temporary success state without API call
      emit(ForgotPasswordSuccessState(message: "response.data.message"));
      return;

      // if (response is Failure<LoginEntity>) {
      //   emit(LoginErrorState(error: response.cause, code: response.code));
      // } else if (response is Success<LoginEntity>) {
      //   emit(LoginSuccessState(message: response.data.message));
      // }
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
