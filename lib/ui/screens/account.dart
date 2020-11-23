import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/User/repository/AwsAuth.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/utils/SharedPreferences.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDoctor = false;
  final _formKey = GlobalKey<FormState>();
  UserData userRegister = new UserData();
  TextEditingController repeatedPasswordController = new TextEditingController();
  Style style = new Style();
  UserBloc userBloc;
  AwsAuth awsAuth = new AwsAuth();
  TextEditingController confirmationCodeController = new TextEditingController();
  SharedPref _sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {

    return accountWidget();
  }

  Widget accountWidget(){
    userBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: SharedAppBar.getAppBar(false),
      bottomNavigationBar: SharedAppBar.getBottonBar(context, 0),
      body: ListView(
        children: [
          Center(
              child: Form(
                key: _formKey,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                    ),
                                    textFormFieldFactory(
                                        'Nombre *', userRegister.nameController,
                                        'nombre', 'Nombre *',
                                        'Ingrese su nombre'),
                                    textFormFieldFactory(
                                        'Apellido *',
                                        userRegister.lastNameController,
                                        'apellido', 'Apellido *',
                                        'Ingrese su apellido'),
                                    textFormFieldFactory(
                                        'Ciudad *', userRegister.cityController,
                                        'ciudad', 'Ciudad *',
                                        'Ingrese su ciudad'),
                                    textFormFieldFactory(
                                        'País *',
                                        userRegister.countryController, 'país',
                                        'País *', 'Ingrese su país'),
                                    textFormFieldFactory(
                                        'E.P.S. *', userRegister.EPSController,
                                        'E.P.S.', 'E.P.S. *',
                                        'Ingrese su E.P.S.'),
                                    textFormFieldNumericFactory(
                                        'Peso *', userRegister.weightController,
                                        'peso', 'Peso *', 'Ingrese su peso'),
                                    textFormFieldNumericFactory(
                                        'Estatura *',
                                        userRegister.heightController,
                                        'estatura', 'Estatura *',
                                        'Debe ingresar su estatura'),
                                    textFormFieldNumericFactory(
                                        'Edad *', userRegister.ageController,
                                        'edad', 'Edad *', 'Ingrese su edad'),
                                    textFormFieldEmailFactory(
                                        'Correo *',
                                        userRegister.emailController, 'correo',
                                        'Correo *', 'Ingrese su correo'),
                                    textFormFieldPasswordValidatorFactory(
                                        'Contraseña *',
                                        userRegister.passwordController,
                                        'contraseña', 'Contraseña *'),
                                    textFormFieldRepeatedWidgetPasswordFactory(
                                        'Repita su contraseña *',
                                        userRegister.passwordController,
                                        repeatedPasswordController,
                                        'contraseña', 'Contraseña *'),
                                    RaisedButton(
                                        textColor: Colors.white,
                                        color: style.ButtonColor,
                                        child: Text("Enviar dato"),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              userBloc.signUp(userRegister);
                                            });
                                          }
                                        })
                                  ])))
                    ]
                ),
              )
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //print(_sharedPref.getprefStringValue("email"));
    awsAuth.getCurrentUser();
  }
}


