class Validators {

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }
  static bool isValidUsername(String username) {
    final usernameRegex = RegExp(r"^[a-zA-Z0-9_]{5,}$");
    return usernameRegex.hasMatch(username);
  }
  static bool isValidPassword(String password) {
    final passwordRegex = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    return passwordRegex.hasMatch(password);
  }
}
