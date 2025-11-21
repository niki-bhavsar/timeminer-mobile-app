import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/base_entity.dart';
import 'package:time_miner/data/repository/auth_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/screens/dashboard/account_tab/state/account_event.dart';
import 'package:time_miner/screens/dashboard/account_tab/state/account_state.dart';

class AccountBlock extends Bloc<AccountEvent, AccountState> {
  final AuthRepository authRepository;
  final SessionPref sessionPref;

  AccountBlock({required this.authRepository, required this.sessionPref}) : super(SettingInitialState()) {
    on<SettingLogoutClickEvent>(_handleLogoutClickEvent);
     on<FetchUserInfo>(_handleFetchUserInfo);
  }

  void _handleLogoutClickEvent(SettingLogoutClickEvent event, Emitter<AccountState> emit) async {
    emit(SettingLoadingState());

    CallResult<BaseEntity> response = await authRepository.logout();

    if (response is Failure<BaseEntity>) {
      emit(SettingErrorState(
        error: response.cause,
        code: response.code,
      ));
    } else if (response is Success<BaseEntity>) {
      emit(SettingLogoutState(message: response.data.message ));
    }
  }

  void _handleFetchUserInfo(FetchUserInfo event, Emitter<AccountState> emit) async {
     CallResult<BaseEntity> response = await authRepository.getUserDetail();

    if (response is Failure<BaseEntity>) {
      emit(SettingErrorState(
        error: response.cause,
        code: response.code,
      ));
    } else if (response is Success<BaseEntity>) {
      emit(SettingUserInfo());
    }
  }
}
