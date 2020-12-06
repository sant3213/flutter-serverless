import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/model/UserLogin.dart';
import 'package:flutter_app/ui/screens/forgotPasswordScreen.dart';
import 'package:flutter_app/ui/screens/publication_screen.dart';
import 'package:flutter_app/ui/screens/register_screen.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserBloc userBloc;
  UserLogin user = UserLogin();
  Style style = new Style();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _isLoading ? spinnerLoading()
        : loginUI();
  }

  Widget loginUI() {
    return Scaffold(
        body: ListView(padding: EdgeInsets.all(10.0), children: <Widget>[
      Center(
          child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              // wrap your Column in Expanded
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 180, 20.0, 30),
                child: Column(
                  children: [
                    Image.asset(
                      'resources/images/heartLogo.png',
                      height: 70,
                      width: 70,
                    ),
                    textFormFieldEmailFactory('Usuario', user.emailController,
                        'usuario', 'Usuario *', 'Ingrese su usuario', true),
                    textFormFieldPasswordFactory(
                        'Contraseña',
                        user.passwordController,
                        'su contraseña',
                        'Contraseña *',
                        'Ingrese su contraseña'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(200.0, 5, 1.0, 10),
                      child: new GestureDetector(
                        onTap: () {
                          _displayDialog(context);
                        },
                        child: Text('Olvidé mi contraseña',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.right),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 300.0,
                      height: 40.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: style.ButtonColor,
                          child: Text('Entrar'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              SignInValidate();
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'Usuario nuevo?',
                              style: TextStyle(fontSize: 15),
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text('Registrarme',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.right),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ))
    ]));
  }

  SignInValidate() async {
    setState(() {
      _isLoading = true;
    });
    bool isSignedIn = await userBloc.signIn(user);

    if (isSignedIn) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PublicationScreen()));
    } else {
      setFalse();
      popUpMsg(context, 'Usuario o contraseña inválida');
    }
  }

  Widget spinnerLoading() {
    return Container(
      color: style.BackgroundColor,
      child: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
          duration: Duration(seconds: 1),
          controller: setFalse(),
        ),
      ),
    );
  }

  setFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa tu correo electrónico'),
            content: TextField(
              controller: emailController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(hintText: "Ingresa tu correo electrónico"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Enviar'),
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    userBloc.sendForgotPassCode(emailController.text);
                    emailController.clear();
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                  }
                },
              ),
            ],
          );
        });
  }
}
