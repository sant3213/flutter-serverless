
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/queries/model/userComment.dart';

class PublicationData {
  String _id;
  String _title;
  String _description;
  String userCreator;
  UserComment userComment;

  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController userCreatorController = TextEditingController();
  PublicationData();

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  Map<String, dynamic> toMap(PublicationData publicationData) {
      return {
        'id': publicationData.idController.text,
        'title': publicationData.titleController.text,
        'description': publicationData.descriptionController.text,
        'userCreator': publicationData.userCreatorController.text
      };
    }


  Map<String, dynamic> toMapFull(PublicationData publicationData, UserComment userComment) {
      return {
        'id': publicationData.idController.text,
        'title': publicationData.titleController.text,
        'description': publicationData.descriptionController.text,
        'userCreator': publicationData.userCreatorController.text,
        'comments': userComment
      };
    }


  factory PublicationData.fromJson(LinkedHashMap<dynamic, dynamic> source) {
    PublicationData publicationData = new PublicationData();
    publicationData.idController.text = source['id'];
    publicationData.titleController.text = source['title'];
    publicationData.userCreatorController.text = source['userCreator'];
    publicationData.descriptionController.text =  source['description'];
  //  publicationData.commentsController.text =  source['comments'],
    return publicationData;
  }
}