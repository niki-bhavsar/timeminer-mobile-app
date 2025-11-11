import 'dart:convert';
import 'dart:ffi';

HistoryEntity historyEntityFromJson(String str) =>
    HistoryEntity.fromJson(json.decode(str));

class HistoryEntity {
  final String message;
  final bool success;
  final List<HistoryItem> historyItems;

  HistoryEntity({
    required this.message,
    required this.success,
    required this.historyItems,
  });

  factory HistoryEntity.fromJson(Map<String, dynamic> json) => HistoryEntity(
        message: json["message"],
        success: json["success"],
        historyItems: json["data"]["history"]["items"] == null
            ? []
            : List<HistoryItem>.from(
                json["data"]["history"]["items"].map((x) => HistoryItem.fromJson(x))),
      );
}

class HistoryItem {
  int? id;
  DateTime? syncDate;
  bool? messageIncluded;
  bool? callLogsIncluded;
  

  HistoryItem({
    this.id,
    this.syncDate,
    this.messageIncluded,
    this.callLogsIncluded,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
        id: json["id"],
        syncDate: json["date"],
        messageIncluded: json["date"],
        callLogsIncluded: json["date"],
      );
}
