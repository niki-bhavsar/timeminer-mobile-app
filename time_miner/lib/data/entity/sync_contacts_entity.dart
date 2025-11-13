import 'dart:convert';

SyncContactsEntity syncContactsEntityFromJson(String str) =>
    SyncContactsEntity.fromJson(json.decode(str));

class SyncContactsEntity {
  final String message;
  final bool isSuccess;
  final DateTime timestamp;
  final SyncContactsData? data;

  SyncContactsEntity({
    required this.message,
    required this.isSuccess,
    required this.timestamp,
    this.data,
  });

  factory SyncContactsEntity.fromJson(Map<String, dynamic> json) =>
      SyncContactsEntity(
        message: json["message"] ?? "",
        timestamp: json["timestamp"] != null
            ? DateTime.parse(json["timestamp"])
            : DateTime.now(),
        isSuccess: json["success"] ?? false,
        data: json["data"] != null
            ? SyncContactsData.fromJson(json["data"])
            : null,
      );
}

class SyncContactsData {
  final int created;
  final int updated;
  final List<FailedContact> failed;
  final int totalProcessed;

  SyncContactsData({
    required this.created,
    required this.updated,
    required this.failed,
    required this.totalProcessed,
  });

  factory SyncContactsData.fromJson(Map<String, dynamic> json) =>
      SyncContactsData(
        created: json["created"] ?? 0,
        updated: json["updated"] ?? 0,
        failed: json["failed"] != null
            ? List<FailedContact>.from(
                json["failed"].map((x) => FailedContact.fromJson(x)),
              )
            : [],
        totalProcessed: json["total_processed"] ?? 0,
      );
}

class FailedContact {
  final int index;
  final String name;
  final List<String> phoneNumbers;
  final String? email;
  final String error;

  FailedContact({
    required this.index,
    required this.name,
    required this.phoneNumbers,
    this.email,
    required this.error,
  });

  factory FailedContact.fromJson(Map<String, dynamic> json) => FailedContact(
    index: json["index"] ?? 0,
    name: json["name"] ?? "",
    phoneNumbers: json["phone_numbers"] != null
        ? List<String>.from(json["phone_numbers"])
        : [],
    email: json["email"],
    error: json["error"] ?? "",
  );
}
