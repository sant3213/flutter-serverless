import 'package:flutter/material.dart';
import 'package:flutter_app/ui/styles/Style.dart';

class SharedAppBar {
  static getAppBar() {
    Style style = new Style();
    return AppBar(
        backgroundColor: style.ButtonColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Image.asset(
              'resources/images/heartLogo.png',
              fit: BoxFit.contain,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top:30),
              child: new Text('Healthcare',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontFamily: 'DancingScrip Regular'),),
            )
          ],
        ));
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}



