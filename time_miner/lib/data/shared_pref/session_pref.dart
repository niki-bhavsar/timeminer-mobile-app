abstract interface class SessionPref {
  void setLoggedIn(bool loggedIn);

  void setAuthToken(String authToken);

  String getAuthToken();

  void setSignUpEmail(String email);

  String getSignUpEmail();

  void setRepId(String repId);

  String getRepId();

  bool isLoggedIn();

  Future clear();
}
