//! Connexion au compte Google

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRemoteSource {

  String api = "http://94.23.11.60:8081/memoservices/api/v2/";

  FindUser() async {
    var link = api+'user/find';
    return await http.post(
      link,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": "00708valentin@gmail.com",
        "user": "799",
      }),
    );
  }

}