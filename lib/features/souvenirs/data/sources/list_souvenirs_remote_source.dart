//! Get souvenirs
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class ListSouvenirsRemoteSource {

  final String api = "http://94.23.11.60:8081/memoservices/api/v2/";

  ListSouvenirsRemoteSource._();
  static ListSouvenirsRemoteSource _cache;
  factory ListSouvenirsRemoteSource() => _cache ??= ListSouvenirsRemoteSource._();

  Future<dynamic> getSouvenirsList(userId) async {

    // //! Get user headings
    // final dynamic allHeadings = await getAllHeadings(userId);

    // final List<String> memolidaysUserId = allHeadings['data'][0]['id'].toString();

    // //! Instanciate and return User 
    // final entity.User userEntity = new entity.User(user.uid, user.displayName, user.email, memolidaysUserId);

  }

  //! Get all user's headings
  Future<List<Category>> getAllHeadings(userId) async {
    
    final String link = api+'headings/'+userId;
    final dynamic request = await http.get(link);

    if (request.statusCode != 200) throw Exception;

      List<Category> categories =
      List<Map<String, dynamic>>.from(jsonDecode(request.body))
        .map((category) => Category.fromJson(category));

    return categories;

  }

}