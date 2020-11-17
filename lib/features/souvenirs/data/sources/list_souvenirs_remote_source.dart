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

  Future<List<Category>> getAllCategories(int userId) async {
    final String url = "http://192.168.1.110:8000/api/categories?user=$userId";

    final http.Response response = await http.get(url);
    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];

    List<Category> categoriesList = data.map((category) => Category.fromJson(category)).toList();

    print('GET ALL CATEGORIES DATA = $data');
    print('CATEGORIES LIST= $categoriesList');

    return categoriesList;
  }

  //!

  Future<List<Souvenir>> getAllSouvenirs(int userId) async {
    final String url = "http://192.168.1.110:8000/api/souvenirs?user=13";

    final http.Response response = await http.get(url);
    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];

    List<Souvenir> souvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    // print('GET ALL SOUVENIRS DATA = $data');
    // print('SOUVENIRS LIST= $souvenirsList');

    for (int i = 0; i < souvenirsList.length; i++) {
      // var souvenirData = data[i];
      // List<dynamic> filesLinks = souvenirData['files'];
      Souvenir souvenir = souvenirsList[i];
      List<File> filesList = await getSouvenirFiles(souvenir);

      // List<Souvenir> matchingSouvenir = souvenirsList.where((souvenir) => souvenir.id == filesList[0].souvenirId).toList();  
      // Souvenir currentSouvenir = matchingSouvenir[0];  
      souvenir.thumbnails = filesList;

      File coverFile = File.fromCover(souvenir.id, souvenir.cover);
      souvenir.thumbnails.insert(0, coverFile);
    }

    return souvenirsList;
  }

  Future<List<File>> getSouvenirFiles(Souvenir souvenir) async {
    int souvenirId = souvenir.id;
    // List<File> filesList = [];

    final String url = "http://192.168.1.110:8000/api/files?souvenir=$souvenirId";
    final response = await http.get(url);
    // print('get file statusCode = ${response.statusCode}');
    if (response.statusCode != 200) throw Exception;

    List data = json.decode(response.body)['hydra:member'];
    // print('GET ALL FILES DATA = $data');

    // List<Souvenir> souvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    List<File> filesList = data.map((file) => File.fromJson(file)).toList();
    // File file = File.fromJson(data);
    // filesList.add(file);

    return filesList;
  }

}