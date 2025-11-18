import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'package:time_miner/data/repository/auth_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/screens/login/state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitialState());

  void handleLoginClickEvent(String? firmId) async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(LoginLoadingState());
      CallResult<LoginEntity> response = await authRepository.login(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
        firmId: firmId,
      );
      if (response is Success<LoginEntity>) {
        emit(LoginSuccessState(message: response.data.message, isFirstTimeContactSynced: response.data.data?.user?.isFirstTimeContactSynced ?? false));
      }
      if (response is FailureWithMultipleFirm<LoginEntity>) {
        emit(
          LoginMultipleFirmState(
            multiFirrms: response.data.data?.multifirms ?? [],
            message: response.data.message,
          ),
        );
      }
      if(response is Failure<LoginEntity>){
        emit(LoginErrorState(error: response.cause, code: response.code));
      } 
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  @override
  Future<void> close() {
    emailTextController.dispose();
    passwordTextController.dispose();

    return super.close();
  }
}
