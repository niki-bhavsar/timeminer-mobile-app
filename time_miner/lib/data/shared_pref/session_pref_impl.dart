import 'package:shared_preferences/shared_preferences.dart';

import 'session_pref.dart';

class SessionPrefImpl implements SessionPref {
  static const String _isLoggedIn = 'profile.is_logged_in';
  static const String _webID = 'session.web_id';
  static const String _webName = 'session.web_name';
  static const String _webDBSuffix = 'session.web_db_suffix';
  static const String _webLogoUrl = 'session.web_logo_url';
  static const String _authToken = 'session.auth_token';
  static const String _isAutoCapture = 'session.is_auto_capture';
  static const String _repID = 'session.rep_id';

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
  String getRepId() {
    return prefs.getString(_repID) ?? "";
  }

  @override
  setRepId(String repId) {
    prefs.setString(_repID, repId);
  }

  @override
  Future clear() async {
    await prefs.remove(_isLoggedIn);
    await prefs.remove(_isAutoCapture);
    await prefs.remove(_webID);
    await prefs.remove(_webName);
    await prefs.remove(_webDBSuffix);
    await prefs.remove(_webLogoUrl);
    await prefs.remove(_authToken);
    await prefs.remove(_repID);
    await prefs.reload();
  }
}
