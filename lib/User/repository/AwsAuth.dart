import 'dart:collection';
import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/User/model/UserLogin.dart';
import 'package:flutter_app/utils/SharedPreferences.dart';
import '../../amplifyconfiguration.dart';
import 'package:http/http.dart' as http;

class AwsAuth {
  bool _amplifyConfigured = false;
  UserData userData = new UserData();
  SharedPref _sharedPref = SharedPref();

  void configureAmplify() async {
    Amplify amplifyInstance = Amplify();
    // Add Pinpoint and Cognito Plugins
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito auth = AmplifyAuthCognito();

    amplifyInstance.addPlugin(authPlugins: [auth]);
    amplifyInstance.addPlugin(analyticsPlugins: [analyticsPlugin]);

    // Configure Amplify
    await amplifyInstance.configure(amplifyconfig);
    try {
      _amplifyConfigured = true;
      print("Amplify working");
    } catch (e) {
      print("Amplify working" + e);
    }
  }

  void recordEvent() async {
    AnalyticsEvent event = AnalyticsEvent("test");
    event.properties.addBoolProperty("boolKey", true);
    event.properties.addDoubleProperty("doubleKey", 10.0);
    event.properties.addIntProperty("intKey", 10);
    event.properties.addStringProperty("stringKey", "stringValue");
    Amplify.Analytics.recordEvent(event: event);
  }

  Future<bool> signUp(UserData userData) async {
    // Map<String, dynamic> userAttributes = userData.toMap(userData);
    Map<String, dynamic> userAttributes = {
      'email': userData.emailController.text
    };
    var result = await Amplify.Auth.signUp(
        username: userData.emailController.text,
        password: userData.passwordController.text,
        options: CognitoSignUpOptions(userAttributes: userAttributes));

    if (result.isSignUpComplete) {
      return true;
    }
    return false;
  }

  Future<bool> signUpConfirmation(String code, UserData userData) async {
    bool response;

    await Amplify.Auth.confirmSignUp(
            username: userData.emailController.text, confirmationCode: code)
        .then((value) =>
            {value.isSignUpComplete ? response = true : response = false});
    if (response) saveUserInformation(userData);
    return response;
  }

  Future<void> resendSignUpCode(String userName) async {
    await Amplify.Auth.resendSignUpCode(username: userName);
  }

  Future<bool> signIn(UserLogin userLogin) async {
    var result;
    await Amplify.Auth.signIn(
            username: userLogin.emailController.text,
            password: userLogin.passwordController.text)
        .then((value) => result = value.isSignedIn)
        .catchError((err) => result = false);
/*
    final resp = await Amplify.Auth.fetchAuthSession(
      options: CognitoSessionOptions(getAWSCredentials: true),
    );

    if (resp.isSignedIn) {
      final sess = resp as CognitoAuthSession;
  print(sess.userPoolTokens.accessToken);
  print(sess.credentials.sessionToken);
      print(sess.userPoolTokens);
    }
*/

    if (result) {
      _sharedPref.setBoolPrefs("isLogguedIn", true);
      _sharedPref.setStringPrefs("email", userLogin.emailController.text);
      return true;
    } else {
      _sharedPref.setBoolPrefs("isLogguedIn", false);
      return false;
    }
  }

  Future<void> logout() async {
    try {
      _sharedPref.setBoolPrefs("isLogguedIn", false);
      await Amplify.Auth.signOut();
    } catch (error) {
      print('error signing out: ' + error);
    }
  }

  Future<void> forgotPassword(String userName, String pass, String code) async {
    var resulte = await Amplify.Auth.confirmPassword(
            username: userName, newPassword: pass, confirmationCode: code)
        .then((value) => print(value));
  }

  Future<void> sendForgotPassCode(String userName) async {
    await Amplify.Auth.resetPassword(username: userName);
  }

  Future<void> getCurrentUser() async {
    await Amplify.Auth.getCurrentUser().then((value) => print(value));
  }

  Future<void> saveUserInformation(UserData userData) {
    http
        .post(
          'https://qe7bahgcj8.execute-api.us-east-1.amazonaws.com/pstStage/save-users',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
          body: jsonEncode(userData.toMap(userData)),
        )
        .then((value) => print("retorno----->" + value.body));
  }
}
