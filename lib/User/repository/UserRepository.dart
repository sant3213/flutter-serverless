import 'dart:collection';
import 'dart:convert';
import 'package:flutter_app/User/model/UserData.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  UserData userData = new UserData();

  Future<LinkedHashMap<dynamic,dynamic>> getUserInformation(String email) async {
    var response;
    var queryStringParameters = {'email': email};
    var uri = Uri.https('5pn7gol8n4.execute-api.us-east-1.amazonaws.com',
        '/test/transactions', queryStringParameters);
    await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((value) => {
      response = json.decode(value.body)
    });
    var userInf = json.decode(response["body"]);
    return userInf;
  }

  Future<bool> updateUserInf(UserData userData) async {
      http
          .post(
        'https://qe7bahgcj8.execute-api.us-east-1.amazonaws.com/pstStage/save-users',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(userData.toMap(userData)),
      )
          .then((value) => print("retorno----->" + value.body));
    }
 }
