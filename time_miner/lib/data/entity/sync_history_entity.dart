// To parse this JSON data, do
//
//     final syncHistoryEntity = syncHistoryEntityFromJson(jsonString);

import 'dart:convert';

SyncHistoryEntity syncHistoryEntityFromJson(String str) => SyncHistoryEntity.fromJson(json.decode(str));

String syncHistoryEntityToJson(SyncHistoryEntity data) => json.encode(data.toJson());

class SyncHistoryEntity {
    bool success;
    String message;
    SyncHistoryData data;
    DateTime timestamp;

    SyncHistoryEntity({
        required this.success,
        required this.message,
        required this.data,
        required this.timestamp,
    });

    factory SyncHistoryEntity.fromJson(Map<String, dynamic> json) => SyncHistoryEntity(
        success: json["success"],
        message: json["message"],
        data: SyncHistoryData.fromJson(json["data"]),
        timestamp: DateTime.parse(json["timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "timestamp": timestamp.toIso8601String(),
    };
}

class SyncHistoryData {
    SyncHistory syncHistory;

    SyncHistoryData({
        required this.syncHistory,
    });

    factory SyncHistoryData.fromJson(Map<String, dynamic> json) => SyncHistoryData(
        syncHistory: SyncHistory.fromJson(json["sync_history"]),
    );

    Map<String, dynamic> toJson() => {
        "sync_history": syncHistory.toJson(),
    };
}

class SyncHistory {
    List<SyncHistoryItem> items;
    Pagination pagination;

    SyncHistory({
        required this.items,
        required this.pagination,
    });

    factory SyncHistory.fromJson(Map<String, dynamic> json) => SyncHistory(
        items: List<SyncHistoryItem>.from(json["items"].map((x) => SyncHistoryItem.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class SyncHistoryItem {
    int syncLogId;
    DateTime startDate;
    DateTime endDate;
    bool syncCalls;
    bool syncMessages;
    int status;
    int callsStatus;
    int messagesStatus;
    int callsTotalGiven;
    int callsTotalCreated;
    int callsTotalDuplicates;
    int messagesTotalGiven;
    int messagesTotalCreated;
    int messagesTotalDuplicates;
    DateTime createdAt;
    DateTime updatedAt;

    SyncHistoryItem({
        required this.syncLogId,
        required this.startDate,
        required this.endDate,
        required this.syncCalls,
        required this.syncMessages,
        required this.status,
        required this.callsStatus,
        required this.messagesStatus,
        required this.callsTotalGiven,
        required this.callsTotalCreated,
        required this.callsTotalDuplicates,
        required this.messagesTotalGiven,
        required this.messagesTotalCreated,
        required this.messagesTotalDuplicates,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SyncHistoryItem.fromJson(Map<String, dynamic> json) => SyncHistoryItem(
        syncLogId: json["sync_log_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        syncCalls: json["sync_calls"],
        syncMessages: json["sync_messages"],
        status: json["status"],
        callsStatus: json["calls_status"],
        messagesStatus: json["messages_status"],
        callsTotalGiven: json["calls_total_given"],
        callsTotalCreated: json["calls_total_created"],
        callsTotalDuplicates: json["calls_total_duplicates"],
        messagesTotalGiven: json["messages_total_given"],
        messagesTotalCreated: json["messages_total_created"],
        messagesTotalDuplicates: json["messages_total_duplicates"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "sync_log_id": syncLogId,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "sync_calls": syncCalls,
        "sync_messages": syncMessages,
        "status": status,
        "calls_status": callsStatus,
        "messages_status": messagesStatus,
        "calls_total_given": callsTotalGiven,
        "calls_total_created": callsTotalCreated,
        "calls_total_duplicates": callsTotalDuplicates,
        "messages_total_given": messagesTotalGiven,
        "messages_total_created": messagesTotalCreated,
        "messages_total_duplicates": messagesTotalDuplicates,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Pagination {
    int currentPage;
    int perPage;
    int total;
    int lastPage;
    int? from;
    int? to;
    bool hasMorePages;

    Pagination({
        required this.currentPage,
        required this.perPage,
        required this.total,
        required this.lastPage,
        required this.from,
        required this.to,
        required this.hasMorePages,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        total: json["total"],
        lastPage: json["last_page"],
        from: json["from"] ?? 0,
        to: json["to"] ?? 0,
        hasMorePages: json["has_more_pages"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "per_page": perPage,
        "total": total,
        "last_page": lastPage,
        "from": from,
        "to": to,
        "has_more_pages": hasMorePages,
    };
}
