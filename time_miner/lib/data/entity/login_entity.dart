import 'dart:convert';

LoginEntity loginEntityFromJson(String str) => LoginEntity.fromJson(json.decode(str));

class LoginEntity {
  final String message;
  final LoginUserInfo? loginUserInfo;

  LoginEntity({required this.message, required this.loginUserInfo});

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
    message: json["message"],
    loginUserInfo: json["values"] == null ? null : LoginUserInfo.fromJson(json["values"]),
  );
}

class LoginUserInfo {
  final String repId;
  final String username;
  final String firstName;
  final String lastName;
  final String repGroup;
  final String validated;
  final String repStatus;
  final String incDirectory;
  final String hideSales;
  final String email;
  final String defaultGroupCategory;
  final String authToken;
  final String webId;
  final String webDbSuffix;

  LoginUserInfo({
    required this.repId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.repGroup,
    required this.validated,
    required this.repStatus,
    required this.incDirectory,
    required this.hideSales,
    required this.email,
    required this.defaultGroupCategory,
    required this.authToken,
    required this.webId,
    required this.webDbSuffix,
  });

  factory LoginUserInfo.fromJson(Map<String, dynamic> json) => LoginUserInfo(
    repId: json["rep_id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    repGroup: json["rep_group"],
    validated: json["validated"],
    repStatus: json["rep_status"],
    incDirectory: json["inc_directory"],
    hideSales: json["hide_sales"],
    email: json["email"],
    defaultGroupCategory: json["default_group_category"],
    authToken: json["authtoken"],
    webId: json["webid"],
    webDbSuffix: json["webdbsuffix"],
  );
}
