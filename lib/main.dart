import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/repository/AwsAuth.dart';
import 'package:flutter_app/ui/screens/account.dart';
import 'package:flutter_app/ui/screens/login_screen.dart';
import 'package:flutter_app/ui/screens/publication_screen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'User/model/UserLogin.dart';

bool isLogguedIn = false;
String initialRoute;
Future<void>  main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLogguedIn = prefs.getBool("isLogguedIn");

  if (!isLogguedIn) {
    initialRoute = '/';
  } else
    initialRoute = '/publications';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggued;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserLogin user = UserLogin();
  AwsAuth awsAuth = new AwsAuth();
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    if(!isLogguedIn)awsAuth.configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
          initialRoute: initialRoute,
          routes: {
            '/': (context) => LoginScreen(),
            '/publications': (context) => PublicationScreen(),
            '/account': (context) => AccountScreen()
          },
        ),
        bloc: UserBloc());
  }
}
