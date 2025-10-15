import 'package:flutter_bloc/flutter_bloc.dart';

class SyncDataState {
  final bool contacts;
  final bool messages;
  final bool callLogs;
  final bool syncing;
  final String lastSync;

  SyncDataState({
    this.contacts = true,
    this.messages = false,
    this.callLogs = true,
    this.syncing = false,
    this.lastSync = '',
  });

  SyncDataState copyWith({
    bool? contacts,
    bool? messages,
    bool? callLogs,
    bool? syncing,
    String? lastSync,
  }) {
    return SyncDataState(
      contacts: contacts ?? this.contacts,
      messages: messages ?? this.messages,
      callLogs: callLogs ?? this.callLogs,
      syncing: syncing ?? this.syncing,
      lastSync: lastSync ?? this.lastSync,
    );
  }
}

class SyncDataCubit extends Cubit<SyncDataState> {
  SyncDataCubit() : super(SyncDataState());

  void toggleContacts(bool value) => emit(state.copyWith(contacts: value));
  void toggleMessages(bool value) => emit(state.copyWith(messages: value));
  void toggleCallLogs(bool value) => emit(state.copyWith(callLogs: value));

  Future<void> syncAll() async {
    emit(state.copyWith(syncing: true));
    // TODO: Replace with your API sync logic
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      syncing: false,
      lastSync: 'Oct 5, 5:20 PM', // Replace with DateFormat if needed
    ));
  }
}