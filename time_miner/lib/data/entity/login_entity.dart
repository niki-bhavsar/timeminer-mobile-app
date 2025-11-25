// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromJson(jsonString);

import 'dart:convert';

import 'package:time_miner/data/entity/base_entity.dart';

LoginEntity loginEntityFromJson(String str) =>
    LoginEntity.fromJson(json.decode(str));

String loginEntityToJson(LoginEntity data) => json.encode(data.toJson());

class LoginEntity {
  bool success;
  String message;
  UserData? data;
  DateTime timestamp;

  LoginEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
    success: json["success"],
    message: json["message"],
    data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "timestamp": timestamp.toIso8601String(),
  };
}

class UserData {
  final bool? multipleAccounts;
  final List<MultiFirmData>? multifirms; // For multi-firm login
  final User? user;
  final Firm? firmDetails;
  final String? token;
  final String? tokenType;

  UserData({
    this.user,
    this.firmDetails,
    this.token,
    this.tokenType,
    this.multipleAccounts,
    this.multifirms,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
    firmDetails: json["firm"] != null ? Firm.fromJson(json["firm"]) : null,
    token: json["token"] ?? '',
    tokenType: json["token_type"] ?? '',
    multipleAccounts: json["multiple_accounts"] ?? false,
    multifirms: json['firms'] != null
        ? (json['firms'] as List).map((i) => MultiFirmData.fromJson(i)).toList()
        : null,
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "firm": firmDetails?.toJson(),
    "token": token,
    "token_type": tokenType,
    "multiple_accounts": multipleAccounts,
    "firms": multifirms,
  };
}

extension LoginEntityX on LoginEntity {
  bool get isLoginSuccess =>
      success && data?.user != null && data?.token != null;
  bool get isMultiFirmCase =>
      !success &&
      data?.multipleAccounts == true &&
      data?.multifirms != null &&
      data!.multifirms!.isNotEmpty;

  bool get isInvalidUser => !success && (data == null || data?.user == null);

  User? get user => data?.user;
  Firm? get firm => data?.firmDetails;
  String? get token => data?.token;
  String? get tokenType => data?.tokenType;

  List<FirmInfo> get multiFirmList {
    if (data?.multifirms == null) return [];
    return data!.multifirms!
        .map((e) => FirmInfo(firmCode: e.firmCode, firmName: e.name))
        .toList();
  }
}

class MultiFirmData {
  String firmCode;
  String name;

  MultiFirmData({required this.firmCode, required this.name});

  factory MultiFirmData.fromJson(Map<String, dynamic> json) =>
      MultiFirmData(firmCode: json["firm_code"], name: json["firm_name"]);

  Map<String, dynamic> toJson() => {"firm_code": firmCode, "firm_name": name};
}

class Firm {
  int firmId;
  String firmCode;
  String? name;
  String? subscriptionStatus;
  bool status;
  bool validated;
  DateTime createdAt;
  DateTime updatedAt;

  Firm({
    required this.firmId,
    required this.firmCode,
    required this.name,
    required this.subscriptionStatus,
    required this.status,
    required this.validated,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Firm.fromJson(Map<String, dynamic> json) => Firm(
    firmId: json["firm_id"],
    firmCode: json["firm_code"],
    name: json["name"],
    subscriptionStatus: json["subscription_status"] ?? "",
    status: json["status"],
    validated: json["validated"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "firm_code": firmCode,
    "name": name,
    "subscription_status": subscriptionStatus,
    "status": status,
    "validated": validated,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  final int id;
  final String? name;
  final String? email;
  final String? firmCode;
  final bool isSuperUser;
  final String? imagePath;
  final String? phone;
  final bool isFirstTimeContactSynced;

  // Optional fields
  final String? linkedinUrl;
  final String? avyoUrl;
  final double? hourlyRate;
  final bool? billingInc;
  final bool? isBilling;
  final bool? status;
  final bool? validated;
  final bool? isProfileUpdated;
  final DateTime? lastLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.firmCode,
    required this.isSuperUser,
    required this.imagePath,
    required this.phone,
    required this.isFirstTimeContactSynced,
    this.linkedinUrl,
    this.avyoUrl,
    this.hourlyRate,
    this.billingInc,
    this.isBilling,
    this.status,
    this.validated,
    this.isProfileUpdated,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    firmCode: json['firm_code'] ?? '',
    isSuperUser: json['is_super_user'] ?? false,
    imagePath: json['image_path'] ?? '',
    phone: json['phone'] ?? '',
    isFirstTimeContactSynced: json['is_firsttime_contact_synced'] ?? false,
    linkedinUrl: json['linkedin_url'],
    avyoUrl: json['avyo_url'],
    hourlyRate: (json['hourly_rate'] != null)
        ? (json['hourly_rate'] as num).toDouble()
        : null,
    billingInc: json['billing_inc'],
    isBilling: json['is_billing'],
    status: json['status'],
    validated: json['validated'],
    isProfileUpdated: json['is_profile_updated'],
    lastLogin: json['lastlogin'] != null
        ? DateTime.tryParse(json['lastlogin'])
        : null,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "firm_code": firmCode,
    "is_super_user": isSuperUser,
    "image_path": imagePath,
    "phone": phone,
    "is_firsttime_contact_synced": isFirstTimeContactSynced,
    "linkedin_url": linkedinUrl,
    "avyo_url": avyoUrl,
    "hourly_rate": hourlyRate,
    "billing_inc": billingInc,
    "is_billing": isBilling,
    "status": status,
    "validated": validated,
    "is_profile_updated": isProfileUpdated,
    "lastlogin": lastLogin?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
