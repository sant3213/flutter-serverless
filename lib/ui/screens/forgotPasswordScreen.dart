import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/ui/screens/login_screen.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  UserBloc userBloc;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repeatedPasswordController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  Style style = new Style();
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return forgotPasswordUI();
  }
  Widget forgotPasswordUI(){
    return Scaffold(
        body: ListView(padding: EdgeInsets.all(10.0), children: <Widget>[
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    // wrap your Column in Expanded
                    child: Padding(
                      padding: EdgeInsets.fromLTRB( 20.0, 180, 20.0, 30),
                      child: Column(
                        children: [
                          Image.asset('resources/images/heartLogo.png', height: 70, width: 70,),
                          textFormFieldEmailFactory('Usuario', emailController, 'usuario', 'Usuario *', 'Ingrese su usuario'
                          ),
                          textFormFieldPasswordValidatorFactory('Contraseña', passwordController,  'Contraseña *', 'Ingrese su contraseña'),
                          textFormFieldRepeatedWidgetPasswordFactory( 'Repita su contraseña *', passwordController, repeatedPasswordController, 'contraseña', 'Contraseña *'),
                          textFormFieldPasswordValidatorFactory('Ingresa el código que llegó a tu correo', codeController,  'Código *', 'Ingrese el código que le llegó al correo'),
                          ButtonTheme(
                            minWidth: 300.0,
                            height: 40.0,
                            child:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: style.ButtonColor,
                                child: Text('Enviar'),
                                onPressed: () {
                                  userBloc.forgotPassword(emailController.text, passwordController.text, codeController.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          )
        ])
    );
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
              decoration: InputDecoration(hintText: "Ingresa tu correo electrónico"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Enviar'),
                onPressed: () {
                    if(emailController.text.isNotEmpty) {
                  //   userBloc.sendForgotPassCode(emailController.text);
                  }
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          );
        });
  }
}
