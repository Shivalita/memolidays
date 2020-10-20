import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/models/thumbnail.dart';

class ListSouvenirsRemoteSource {

  final String api = "http://94.23.11.60:8081/memoservices/api/v2/";
  int index = 0;

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

    index = 0;
    return categoriesList;
  }

  Future<List<Souvenir>> getSouvenirsByCategory(int categoryId, int userId) async {
    final String link = '${api}memories/$categoryId/$userId';
    final http.Response request = await http.get(link);
    
    if (request.statusCode != 200) throw Exception;
    List data = json.decode(request.body)['data'];

    List<Souvenir> categorySouvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    //! Temporary (NOT DYNAMIC)  
    categorySouvenirsList.forEach((souvenir) {
      getSouvenirsImagesLinks(categorySouvenirsList); 
    });

    return categorySouvenirsList;
  }

  //! Process for getting images links, for now NOT DYNAMIC
  List<Souvenir> getSouvenirsImagesLinks(List<Souvenir> souvenirs) {
    List<String> linksList = [
      "https://images.pexels.com/photos/302769/pexels-photo-302769.jpeg?auto=compress&cs=tinysrgb&dpr=2",
      "https://images.pexels.com/photos/884979/pexels-photo-884979.jpeg?auto=compress&cs=tinysrgb&dpr=2",
      "https://images.pexels.com/photos/291762/pexels-photo-291762.jpeg?auto=compress&cs=tinysrgb&dpr=2",
      "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&dpr=2",
      "https://images.pexels.com/photos/247298/pexels-photo-247298.jpeg?auto=compress&cs=tinysrgb&dpr=2",
      "https://images.pexels.com/photos/169191/pexels-photo-169191.jpeg?auto=compress&cs=tinysrgb&dpr=2",
      "https://images.pexels.com/photos/1252983/pexels-photo-1252983.jpeg?auto=compress&cs=tinysrgb&dpr=2"
    ];

    for (int i = 0; i < souvenirs.length; i++) {
      souvenirs[i].cover = linksList[index];
        index++;

      List<Thumbnail> souvenirThumbnails = souvenirs[i].thumbnails;

      souvenirThumbnails.forEach((thumbnail) {
        thumbnail.path = linksList[index];
        index++;
      });
    }
    
    return souvenirs;
  }

}