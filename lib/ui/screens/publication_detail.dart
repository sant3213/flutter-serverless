import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:flutter_app/User/repository/AwsAuth.dart';
import 'package:flutter_app/User/repository/UserRepository.dart';
import 'package:flutter_app/ui/screens/publication_screen.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/utils/SharedPreferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicationDetailScreen extends StatefulWidget {
  final String email;

  const PublicationDetailScreen({Key key, this.email}) : super(key: key);

  @override
  _PublicationDetailScreenState createState() => _PublicationDetailScreenState();
}

class _PublicationDetailScreenState extends State<PublicationDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  Style style = new Style();
  UserBloc userBloc;
  UserRepository UserRepo = new UserRepository();
  @override
  Widget build(BuildContext context) {
    return accountWidget(context);
  }

  Widget accountWidget(context) {
    userBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: SharedAppBar.getAppBar(false),
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
                                    titleText('Título'),
                                    Text('Descripción'),
                                    Text('Comentarios'),
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Expanded(child:

                                          Padding(
                                            padding: EdgeInsets.only(right: 15),
                                            child: RaisedButton(
                                                textColor: Colors.white,
                                                color: style.ButtonColor,
                                                child: Text("Comentar"),
                                                onPressed: () {
                                               //   UserRepo.updateUserInf(userRegister);
                                                }
                                            ),
                                          )),
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
    super.initState();
  }

}


