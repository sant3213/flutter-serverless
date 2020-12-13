import 'dart:convert';
import 'package:flutter_app/queries/model/publicationData.dart';
import 'package:http/http.dart' as http;

class QueryRepository {
  List<PublicationData> publicationData = new List<PublicationData>();

  Future <List<dynamic>> getAllQueries() async {
    var queries = new List();
    var response;
    var uri = Uri.https('4psc2gqhjg.execute-api.us-east-1.amazonaws.com',
        '/publicationTest/publications');
    await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((value) => {
      response = json.decode(value.body)
    });
    queries = response;

    return queries;
  }

  Future<String> saveQueryInf(PublicationData publicationData) async {
    var response;
    http
        .post(
      'https://4psc2gqhjg.execute-api.us-east-1.amazonaws.com/publicationTest/publications',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(publicationData.toMap(publicationData)),
    )
        .then((value) =>
    response= value.statusCode);
    return response;
  }

  Future<String> updateQueryInf(PublicationData publicationData) async {
    var response;
    http
        .put(
      'https://4psc2gqhjg.execute-api.us-east-1.amazonaws.com/publicationTest/publications',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(publicationData.toMap(publicationData)),
    )
        .then((value) =>
   response= value.statusCode);
    return response;
  }
}
