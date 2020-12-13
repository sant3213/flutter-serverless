
import 'package:flutter/cupertino.dart';

class PublicationData {
  String _id;
  String _title;
  String _description;
  String _comments;

  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

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

  String get comments => _comments;

  set comments(String value) {
    _comments = value;
  }

  Map<String, dynamic> toMap(PublicationData publicationData) {
    return {
      'id': publicationData.idController.text,
      'title': publicationData.titleController.text,
      'description':publicationData.descriptionController.text,
      'comments': publicationData.commentsController.text
    };
  }
}