import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/User/repository/AwsAuth.dart';
import 'package:flutter_app/User/repository/UserRepository.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final String email;

  const AccountScreen({Key key, this.email}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDoctor = false;
  SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  UserData userRegister = new UserData();
  TextEditingController repeatedPasswordController = new TextEditingController();
  Style style = new Style();
  UserBloc userBloc;
  AwsAuth awsAuth = new AwsAuth();
  UserRepository UserRepo = new UserRepository();
  TextEditingController confirmationCodeController = new TextEditingController();
  UserData user = new UserData();
  bool _isloading = true;
  @override
  Widget build(BuildContext context) {
    return _isloading ? spinnerLoading()
        : accountWidget(context);
  }

  Widget accountWidget(context) {
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
                                        'Correo *', 'Ingrese su correo', false),

                                    ListTile(

                                      title: Row(
                                        children: [
                                         Expanded(child:

                                            Padding(
                                              padding: EdgeInsets.only(right: 15),
                                              child: RaisedButton(
                                                  textColor: Colors.white,
                                                  color: style.ButtonColor,
                                                  child: Text("Actualizar datos"),
                                                  onPressed: () {
                                                    UserRepo.updateUserInf(userRegister);
                                                  }
                                              ),
                                            )),

                                          Expanded(child:
                                          Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: RaisedButton(
                                                textColor: Colors.white,
                                                color: Colors.red,
                                                child: Text("Cancelar"),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil('/publications', (Route<dynamic> route) => false);

                                                }
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
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
  void initState()  {
    getUserInformation();
    super.initState();
  }

  getUserInformation(){
    var email;
    SharedPreferences.getInstance().then((SharedPreferences sp) async {
      sharedPreferences = sp;
      email = sharedPreferences.get("email");
      Future <LinkedHashMap<dynamic,dynamic>> userInf;
      userInf = UserRepo.getUserInformation(email);
      await userInf.then((value) =>
      userRegister = UserData.fromJson(value));
      setFalse();
    });
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
      _isloading = false;
    });
  }
}


