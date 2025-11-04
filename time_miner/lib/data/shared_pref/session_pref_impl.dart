import 'package:shared_preferences/shared_preferences.dart';

import 'session_pref.dart';

class SessionPrefImpl implements SessionPref {
  static const String _isLoggedIn = 'profile.is_logged_in';
  static const String _userProfilePath = 'session.user_profile_path';
  static const String _authToken = 'session.auth_token';
  static const String _firmCode = 'session.firm_code';
  static const String _signUpEmail = 'session.sign_up_email';
  static const String _userName = 'session.user_name';

  final SharedPreferences prefs;

  SessionPrefImpl(this.prefs);

  @override
  setLoggedIn(bool loggedIn) {
    prefs.setBool(_isLoggedIn, loggedIn);
  }

  @override
  bool isLoggedIn() => prefs.getBool(_isLoggedIn) ?? false;

  @override
  String getAuthToken() {
    return prefs.getString(_authToken) ?? "";
  }

  @override
  setAuthToken(String authToken) {
    prefs.setString(_authToken, authToken);
  }

  @override
  String getFirmCode() {
    return prefs.getString(_firmCode) ?? "";
  }

  @override
  setFirmCode(String firmCode) {
    prefs.setString(_firmCode, firmCode);
  }

  @override
  String getSignUpEmail() {
    return prefs.getString(_signUpEmail) ?? "";
  }

  @override
  setSignUpEmail(String email) {
    prefs.setString(_signUpEmail, email);
  }
  @override
  String getSignUpUserName() {
    return prefs.getString(_userName) ?? "";
  }

  @override
  setSignUpUserName(String userName) {
    prefs.setString(_userName, userName);
  }
  
  @override String? getUserProfile() {
    return prefs.getString(_userProfilePath);
  }
  @override
  setUserProfile(String? profileUrl) {
    if (profileUrl != null) {
      prefs.setString(_userProfilePath, profileUrl);
    } else {
      prefs.remove(_userProfilePath);
    }
  }
  
  @override
  Future clear() async {
    await prefs.remove(_isLoggedIn);
    await prefs.remove(_userProfilePath);
    await prefs.remove(_authToken);
    await prefs.remove(_firmCode);
    await prefs.remove(_signUpEmail);
    await prefs.reload();
  }
}
