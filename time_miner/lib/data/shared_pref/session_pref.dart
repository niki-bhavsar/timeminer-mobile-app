abstract interface class SessionPref {
  void setLoggedIn(bool loggedIn);

  void setAuthToken(String authToken);

  String getAuthToken();

  void setSignUpEmail(String email);

  String getSignUpEmail();

  void setSignUpUserName(String userName);

  String getSignUpUserName();

  void setUserProfile(String? profileUrl);

  String? getUserProfile();

  void setFirmCode(String firmCode);

  String getFirmCode();

  

  bool isLoggedIn();

  Future clear();
}
