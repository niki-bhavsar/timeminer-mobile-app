import 'dart:convert';

BaseEntity baseEntityFromJson(String str) => BaseEntity.fromJson(json.decode(str));

class BaseEntity {
  final String message;
  final bool isSuccess;
  final DateTime? timestamp;
  final Map<String, dynamic>? data;

  BaseEntity({required this.message, this.isSuccess = false, this.timestamp, this.data});

  factory BaseEntity.fromJson(Map<String, dynamic> json) => BaseEntity(
    message: json["message"] ?? "",
    timestamp: json["timestamp"] != null ? DateTime.parse(json["timestamp"]) : null,
    isSuccess: json["success"] ?? false,
    data: json["data"] != null ? Map<String, dynamic>.from(json["data"]) : null,
  );

  factory BaseEntity.dummy() => BaseEntity(message: "");

  @override
  String toString() {
    return 'BaseEntity{message: $message, data: $data}';
  }
}
