class TextUtil {
  static bool isBlank(String? arg) {
    return arg == null || arg.isEmpty || arg.trim().isEmpty;
  }

  static bool isValidEmail(String? arg) {
    if (arg == null) return false;
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(arg);
  }

  static bool isValidUrl(String? arg) {
    final userInput = arg?.trim();
    if (Uri.parse(userInput!).isAbsolute) {
      return true;
    } else {
      return false;
    }
  }
}
