import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
class ListSouvenirsRemoteSource {

  final String api = "http://94.23.11.60:8081/memoservices/api/v2/";

  ListSouvenirsRemoteSource._();
  static ListSouvenirsRemoteSource _cache;
  factory ListSouvenirsRemoteSource() => _cache ??= ListSouvenirsRemoteSource._();

  Future<List<Category>> getCategoriesList(int userId) async {
    final String link = '${api}headings/$userId';
    final dynamic request = await http.get(link);


    if (request.statusCode != 200) throw Exception;
    List data = json.decode(request.body)['data'];

    List<Category> categoriesList = data.map((category) => Category.fromJson(category)).toList();

    await Future.forEach(categoriesList, (category) async {
      List<Souvenir> souvenirsList = await getSouvenirsByCategory(category.id, userId);
      category.souvenirsList = souvenirsList;
    });

    return categoriesList;
  }

  Future<List<Souvenir>> getSouvenirsByCategory(int categoryId, int userId) async {
    final String link = '${api}memories/$categoryId/$userId';
    final http.Response request = await http.get(link);
    
    if (request.statusCode != 200) throw Exception;
    List data = json.decode(request.body)['data'];

    List<Souvenir> categorySouvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    return categorySouvenirsList;
  }

}