import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/models/file.dart';

class ListSouvenirsRemoteSource {

  final String api = "http://94.23.11.60:8081/memoservices/api/v2/";

  ListSouvenirsRemoteSource._();
  static ListSouvenirsRemoteSource _cache;
  factory ListSouvenirsRemoteSource() => _cache ??= ListSouvenirsRemoteSource._();

  // Future<List<Category>> getCategoriesList(int userId) async {
  //   final String link = '${api}headings/$userId';
  //   final dynamic request = await http.get(link);


  //   if (request.statusCode != 200) throw Exception;
  //   List data = json.decode(request.body)['data'];

  //   List<Category> categoriesList = data.map((category) => Category.fromJson(category)).toList();

  //   await Future.forEach(categoriesList, (category) async {
  //     List<Souvenir> souvenirsList = await getSouvenirsByCategory(category.id, userId);
  //     category.souvenirsList = souvenirsList;
  //   });

  //   return categoriesList;
  // }

  // Future<List<Souvenir>> getSouvenirsByCategory(int categoryId, int userId) async {
  //   final String link = '${api}memories/$categoryId/$userId';
  //   final http.Response request = await http.get(link);
    
  //   if (request.statusCode != 200) throw Exception;
  //   List data = json.decode(request.body)['data'];

  //   List<Souvenir> categorySouvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

  //   categorySouvenirsList.forEach((souvenir) {
  //     // List<Thumbnail> thumbnailsList = souvenir.thumbnails;
  //     // Thumbnail coverThumbnail = Thumbnail.fromCover(souvenir.tempLink);
  //     // thumbnailsList.insert(0, coverThumbnail);
  //   });

  //   return categorySouvenirsList;
  // }

  Future<List<Souvenir>> getAllSouvenirs() async {
    final String url = "http://192.168.1.110:8000/api/souvenirs";

    final http.Response response = await http.get(url);
    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];

    List<Souvenir> souvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    // print('data = $data');

    for (int i = 0; i < data.length; i++) {
      var souvenirData = data[i];
      List<dynamic> filesLinks = souvenirData['files'];
      List<File> filesList = await getSouvenirFiles(filesLinks);

      List<Souvenir> matchingSouvenir = souvenirsList.where((souvenir) => souvenir.id == filesList[0].souvenirId).toList();  
      Souvenir currentSouvenir = matchingSouvenir[0];  
      currentSouvenir.thumbnails = filesList;

      File coverFile = File.fromCover(currentSouvenir.id, currentSouvenir.cover);
      currentSouvenir.thumbnails.insert(0, coverFile);
    }

    return souvenirsList;
  }

  Future<List<File>> getSouvenirFiles(List<dynamic> filesLinks) async {
    List<File> filesList = [];

    for (int i = 0; i < filesLinks.length; i++) {
      final String url = "http://192.168.1.110:8000${filesLinks[i]}";
      final response = await http.get(url);
      print('get file statusCode = ${response.statusCode}');
      if (response.statusCode != 200) throw Exception;

      final Map<String, dynamic> data = json.decode(response.body);
      File file = File.fromJson(data);
      filesList.add(file);
    }

    return filesList;
  }

}