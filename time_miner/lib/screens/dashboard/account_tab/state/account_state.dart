sealed class AccountState {}

class SettingInitialState extends AccountState {}

class SettingLoadingState extends AccountState {}

class SettingUserInfo extends AccountState {
  
}

class SettingLogoutState extends AccountState {
  final String? message;

  SettingLogoutState({required this.message});
}

class SettingErrorState extends AccountState {
  final String error;
  final int code;

  SettingErrorState({required this.error, required this.code});
}
