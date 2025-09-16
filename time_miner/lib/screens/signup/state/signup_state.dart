sealed class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final String message;

  SignupSuccessState({required this.message});
}

class SignupInvitationLinkSuccessState extends SignupState {
  final String message;

  SignupInvitationLinkSuccessState({required this.message});
}

class SignupErrorState extends SignupState {
  final String error;
  final int code;

  SignupErrorState({required this.error, required this.code});
}
