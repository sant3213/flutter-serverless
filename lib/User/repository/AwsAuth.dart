import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/User/model/UserLogin.dart';
import 'package:flutter_app/utils/SharedPreferences.dart';
import '../../amplifyconfiguration.dart';

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
    } catch (e) {
      print(e);
    }
  }
/*
  void _configureAmplify() async {

    auth = AmplifyAuthCognito();
    amplify.addPlugin(authPlugins: [auth]);
    var isSignedIn = false;

    await amplify.configure(amplifyconfig);
    try {
      isSignedIn = await _isSignedIn();
    } on AuthError catch(e) {
      print("User is not signed in.");
    }

    setState(() {
      _isAmplifyConfigured = true;
      displayState = isSignedIn ? "SIGNED_IN" : "SHOW_SIGN_IN";
      authState = isSignedIn ? "User already signed in" : "User not signed in";
    });
    auth.events.listenToAuth((hubEvent) {
      switch(hubEvent["eventName"]) {
        case "SIGNED_IN": {
          setState(() {
            hubEvent = "SIGNED_IN";
          });
          print("HUB: USER IS SIGNED IN");
        }
        break;
        case "SIGNED_OUT": {
          setState(() {
            hubEvent = "SIGNED_OUT";
          });
          print("HUB: USER IS SIGNED OUT");
        }
        break;
        case "SESSION_EXPIRED": {
          setState(() {
            hubEvent = "SESSION_EXPIRED";
          });
          print("HUB: USER SESSION HAS EXPIRED");
        }
        break;
        default: {
          print("CONFIGURATION EVENT");
        }
      }
    });
  }*/

  void recordEvent() async {
    AnalyticsEvent event = AnalyticsEvent("test");
    event.properties.addBoolProperty("boolKey", true);
    event.properties.addDoubleProperty("doubleKey", 10.0);
    event.properties.addIntProperty("intKey", 10);
    event.properties.addStringProperty("stringKey", "stringValue");
    Amplify.Analytics.recordEvent(event: event);
  }

  Future<String> signUp(UserData userData) async {
    Map<String, dynamic> userAttributes =  {'email':userData.emailController.text};
    var result = await Amplify.Auth.signUp(
        username: userData.emailController.text,
        password: userData.passwordController.text,
        options: CognitoSignUpOptions(userAttributes: userAttributes));
    if (result.isSignUpComplete) {
      print('Sign up complete');
    }
    return 'Sign up error';
  }

  Future<String> signUpConfirmation(String code, UserData userData) async {
    var signUpConfirmResult = await Amplify.Auth.confirmSignUp(
        username: userData.emailController.text,
        confirmationCode: code);
    if(signUpConfirmResult.isSignUpComplete) {
      print('Sign up confirmed');
    }
    }

  Future<void> resendSignUpCode(String userName) async {
    await Amplify.Auth.resendSignUpCode(username: userName);
  }

  Future<bool> signIn(UserLogin userLogin) async {
    Map<String, dynamic> clientMetadata = {'email': userLogin.emailController.text};//emailController.text};


      var result = await Amplify.Auth.signIn(
          username: userLogin.emailController.text,
          password: userLogin.passwordController.text);

      if (result.isSignedIn) {
        _sharedPref.setPrefs("isLogguedIn", true);
       return true;
      } else {
        _sharedPref.setPrefs("isLogguedIn", false);
        return false;
      }
    return false;
  }

  Future<void> logout() async {
    var result = await Amplify.Auth.signOut();
  }

  Future<void> forgotPassword(String userName, String pass, String code) async {
    var resulte = await Amplify.Auth.confirmPassword(username: userName, newPassword: pass, confirmationCode: code)
        .then((value) => print(value));
  }

  Future<void> sendForgotPassCode(String userName) async {
    await Amplify.Auth.resetPassword(username: userName);
  }
}