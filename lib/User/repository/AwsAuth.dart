import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/User/model/UserLogin.dart';
import '../../amplifyconfiguration.dart';

class AwsAuth {
  bool _amplifyConfigured = false;
  UserData userData = new UserData();
  void configureAmplify() async {
    Amplify amplifyInstance = Amplify();
    // Add Pinpoint and Cognito Plugins
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    amplifyInstance.addPlugin(authPlugins: [authPlugin]);
    amplifyInstance.addPlugin(analyticsPlugins: [analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    await amplifyInstance.configure(amplifyconfig);
    try {
        _amplifyConfigured = true;
       // print("Esta confirgurado--------------------------");
    } catch (e) {
      print(e);
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
    var resultConf = await Amplify.Auth.confirmSignUp(
        username: userData.emailController.text,
        confirmationCode: code);
    if(resultConf.isSignUpComplete) {
      print('Sign up confirmed');
    }
    }

  Future<String> signIn(UserLogin userLogin) async {
    Map<String, dynamic> clientMetadata = {'email': userLogin.emailController.text};//emailController.text};

    var result = await Amplify.Auth.signIn(
        username: userLogin.emailController.text,
        password: userLogin.passwordController.text);
    if (result.isSignedIn) {
      print('Sign up complete');
    }
    return 'Sign up error';
  }

  Future<void> logout(UserLogin userLogin) async {
    var result = await Amplify.Auth.signOut();
  }
}