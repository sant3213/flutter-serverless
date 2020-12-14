import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/queries/model/publicationData.dart';
import 'package:flutter_app/queries/model/userComment.dart';
import 'package:flutter_app/queries/queryRepository/queryRepository.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicationDetailScreen extends StatefulWidget {
  final PublicationData publicationData;
  final String user;
  const PublicationDetailScreen({Key key, this.publicationData, this.user}) : super(key: key);

  @override
  _PublicationDetailScreenState createState() => _PublicationDetailScreenState();
}

class _PublicationDetailScreenState extends State<PublicationDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  Style style = new Style();
  UserBloc userBloc;
  SharedPreferences sharedPreferences;
  QueryRepository queryRepository;
  bool _isloading = true;
  UserComment userComment = new UserComment();
  PublicationData publicationData;
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
                                    titleText(widget.publicationData.titleController.text),
                                    Text(widget.publicationData.descriptionController.text),
                                    textFormFieldAreaFactory('Comentario',userComment.commentController,'comentario','Ingrese un comentario','comentario', true),
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
                                                  setValues();
                                                  queryRepository.updateQueryInf(publicationData, userComment);
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

  getUserInformation() {
      userComment.emailController.text =  widget.user;
    setFalse();
  }

  setValues(){
    publicationData = widget.publicationData;
    userComment.emailController.text = widget.user;
    publicationData.userComment = userComment;
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


