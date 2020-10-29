import 'package:flutter/cupertino.dart';

class PublicationData {

  String _title;
  String _description;
  List<String> _comments;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  List<String> get comments => _comments;

  set comments(List<String> value) {
    _comments = value;
  }
}