import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class ListSouvenirsRemoteSource {

  final String api = "http://94.23.11.60:8081/memoservices/api/v2/";

  ListSouvenirsRemoteSource._();
  static ListSouvenirsRemoteSource _cache;
  factory ListSouvenirsRemoteSource() => _cache ??= ListSouvenirsRemoteSource._();

  Future<List<Category>> getCategoriesList(String userId) async {
    final String link = api +'headings/'+ userId;
    final dynamic request = await http.get(link);

    if (request.statusCode != 200) throw Exception;

    List data = json.decode(request.body)['data'];
    List<Category> categoriesList = data.map((element) => Category.fromJson(element)).toList();

    return categoriesList;
  }

  Future<List<Souvenir>> getSouvenirsByHeading(String headingId, String userId) async {
    final String link = api +'/memories/' + headingId + '/' + userId;
    final http.Response request = await http.get(link);

    if (request.statusCode != 200) throw Exception;

    List data = json.decode(request.body)['data'];
    List<Souvenir> categorySouvenirsList = data.map((element) => Souvenir.fromJson(element)).toList();

    return categorySouvenirsList;
  }

  Future<List<Souvenir>> getSouvenirsList(List categories, int userId) async {
    List<Souvenir> allSouvenirsList = [];

    categories.forEach((category) {
      allSouvenirsList.add(getSouvenirsByHeading(category.id, userId.toString()));
    }); 

    return allSouvenirsList;
  }

}