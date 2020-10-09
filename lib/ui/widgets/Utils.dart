import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Functions.dart';
import 'package:flutter_app/ui/screens/register_screen.dart';

class TextFormFieldFactory {
  static getTextFormFieldStyleValidator(String title, TextEditingController controller, String reference, String hintTxt, String errorTxt) {
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
}

class TextFormFieldPasswordFactory {
  static getTextFormFieldPasswordValidator(String title, TextEditingController controller, String hintTxt, String errorTxt) {
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
}

class TextFormFieldRepeatedPasswordFactory {
  static getTextFormFieldPasswordValidator(String title, TextEditingController password1, TextEditingController controller, String hintTxt, String errorTxt) {
    return new TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintText: hintTxt,
        //errorText: errorTxt,
        contentPadding: EdgeInsets.all(8.0),
      ),
      validator: (value)=> Functions.validateRepeatedPassword(password1.text, value)  ? null: "Las contraseñas no coinciden",
    );
  }
}

class TextFormFieldNumericFactory {
  static getTextFormFieldNumericFactory(String title, TextEditingController controller, String reference, String hintTxt, String errorTxt) {
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
}

class TextFormFieldDialogFactory {
  static getTextFormFieldDialogStyleValidator(String title, TextEditingController controller, String reference, String hintTxt, String errorTxt) {
    return new TextFormField(
      maxLength: 2,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey,
        labelText: title,
        hintText: hintTxt,
        //errorText: errorTxt,
        contentPadding: EdgeInsets.all(2.0),
      ),
      validator: (input) =>
      input.isEmpty ? 'Debe ingresar ' + reference : null,
    );
  }
}

