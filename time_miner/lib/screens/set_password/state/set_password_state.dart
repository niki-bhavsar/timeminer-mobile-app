sealed class SetPasswordState {}

class SetPasswordInitialState extends SetPasswordState {}

class SetPasswordLoadingState extends SetPasswordState {}

class SetPasswordSuccessState extends SetPasswordState {
  final String message;

  SetPasswordSuccessState({required this.message});
}

class SetPasswordErrorState extends SetPasswordState {
  final String error;
  final int code;

  SetPasswordErrorState({required this.error, required this.code});
}
