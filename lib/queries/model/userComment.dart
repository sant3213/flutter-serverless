
import 'dart:collection';

import 'package:flutter/cupertino.dart';

class UserComment {

  String _email;
  String _comment;

  String get comment => _comment;

  UserComment.empty() {
    email = "";
    comment = "";
  }

  UserComment(String email, String comment) {
  this.emailController.text = email;
  this.commentController.text = comment;
  }

  set comment(String value) {
    _comment = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  Map<String, dynamic> toMap(UserComment userComment) {
    if(userComment==null){
      return {
        'email': userComment.emailController.text,
        'comment': userComment.commentController.text
      };
    }else {
      return {
        'email': userComment.emailController.text,
        'comment': userComment.commentController.text
      };
    }
  }

  factory UserComment.fromJson(LinkedHashMap<dynamic, dynamic> source) {
    UserComment userComment = new UserComment.empty();
    userComment.emailController.text = source['email'];
    userComment.commentController.text = source['comment'];
    return userComment;
  }
}