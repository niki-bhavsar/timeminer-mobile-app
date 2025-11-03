// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromJson(jsonString);

import 'dart:convert';

LoginEntity loginEntityFromJson(String str) => LoginEntity.fromJson(json.decode(str));

String loginEntityToJson(LoginEntity data) => json.encode(data.toJson());

class LoginEntity {
    bool success;
    String message;
    UserData data;
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
        data: UserData.fromJson(json["data"]),
        timestamp: DateTime.parse(json["timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "timestamp": timestamp.toIso8601String(),
    };
}

class UserData {
    User user;
    Firm firm;
    String token;
    String tokenType;
    bool? isMultipleAccounts;
    List<MultiFirmUser>? multiFirmUsers;

    UserData({
        required this.user,
        required this.firm,
        required this.token,
        required this.tokenType,
        required this.isMultipleAccounts,
        this.multiFirmUsers,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        user: User.fromJson(json["user"]),
        firm: Firm.fromJson(json["firm"]),
        token: json["token"],
        tokenType: json["token_type"],
        isMultipleAccounts: json["multiple_accounts"] ?? false,
        multiFirmUsers: json["firms"] != null
            ? List<MultiFirmUser>.from(json["firms"].map((x) => MultiFirmUser.fromJson(x)))
            : null,
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "firm": firm.toJson(),
        "token": token,
        "token_type": tokenType,
    };
}

class MultiFirmUser{
    String firmCode;
    String name;

    MultiFirmUser({
        required this.firmCode,
        required this.name,
    });

    factory MultiFirmUser.fromJson(Map<String, dynamic> json) => MultiFirmUser(
        firmCode: json["firm_code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "firm_code": firmCode,
        "name": name,
    };
}

class Firm {
    int firmId;
    String firmCode;
    String name;
    String subscriptionStatus;
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
        subscriptionStatus: json["subscription_status"],
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
    int id;
    String name;
    String email;
    String firmCode;
    bool isSuperUser;
    String imagePath;
    String phone;
    dynamic linkedinUrl;
    dynamic avyoUrl;
    int hourlyRate;
    bool billingInc;
    bool isBilling;
    bool status;
    bool validated;
    bool isProfileUpdated;
    DateTime lastlogin;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.firmCode,
        required this.isSuperUser,
        required this.imagePath,
        required this.phone,
        required this.linkedinUrl,
        required this.avyoUrl,
        required this.hourlyRate,
        required this.billingInc,
        required this.isBilling,
        required this.status,
        required this.validated,
        required this.isProfileUpdated,
        required this.lastlogin,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        firmCode: json["firm_code"],
        isSuperUser: json["is_super_user"],
        imagePath: json["image_path"],
        phone: json["phone"],
        linkedinUrl: json["linkedin_url"],
        avyoUrl: json["avyo_url"],
        hourlyRate: json["hourly_rate"],
        billingInc: json["billing_inc"],
        isBilling: json["is_billing"],
        status: json["status"],
        validated: json["validated"],
        isProfileUpdated: json["is_profile_updated"],
        lastlogin: DateTime.parse(json["lastlogin"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "firm_code": firmCode,
        "is_super_user": isSuperUser,
        "image_path": imagePath,
        "phone": phone,
        "linkedin_url": linkedinUrl,
        "avyo_url": avyoUrl,
        "hourly_rate": hourlyRate,
        "billing_inc": billingInc,
        "is_billing": isBilling,
        "status": status,
        "validated": validated,
        "is_profile_updated": isProfileUpdated,
        "lastlogin": lastlogin.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
