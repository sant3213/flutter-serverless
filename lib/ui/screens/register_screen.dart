import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
      appBar: SharedAppBar.getAppBar(),
    bottomNavigationBar: CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: style.ButtonColor,
      height: 40,
      items: <Widget>[
        Icon(Icons.account_circle, color: Colors.white,size: 20),
        Icon(Icons.list, color: Colors.white,size: 20),
        Icon(Icons.compare_arrows, color: Colors.white, size: 20),
      ],
        onTap: (index) {
          setState(() {
            // _page = index;
          });
        }
    ),
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
                        children: <Widget>[
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
                          ]
                        ),
                          TextFormFieldFactory.getTextFormFieldStyleValidator(
                              'Nombre *', userRegister.nameController, 'nombre', 'Nombre *', 'Ingrese su nombre'),
                          TextFormFieldFactory.getTextFormFieldStyleValidator(
                              'Apellido *', userRegister.lastNameController, 'apellido', 'Apellido *', 'Ingrese su apellido'),
                          TextFormFieldFactory.getTextFormFieldStyleValidator(
                              'Ciudad *', userRegister.cityController, 'ciudad', 'Ciudad *', 'Ingrese su ciudad'),
                          TextFormFieldFactory.getTextFormFieldStyleValidator(
                              'País *', userRegister.countryController, 'país', 'País *', 'Ingrese su país'),
                          TextFormFieldFactory.getTextFormFieldStyleValidator(
                              'E.P.S. *', userRegister.EPSController, 'E.P.S.', 'E.P.S. *', 'Ingrese su E.P.S.'),
                          TextFormFieldNumericFactory.getTextFormFieldNumericFactory(
                              'Peso *', userRegister.weightController, 'peso', 'Peso *', 'Ingrese su peso'),
                          TextFormFieldNumericFactory.getTextFormFieldNumericFactory(
                              'Estatura *', userRegister.heightController, 'estatura', 'Estatura *', 'Debe ingresar su estatura'),
                          TextFormFieldNumericFactory.getTextFormFieldNumericFactory(
                              'Edad *', userRegister.ageController, 'edad', 'Edad *', 'Ingrese su edad'),
                          TextFormFieldFactory.getTextFormFieldStyleValidator(
                              'Correo *', userRegister.emailController, 'correo', 'Correo *', 'Ingrese su correo'),
                          TextFormFieldPasswordFactory.getTextFormFieldPasswordValidator(
                              'Contraseña *', userRegister.passwordController, 'contraseña', 'Contraseña *'),
                          TextFormFieldRepeatedPasswordFactory.getTextFormFieldPasswordValidator(
                              'Repita su contraseña *', userRegister.passwordController, repeatedPasswordController, 'contraseña', 'Contraseña *'),
                          RaisedButton(
                              textColor: Colors.white,
                              color: style.ButtonColor,
                              child: Text("Enviar dato"),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    userBloc.signUp(userRegister);
                                  });
                                  _displayDialog(context);
                                }
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
                child: new Text('Submit'),
                onPressed: () {
                  userBloc.signUpConfirmation(confirmationCodeController.text, userRegister);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              )
            ],
          );
        });
  }
}
 /* retrieveInformation(){
    userRegister.name = userRegister.nameController.text;
    userRegister.lastName = userRegister.lastNameController.text;
    userRegister.age = userRegister.ageController.text;
    userRegister.city = userRegister.cityController.text;
    userRegister.country = userRegister.countryController.text;
    userRegister.weight = userRegister.weightController.text;
    userRegister.height = userRegister.heightController.text;
    userRegister.EPS = userRegister.EPSController.text;
    userRegister.profession = userRegister.professionController.text;
    userRegister.email = userRegister.emailController.text;
    userRegister.password = userRegister.passwordController.text;
    return userRegister;
  }*/

