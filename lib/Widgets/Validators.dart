class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'

    );

    if (!passwordRegex.hasMatch(value)) {
      return "Password must contain:\n"
          "- 8 characters\n"
          "- 1 uppercase\n"
          "- 1 lowercase\n"
          "- 1 number";
    }

    return null;
  }
}
