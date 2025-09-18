sealed class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccessState({required this.message});
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String error;
  final int code;

  ForgotPasswordErrorState({required this.error, required this.code});
}
