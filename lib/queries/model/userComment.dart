
import 'dart:collection';

import 'package:flutter/cupertino.dart';

class UserComment {

  String email;
  String comment;

  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  UserComment();

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
    UserComment userComment = new UserComment();
    userComment.emailController.text = source['email'];
    userComment.commentController.text = source['comment'];
    return userComment;
  }
}