

class Functions {
  static bool validatePasswordStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateRepeatedPassword(String pass1, String pass2) {
    bool same = false;
    pass1 == pass2 ? same = true : null;
    return same;
  }
}