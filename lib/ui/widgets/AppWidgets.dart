import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/screens/publication_screen.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:flutter_app/utils/SharedPreferences.dart';

class SharedAppBar {
  static getAppBar(isAutomaticallyImplyLeading) {
    Style style = new Style();
    return AppBar(
      automaticallyImplyLeading: isAutomaticallyImplyLeading,
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

  static getBottonBar(context){
    Style style = new Style();
    return CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: style.ButtonColor,
        height: 40,
        items: <Widget>[
          Icon(Icons.account_circle, color: Colors.white, semanticLabel:"Mi cuenta",size: 20),
          Icon(Icons.list, color: Colors.white,size: 20),
          Icon(Icons.exit_to_app, color: Colors.white, size: 20),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
            /*  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => myAccount()));*/
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PublicationScreen()));
              break;
            case 2:
              popupLogout(context);
              break;
          }
         /* setState(() {
            // _page = index;
          });*/
        }
    );
  }
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}



