import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/ui/Functions.dart';
import 'package:flutter_app/ui/screens/login_screen.dart';
import 'package:flutter_app/utils/SharedPreferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

Widget textFormFieldFactory(String title, TextEditingController controller, String reference, String hintTxt, String errorTxt){
  return new TextFormField(
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.grey,
      labelText: title,
      hintText: hintTxt,
      //errorText: errorTxt,
      contentPadding: EdgeInsets.all(8.0),
    ),
    validator: (input) =>
    input.isEmpty ? 'Debe ingresar ' + reference : null,
  );
}

Widget textFormFieldEmailFactory(String title, TextEditingController controller, String reference, String hintTxt, String errorTxt){
  return new TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.grey,
      labelText: title,
      hintText: hintTxt,
      //errorText: errorTxt,
      contentPadding: EdgeInsets.all(8.0),
    ),
    validator: (value) => EmailValidator.validate(value) ? null: "Por favor ingrese un email válido",
  );
}


Widget textFormFieldPasswordValidatorFactory(String title, TextEditingController controller, String hintTxt, String errorTxt){
  return new TextFormField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
        labelText: title,
        hintText: hintTxt,
        //errorText: errorTxt,
        contentPadding: EdgeInsets.all(8.0),
        labelStyle: TextStyle(fontSize: 14)
    ),
    validator: (value)=> Functions.validatePasswordStructure(value)  ? null: "Por favor ingrese una contraseña válida",
  );

}

Widget textFormFieldPasswordFactory(String title, TextEditingController controller, String reference, String hintTxt, String errorTxt){
  return new TextFormField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
        labelText: title,
        hintText: hintTxt,
        //errorText: errorTxt,
        contentPadding: EdgeInsets.all(8.0),
        labelStyle: TextStyle(fontSize: 14)
    ),
    validator: (input) =>
    input.isEmpty ? 'Debe ingresar ' + reference : null,
  );

}

Widget textFormFieldRepeatedWidgetPasswordFactory(String title, TextEditingController password1, TextEditingController controller, String hintTxt, String errorTxt){
  return new TextFormField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      labelText: title,
      hintText: hintTxt,
      //errorText: errorTxt,
      contentPadding: EdgeInsets.all(8.0),
    ),
    validator: (value)=> Functions.validateRepeatedPassword(password1.text, value)  ? null: "Las contraseñas no coinciden",
  );
}

Widget textFormFieldNumericFactory(String title, TextEditingController controller, String reference, String hintTxt, String errorTxt){
  return new TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: title,
      hintText: hintTxt,
      //errorText: errorTxt,
      contentPadding: EdgeInsets.all(8.0),
    ),
    validator: (input) =>
    input.isEmpty ? 'Debe ingresar ' + reference : null,
  );
}

Future<Widget> popupLogout(BuildContext context) async {
  UserBloc userBloc;
  SharedPref _sharedPref = SharedPref();
  userBloc = BlocProvider.of(context);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Estás seguro que deseas cerrar sesión?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Si'),
              onPressed: () {
                _sharedPref.setBoolPrefs("isLogguedIn", false);
                userBloc.logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
            ),
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future<Widget> popUpMsg(BuildContext context, String msg) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}


