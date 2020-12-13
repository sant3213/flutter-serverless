import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/queries/model/publicationData.dart';
import 'package:flutter_app/queries/queryRepository/queryRepository.dart';
import 'package:flutter_app/ui/screens/publication_detail.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
import 'package:flutter_app/ui/widgets/Utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:uuid/uuid.dart';

class PublicationScreen extends StatefulWidget {
  @override
  _PublicationScreenListState createState() => _PublicationScreenListState();
}

class _PublicationScreenListState extends State<PublicationScreen> {
  bool loadPublicationData = true;
  var publications = new List<PublicationData>();
  var publication1 = new PublicationData();
  var publication2 = new PublicationData();
  List<TextEditingController> commentsController;
  Style style = new Style();
  UserBloc userBloc;
  QueryRepository queryRepository = new QueryRepository();
  PublicationData publicationData = new PublicationData();
  var uuid = Uuid();
  var isSuccess;
  Future<List<dynamic>> publicationDataList;
  List<PublicationData> publicationList = new List<PublicationData>();
  bool _isloading = true;

  @override
  Widget build(BuildContext context) {
    return _isloading ? spinnerLoading() : publicationUI();
  }

  Widget publicationUI() {
    userBloc = BlocProvider.of(context);
    return Scaffold(
        appBar: SharedAppBar.getAppBar(false),
        bottomNavigationBar: SharedAppBar.getBottonBar(context, 1),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            popUpMsg();
          },
          child: Icon(Icons.add),
          backgroundColor: style.BackgroundColor,
        ),
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: ListView(children: <Widget>[
            Column(children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: publicationList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150,
                      child: Card(
                        color: Colors.transparent,
                        elevation: 5.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: style.BackgroundColor,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: titleCard(
                                    '${publicationList[index].titleController.text}'),
                                subtitle: descriptionCard(
                                    '${publicationList[index].descriptionController.text}'),
                                isThreeLine: true,
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.description,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PublicationDetailScreen(
                                                      publicationData:
                                                          publicationList[
                                                              index])));
                                    }))),
                      ),
                    );
                  }),
            ])
          ]),
        ));
  }

  @override
  initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    publicationDataList = queryRepository.getAllQueries();
    await publicationDataList.then((value) => value.forEach((element) {
          setState(() {
            publicationList.add(PublicationData.fromJson(element));
          });
          loadPublicationData = true;
        }));
  }

  Future<Widget> popUpMsg() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: 300,
              child: WillPopScope(
                  onWillPop: () {},
                  child: AlertDialog(
                    title: Text('Ingresa los datos'),
                    content: Column(
                      children: [
                        TextField(
                          controller: publicationData.titleController,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: "Título"),
                        ),
                        TextField(
                          controller: publicationData.descriptionController,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: "Descripción"),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('Enviar'),
                        onPressed: () {
                          publicationData.idController.text =
                              uuid.v1().toString();
                          isSuccess =
                              queryRepository.saveQueryInf(publicationData);
                        },
                      ),
                      new FlatButton(
                        child: new Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  clearData() {
    publicationData.idController.clear();
    publicationData.titleController.clear();
    publicationData.descriptionController.clear();
  }

  Widget spinnerLoading() {
    return Container(
      color: style.BackgroundColor,
      child: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
          duration: Duration(seconds: 2),
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
