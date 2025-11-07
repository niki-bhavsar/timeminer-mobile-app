import 'dart:convert';

ContactsEntity contactsEntityFromJson(String str) =>
    ContactsEntity.fromJson(json.decode(str));

class ContactsEntity {
  final String message;
  final bool success;
  final List<ContactItem> contactItems;

  ContactsEntity({
    required this.message,
    required this.success,
    required this.contactItems,
  });

  factory ContactsEntity.fromJson(Map<String, dynamic> json) => ContactsEntity(
        message: json["message"],
        success: json["success"],
        contactItems: json["data"]["contacts"]["items"] == null
            ? []
            : List<ContactItem>.from(
                json["data"]["contacts"]["items"].map((x) => ContactItem.fromJson(x))),
      );
}

class ContactItem {
  int? id;
  String? name;
  String? email;
  bool? mineStatus;
  String? createdAt;
  String? updatedAt;
  List<String>? phoneNumbers;

  ContactItem({
    this.id,
    this.name,
    this.email,
    this.mineStatus,
    this.createdAt,
    this.updatedAt,
    this.phoneNumbers

  });

  factory ContactItem.fromJson(Map<String, dynamic> json) => ContactItem(
        id: json["id"],
        name: json["name"],
    email: json["email"],
    mineStatus: json["mine_status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    phoneNumbers: json["phone_numbers"],
      );

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       "id": hospitalId ?? "",
  //       "nickname": nickName ?? "",
  //     };
}
