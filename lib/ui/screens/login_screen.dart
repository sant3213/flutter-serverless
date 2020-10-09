import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/model/UserLogin.dart';
import 'package:flutter_app/ui/screens/register_screen.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserBloc userBloc;
  UserLogin user = UserLogin();
  Style style = new Style();
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return loginUI();
  }

  Widget loginUI(){
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
                          textFormFieldFactory('Usuario', user.emailController, 'usuario', 'Usuario *', 'Ingrese su usuario'
                          ),
                          textFormFieldPasswordFactory('Contraseña', user.passwordController,  'Contraseña *', 'Ingrese su contraseña'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(200.0, 5, 1.0,10),
                            child: new GestureDetector(
                              onTap: (){
                                //Navigator.push(context, route);
                              },
                              child:  Text('Olvidé mi contraseña', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,),textAlign: TextAlign.right),
                            ),
                          ),
                      ButtonTheme(
                        minWidth: 300.0,
                        height: 40.0,
                        child:
                          RaisedButton(
                            textColor: Colors.white,
                            color: style.ButtonColor,
                            child: Text('Entrar'),
                            onPressed: () {
                              userBloc.signIn(user);
                            },
                          ),
                      ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          new Text('Usuario nuevo?', style: TextStyle(fontSize: 10),),
                          new GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen()));
                            },
                            child:  Text('Registrarme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,),textAlign: TextAlign.right),
                          ),
          ]
          )
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
}
