class Validators {
  static String? email(String? text, {String? emptyError, String? invalidError}) {
    if (text == null || text.trim().isEmpty) {
      return emptyError ?? "Email is required";
    }
    final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
    if (!emailRegex.hasMatch(text.trim())) {
      return invalidError ?? "Invalid email address";
    }
    return null;
  }

  static String? password(String? text, {String? emptyError, int minLength = 6}) {
    if (text == null || text.isEmpty) {
      return emptyError ?? "Password is required";
    }
    if (text.length < minLength) {
      return "Password must be at least $minLength characters";
    }
    return null;
  }

  static String? firmNameValidator(String? text, {String? emptyError}) {
    if (text == null || text.trim().isEmpty) {
      return emptyError ?? "Firm Name is required";
    }
    return null;
  }

  static String? confirmPasswordValidator(
    String? text,
    String? password, {
    String? emptyError,
    String? missmatchPasswordError,
  }) {
    if (text == null || text.isEmpty) {
      return emptyError ?? "Confirm Password is required";
    }
    if (text != password) {
      return missmatchPasswordError ?? "Passwords do not match";
    }
    return null;
  }
}
