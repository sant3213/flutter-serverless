import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  void setPrefs(String key,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> getprefValue(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}