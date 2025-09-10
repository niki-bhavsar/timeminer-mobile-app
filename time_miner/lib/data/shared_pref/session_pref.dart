
abstract interface class SessionPref {
  void setLoggedIn(bool loggedIn);

  void setAuthToken(String authToken);

  String getAuthToken();

  void setRepId(String repId);

  String getRepId();

  bool isLoggedIn();

  Future clear();

}
