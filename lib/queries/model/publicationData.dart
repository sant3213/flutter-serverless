import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/queries/model/userComment.dart';

class PublicationData {
  String _id;
  String _title;
  String _description;
  String userCreator;
  List<UserComment> userComment = new List<UserComment>();

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

  Map<String, dynamic> toMapFull(
      PublicationData publicationData) {
    List<Map<String, dynamic>> userCommentList = new List<Map<String, dynamic>>();
    UserComment userComment = new UserComment.empty();
    publicationData.userComment.forEach(
            (element) {
         userCommentList.add(userComment.toMap(element));
            });
    return {
      'id': publicationData.idController.text,
      'title': publicationData.titleController.text,
      'description': publicationData.descriptionController.text,
      'userCreator': publicationData.userCreatorController.text,
      'comments':  userCommentList
    };
  }

  factory PublicationData.fromJson(LinkedHashMap<dynamic, dynamic> source) {
    PublicationData publicationData = new PublicationData();
    publicationData.idController.text = source['id'];
    publicationData.titleController.text = source['title'];
    publicationData.userCreatorController.text = source['userCreator'];
    publicationData.descriptionController.text = source['description'];
    if(source['comments'] != null){
        var commentObjsJson = source['comments'] as List;
        commentObjsJson.forEach((element) {
          publicationData.userComment.add(UserComment.fromJson(element));
        });
  }
    return publicationData;
  }

}
