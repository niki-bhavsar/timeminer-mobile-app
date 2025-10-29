import 'package:flutter_bloc/flutter_bloc.dart';

class SyncHistoryItem {
  final String syncDate;
  final bool messages;
  final bool callLogs;

  const SyncHistoryItem({required this.syncDate, required this.messages, required this.callLogs});
}

class SyncDataState {
  final bool messages;
  final bool callLogs;
  final bool syncing;
  final String lastSync;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<SyncHistoryItem> syncHistory;

  SyncDataState({
    this.messages = false,
    this.callLogs = true,
    this.syncing = false,
    this.lastSync = 'Oct 5, 5:20 PM',
    this.startDate,
    this.endDate,
    this.syncHistory = const [
      SyncHistoryItem(syncDate: 'Apr 5, 5:20 PM', messages: false, callLogs: true),
      SyncHistoryItem(syncDate: 'Jan 15, 5:20 PM', messages: true, callLogs: true),
    ],
  });

  SyncDataState copyWith({
    bool? messages,
    bool? callLogs,
    bool? syncing,
    String? lastSync,
    DateTime? startDate,
    DateTime? endDate,
    List<SyncHistoryItem>? syncHistory,
  }) {
    return SyncDataState(
      messages: messages ?? this.messages,
      callLogs: callLogs ?? this.callLogs,
      syncing: syncing ?? this.syncing,
      lastSync: lastSync ?? this.lastSync,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      syncHistory: syncHistory ?? this.syncHistory,
    );
  }
}

class SyncDataCubit extends Cubit<SyncDataState> {
  SyncDataCubit() : super(SyncDataState());

  void toggleMessages(bool value) => emit(state.copyWith(messages: value));
  void toggleCallLogs(bool value) => emit(state.copyWith(callLogs: value));

  void setStartDate(DateTime? date) => emit(state.copyWith(startDate: date));
  void setEndDate(DateTime? date) => emit(state.copyWith(endDate: date));

  Future<void> syncAll() async {
    emit(state.copyWith(syncing: true));
    // TODO: Replace with your API sync logic
    await Future.delayed(const Duration(seconds: 2));

    // Add new sync to history
    final now = DateTime.now();
    final formattedDate = '${_getMonthName(now.month)} ${now.day}, ${_formatTime(now)}';

    final newHistoryItem = SyncHistoryItem(
      syncDate: formattedDate,
      messages: state.messages,
      callLogs: state.callLogs,
    );

    final updatedHistory = [newHistoryItem, ...state.syncHistory];

    emit(state.copyWith(syncing: false, lastSync: formattedDate, syncHistory: updatedHistory));
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
