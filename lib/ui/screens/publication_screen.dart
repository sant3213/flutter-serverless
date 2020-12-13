import 'package:flutter/material.dart';
import 'package:flutter_app/User/bloc/bloc_user.dart';
import 'package:flutter_app/queries/model/publicationData.dart';
import 'package:flutter_app/queries/queryRepository/queryRepository.dart';
import 'package:flutter_app/ui/screens/publication_detail.dart';
import 'package:flutter_app/ui/styles/Style.dart';
import 'package:flutter_app/ui/widgets/AppWidgets.dart';
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
  Future<List<PublicationData>> publicationList;
  @override
  Widget build(BuildContext context) {
    return publicationUI();
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
                  itemCount: publications.length,
                  itemBuilder: (context, index) {
                    return Card(
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
                              title: Text('${publications[index].title}',
                                  overflow: TextOverflow.ellipsis,
                                  //maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  )),
                              subtitle: Text(
                                  ('${publications[index].description}'),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
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
                                                PublicationDetailScreen()));
                                  }))),
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
   /* publicationList= queryRepository.getAllQueries();
    print(publicationList);*/
    publication1.title = "primero";
    publication1.description = "primero descripción";
    //publication1.comments.add("es un comentario");
    publication1.title = "segundo";
    publication1.description = "segundo descripción";
    // publication1.comments.add("es un comentario");

    setState(() {
      loadPublicationData = true;
      publications.add(publication1);
      publications.add(publication2);
    });
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
                  onWillPop: (){},
              child:AlertDialog(
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
                      publicationData.idController.text = uuid.v1().toString();
                      isSuccess = queryRepository.saveQueryInf(publicationData);
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

  clearData(){
    publicationData.idController.clear();
    publicationData.titleController.clear();
    publicationData.descriptionController.clear();
  }


}
