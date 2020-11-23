import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/repository/AwsAuth.dart';
import 'package:flutter_app/ui/screens/account.dart';
import 'package:flutter_app/ui/screens/login_screen.dart';
import 'package:flutter_app/ui/screens/publication_screen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'User/model/UserLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserLogin user = UserLogin();
  AwsAuth awsAuth = new AwsAuth();
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    awsAuth.configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
   // userBloc = BlocProvider.of(context);
    return BlocProvider(
        child: MaterialApp(
           // home:LoginScreen(),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginScreen(),
            '/publications': (context) => PublicationScreen(),
            '/account': (context) => AccountScreen()
          },
        ),
        bloc: UserBloc()
    );
  }
}