import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/ui/screens/login_screen.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isDoctor = false;
  final _formKey = GlobalKey<FormState>();
  UserData userRegister = new UserData();
  TextEditingController repeatedPasswordController = new TextEditingController();
  Style style = new Style();
  UserBloc userBloc;
  TextEditingController confirmationCodeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return  Scaffold(
      appBar: SharedAppBar.getAppBar(true),
    body: ListView(
      children: [
        Center(
            child:Form(
              key: _formKey,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                       /* children: <Widget>[
                          new Text('Soy doctor'),
                          Checkbox(
                            value: isDoctor,
                            checkColor: style.BackgroundColor,
                            onChanged: (bool value) {
                              setState(() {
                                isDoctor = value;
                              });
                            },
                          ),
                          ]*/
                        ),
                          textFormFieldFactory(
                              'Nombre *', userRegister.nameController, 'nombre', 'Nombre *', 'Ingrese su nombre'),
                          textFormFieldFactory(
                              'Apellido *', userRegister.lastNameController, 'apellido', 'Apellido *', 'Ingrese su apellido'),
                          textFormFieldFactory(
                              'Ciudad *', userRegister.cityController, 'ciudad', 'Ciudad *', 'Ingrese su ciudad'),
                          textFormFieldFactory(
                              'País *', userRegister.countryController, 'país', 'País *', 'Ingrese su país'),
                          textFormFieldFactory(
                              'E.P.S. *', userRegister.EPSController, 'E.P.S.', 'E.P.S. *', 'Ingrese su E.P.S.'),
                          textFormFieldNumericFactory(
                              'Peso *', userRegister.weightController, 'peso', 'Peso *', 'Ingrese su peso'),
                          textFormFieldNumericFactory(
                              'Estatura *', userRegister.heightController, 'estatura', 'Estatura *', 'Debe ingresar su estatura'),
                          textFormFieldNumericFactory(
                              'Edad *', userRegister.ageController, 'edad', 'Edad *', 'Ingrese su edad'),
                          textFormFieldNumericFactory(
                              'Profesión *', userRegister.professionController, 'profesión', 'Profesión *', 'Ingrese su profesión'),
                          textFormFieldEmailFactory(
                              'Correo *', userRegister.emailController, 'correo', 'Correo *', 'Ingrese su correo'),
                          textFormFieldPasswordValidatorFactory(
                              'Contraseña *', userRegister.passwordController, 'contraseña', 'Contraseña *'),
                          textFormFieldRepeatedWidgetPasswordFactory( 'Repita su contraseña *', userRegister.passwordController, repeatedPasswordController, 'contraseña', 'Contraseña *'),
                          RaisedButton(
                              textColor: Colors.white,
                              color: style.ButtonColor,
                              child: Text("Enviar dato"),
                              onPressed: () {
                                submitRegister();
                              }
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ],
    ),
  );
  }
  submitRegister() async {

    if (_formKey.currentState.validate())
    {
      var signUpResult;

        signUpResult = await userBloc.signUp(userRegister);

      _displayDialog(context);
      if(!signUpResult) popUpMsg(context, 'El registro no fue exitoso');
    }
  }

  bool validatePasswordStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateRepeatedPassword(String pass1, String pass2){
    bool same = false;
    same = identical(pass1, pass2);
    return same;
  }
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa el código que llegó a tu correo'),
            content: TextField(
              controller: confirmationCodeController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Ingresa el código"),
            ),
            actions: <Widget>[

              new FlatButton(
                child: new Text('Reenviar código'),
                onPressed: () {
                    userBloc.resendConfirmationCodeSignup(userRegister.emailController.text);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              new FlatButton(
                child: new Text('Enviar'),
                onPressed: () {
                  userBloc.signUpConfirmation(confirmationCodeController.text, userRegister);
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

