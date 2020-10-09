import 'package:flutter/cupertino.dart';

class UserData {

  String _name;
  String _lastName;
  String _age;
  String _city;
  String _country;
  String _EPS;
  String _weight;
  String _height;
  String _profession;
  String _email;
  String _password;
  List _diseases;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController EPSController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Map<String, dynamic> toMap(UserData userData) {
    return {
     'name': userData.nameController.text,
     'lastName':userData.lastNameController.text,
     'age': userData.ageController.text,
     'city': userData.cityController.text,
     'country': userData.countryController.text,
     'EPS': userData.EPSController.text,
     'weight': userData.weightController.text,
     'height': userData.heightController.text,
     'profession': userData.professionController.text,
     'email': userData.emailController.text,
    };
  }
  UserData();

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get age => _age;

  set age(String value) {
    _age = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get EPS => _EPS;

  set EPS(String value) {
    _EPS = value;
  }

  String get weight => _weight;

  set weight(String value) {
    _weight = value;
  }

  String get height => _height;

  set height(String value) {
    _height = value;
  }

  String get profession => _profession;

  set profession(String value) {
    _profession = value;
  }

  List get diseases => _diseases;

  set diseases(List value) {
    _diseases = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }
}