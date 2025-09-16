import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/login_entity.dart';
import 'package:time_miner/data/repository/auth_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/screens/signup/state/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController emailTextController = TextEditingController();

  final AuthRepository authRepository;

  SignupCubit({required this.authRepository}) : super(SignupInitialState());

  void handleSignupClickEvent() async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(SignupLoadingState());
      final email = emailTextController.text.trim();

      CallResult<LoginEntity> response = await authRepository.login(username: email, password: "");
      //TODO: Temporary success state without API call

      emit(SignupSuccessState(message: "response.data.message"));
      return;

      if (response is Failure<LoginEntity>) {
        emit(SignupErrorState(error: response.cause, code: response.code));
      } else if (response is Success<LoginEntity>) {
        emit(SignupSuccessState(message: response.data.message));
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  void handleSendInvitationClickEvent() async {
    emit(SignupLoadingState());
    // final email = emailTextController.text.trim();
    // CallResult<LoginEntity> response = await authRepository.login(username: "email", password: "");

    //TODO: Temporary success state without API call
    emit(SignupInvitationLinkSuccessState(message: "response.data.message"));
    return;

    // if (response is Failure<LoginEntity>) {
    //   emit(SignupErrorState(error: response.cause, code: response.code));
    // } else if (response is Success<LoginEntity>) {
    //   emit(SignupSuccessState(message: response.data.message));
    // }
  }

  @override
  Future<void> close() {
    emailTextController.dispose();
    return super.close();
  }
}
