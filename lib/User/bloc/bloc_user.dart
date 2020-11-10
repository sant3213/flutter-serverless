import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/User/model/UserLogin.dart';
import 'package:flutter_app/User/repository/AwsAuth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc{

//final _auth_repository = AuthRepository();
AwsAuth awsAuth = new AwsAuth();

Future<String> signUp(UserData userLogin){
  return awsAuth.signUp(userLogin);
}

Future<bool> signIn(UserLogin userLogin){
  return awsAuth.signIn(userLogin);
}

Future<String> signUpConfirmation(String code, UserData userData ){
  return awsAuth.signUpConfirmation(code, userData);
}

Future<void> resendConfirmationCodeSignup(String userName){
  return awsAuth.resendSignUpCode(userName);
}

Future<void> forgotPassword(String email, String pass, String code){
  return awsAuth.forgotPassword(email, pass, code);
}

Future<void> sendForgotPassCode(String email){
  return awsAuth.sendForgotPassCode(email);
}

Future<void> logout(){
  return awsAuth.logout();
}

  @override
  void dispose() {

  }
}