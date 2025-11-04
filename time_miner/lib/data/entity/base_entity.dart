import 'dart:convert';

BaseEntity baseEntityFromJson(String str) => BaseEntity.fromJson(json.decode(str));

class BaseEntity {
  final String message;
  final bool isSuccess;
  final DateTime timestamp;
  final Map<String, dynamic>? data;

  BaseEntity({required this.message, this.isSuccess = false, required this.timestamp, this.data});

  factory BaseEntity.fromJson(Map<String, dynamic> json) => BaseEntity(
    message: json["message"] ?? "",
    timestamp: json["timestamp"] != null ? DateTime.parse(json["timestamp"]) : DateTime.now(),
    isSuccess: json["success"] ?? false,
    data: json["data"] != null ? Map<String, dynamic>.from(json["data"]) : null,
  );

  factory BaseEntity.dummy() => BaseEntity(message: "", timestamp: DateTime.now());

  @override
  String toString() {
    return 'BaseEntity{message: $message, data: $data, timestamp: $timestamp}';
  }
}

extension BaseEntityX on BaseEntity {
  bool get hasMultipleAccounts =>
      data?["multiple_accounts"] == true && data?["firms"] != null;

  bool get hasUserData => data?["user"] != null;

  List<FirmInfo> get firmList {
    if (data?["firms"] is List) {
      return (data?["firms"] as List)
          .map((e) => FirmInfo.fromJson(e))
          .toList();
    }
    if (data?["firms"] is Map) {
      // In case of map-based response like login
      final map = data?["firms"] as Map<String, dynamic>;
      return map.entries
          .map((e) => FirmInfo(firmCode: e.key, firmName: e.value))
          .toList();
    }
    return [];
  }
}

class FirmInfo {
  final String firmCode;
  final String firmName;

  FirmInfo({
    required this.firmCode,
    required this.firmName,
  });

  factory FirmInfo.fromJson(Map<String, dynamic> json) => FirmInfo(
        firmCode: json["firm_code"] ?? "",
        firmName: json["firm_name"] ?? "",
      );

  @override
  String toString() => '$firmName ($firmCode)';
}



