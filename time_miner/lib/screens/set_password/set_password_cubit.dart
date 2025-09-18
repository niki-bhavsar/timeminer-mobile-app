import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:time_miner/data/repository/auth_repository.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/screens/set_password/state/set_password_state.dart';

class SetPasswordCubit extends Cubit<SetPasswordState> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController firmNameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();

  final AuthRepository authRepository;

  SetPasswordCubit({required this.authRepository}) : super(SetPasswordInitialState()) {
    final signUpEmail = GetIt.instance.get<SessionPref>().getSignUpEmail();
    emailTextController.text = signUpEmail;
  }

  void handleSetPasswordClickEvent() async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(SetPasswordLoadingState());
      final email = emailTextController.text.trim();

      // CallResult<LoginEntity> response = await authRepository.login(username: email, password: "");
      // Temporary success state without API call
      emit(SetPasswordSuccessState(message: "response.data.message"));
      return;

      // if (response is Failure<LoginEntity>) {
      //   emit(SetPasswordErrorState(error: response.cause, code: response.code));
      // } else if (response is Success<LoginEntity>) {
      //   emit(SetPasswordSuccessState(message: response.data.message));
      // }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  @override
  Future<void> close() {
    emailTextController.dispose();
    firmNameTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    return super.close();
  }
}
