class Validators {
  static bool isValidPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    return cleaned.length == 10;
  }

  static bool isValidOtp(String otp) {
    final cleaned = otp.replaceAll(RegExp(r'\D'), '');
    return cleaned.length == 6;
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
