class Validate {
  static String? phoneNumber(String phoneNumber) {
    final RegExp indianPhonePattern =
        RegExp(r'^(\+91[\s-]?)?[0]?(91)?[123456789]\d{9}$');

    if (phoneNumber.isEmpty) {
      return "Enter Phone Number";
    } else if (indianPhonePattern.hasMatch(phoneNumber)) {
      return null;
    } else {
      return 'Invalid phone number.';
    }
  }

  static String? password(String password) {
    final RegExp digitPattern = RegExp(r'[0-9]');

    if (password.isEmpty) {
      return "Enter Password";
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    if (!digitPattern.hasMatch(password)) {
      return 'Password must contain at least one digit.';
    }

    return null;
  }

  static String? otp(String otp) {
    final RegExp digitPattern = RegExp(r'^\d{6}$');

    if (digitPattern.hasMatch(otp)) {
      return null;
    } else if (otp.length < 6) {
      return "Enter 6 digit OTP";
    } else {
      return "Invalid OTP";
    }
  }

  static String? name(
    String name,
  ) {
    final RegExp namePattern = RegExp(r'^[A-Za-z\s]+$');

    if (name.isEmpty) {
      return "Required";
    }

    if (!namePattern.hasMatch(name)) {
      return 'Invalid characters in name. Only letters are allowed.';
    }

    return null;
  }

  static String? validateEmail(String email) {
    final RegExp emailPattern =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (email.isEmpty) {
      return "Required";
    }

    if (!emailPattern.hasMatch(email)) {
      return 'Invalid email format. Example: abc@xyz.com';
    }

    return null;
  }
}
