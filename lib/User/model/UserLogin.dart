import 'package:flutter/cupertino.dart';

class UserLogin {
  String _email;
  String _password;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserLogin();

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }
}