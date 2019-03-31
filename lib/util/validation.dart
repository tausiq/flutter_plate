class Validation {
  static bool isNameValid(String value) {
    if (value.isEmpty) return false;
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    return nameExp.hasMatch(value);
  }

  bool isEmailValid(String email) {
    String emailValidationRule =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailValidationRule);
    return regExp.hasMatch(email);
  }

  static bool isPhoneValid(String phone) {
    String phoneValidationRule = r'^\+?[0-9]{3}-?[0-9]{6,12}$';
    RegExp regExp = new RegExp(phoneValidationRule);
    return regExp.hasMatch(phone);
  }

  static bool isPasswordValid(String value) {
    return value.isNotEmpty;
  }

  String isValidPhone(String countryCode, String value) {
    return isPhoneValid(value) ? null : 'Please enter valid phone number';
  }

  String isIdValid(String value) {
    if (value.isEmpty) return 'Please enter id';
    return null;
  }

  String isValidEmail(String value) {
    return isEmailValid(value) ? null : 'Please enter valid email';
  }

  String isFilled(String value) {
    return value == null || value.isEmpty ? 'This field is required' : null;
  }

  String isPinValid(String value) {
    if (value.isEmpty) return 'Please enter pin';
    if (value.length < 4) return 'Please enter at least 4 digits pin';
    return null;
  }

  String nameValid(String value) {
    if (value.isEmpty) return 'Please enter name';
    final RegExp nameExp = RegExp(r'^[A-za-z .-]+$');
    return nameExp.hasMatch(value) ? null : 'Please enter valid name';
  }
}
