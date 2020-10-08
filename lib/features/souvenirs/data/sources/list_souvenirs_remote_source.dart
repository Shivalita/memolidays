//! Get souvenirs
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class ListSouvenirsRemoteSource {

  final String api = "http://94.23.11.60:8081/memoservices/api/v2/";

  ListSouvenirsRemoteSource._();
  static ListSouvenirsRemoteSource _cache;
  factory ListSouvenirsRemoteSource() => _cache ??= ListSouvenirsRemoteSource._();

  Future<List<Category>> getCategoriesList(userId) async {
    //! Get user headings
    var categories = await getAllHeadings(userId);
    return categories;
  }

  //! Get all user headings
  Future<List<Category>> getAllHeadings(userId) async {
    
    final String link = api +'headings/'+ userId;
    final dynamic request = await http.get(link);

    if (request.statusCode != 200) throw Exception;

    List data = json.decode(request.body)['data'];
    List<Category> result = data.map((element) => Category.fromJson(element)).toList();

    return result;

  }

  Future getSouvenirsByHeading(headingId, userId) async {

    final String link = api +'/memories/' + headingId + '/' + userId;
    final dynamic request = await http.get(link);

    if (request.statusCode != 200) throw Exception;

    List data = json.decode(request.body)['data'];
    print(data);

    List<Souvenir> result = data.map((element) => Souvenir.fromJson(element)).toList();
    print(result[0].thumbnails[0].type);

  }

}