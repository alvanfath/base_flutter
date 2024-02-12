class Validator {
  static const _emailRegExpString =
      r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
      r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
  static final _emailRegex = RegExp(_emailRegExpString, caseSensitive: false);
  static bool isValidPassword(String password) => password.length >= 6;

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);

  static bool isValidUserName(String userName) => userName.length >= 3;

  static bool isValidNumber(int num) => num > 0;

  static bool isValidPhoneNumber(String num) => num.length >= 10;

  static bool isLessThan18YearsFromNow(DateTime date) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(date);
    final ageInYears = difference.inDays ~/ 365;

    return ageInYears < 18;
  }

  static bool isValidLowerCase(String password) {
    return password.contains(RegExp(r'[a-z]'));
  }

  static bool isValidUpperCase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  static bool isValidPasswordNumber(String password) {
    return password.contains(RegExp(r'\d'));
  }

  static bool isValidLengthPassWord(String password) {
    return password.length > 7;
  }

  static bool isValidPasswordRegis(String password) {
    return isValidLowerCase(password) &&
        isValidLengthPassWord(password) &&
        isValidUpperCase(password) &&
        isValidPasswordNumber(password);
  }
}
