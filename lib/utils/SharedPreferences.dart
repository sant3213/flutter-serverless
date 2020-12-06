import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  void setBoolPrefs(String key,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  void setStringPrefs(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<bool> getprefBoolValue(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  void getprefStringValue(String key) async{
    var result;
    SharedPreferences sharedPreferences;
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      result = sharedPreferences.get("email");
      print(result);
    });
    return result;
  }
}