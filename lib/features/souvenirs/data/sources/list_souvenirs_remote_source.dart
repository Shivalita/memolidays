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

    Category allCategory = Category.all({'id': 0, 'userId': userId, 'name': "All"});
    categoriesList.insert(0, allCategory);

    return categoriesList;
  }

  // Future<List<Souvenir>> getSouvenirs(String requestUrl) async {
  //   final http.Response response = await http.get(requestUrl);
  //   if (response.statusCode != 200) throw Exception;
  //   List data = json.decode(response.body)['hydra:member'];

  //   List<Souvenir> souvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

  //   for (int i = 0; i < souvenirsList.length; i++) {
  //     Souvenir souvenir = souvenirsList[i];
  //     List<File> filesList = await getSouvenirFiles(souvenir);
  //     souvenir.thumbnails = filesList;

  //     File coverFile = File.fromCover(souvenir.id, souvenir.cover);
  //     souvenir.thumbnails.insert(0, coverFile);
  //   }

  //   return souvenirsList;
  // }

  Future<List<Souvenir>> getAllSouvenirs(int userId) async {
    final String url = "http://192.168.1.110:8000/api/souvenirs?user=$userId";
    final http.Response response = await http.get(url);
    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];

    print("souvenirs data = $data");

    List<Souvenir> souvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    List<int> categoriesIdsList = [];

    for (int i = 0; i < souvenirsList.length; i++) {
      Souvenir souvenir = souvenirsList[i];
      List<File> filesList = await getSouvenirFiles(souvenir);
      souvenir.thumbnails = filesList;

      File coverFile = File.fromCover(souvenir.id, souvenir.cover);
      souvenir.thumbnails.insert(0, coverFile);

      List<dynamic> categoriesList = souvenir.categoriesList;
      print('SOUVENIR ID = ${souvenir.id}');
      print('SOUVENIR CATEGORIESLIST = $categoriesList');

      categoriesList.forEach((categoryString) {
        int categoryId = int.parse(categoryString.substring(categoryString.length -1));
        categoriesIdsList.add(categoryId);
        print('SOUVENIR CATEGORIESIDSLIST = $categoriesIdsList');
      });

      List<int> cleanCategoriesIdsList = categoriesIdsList.toSet().toList();

      souvenir.categoriesId = cleanCategoriesIdsList;
      categoriesIdsList = [];
      // print('souvenir.categoriesId = ${souvenir.categoriesId}');
    }

    addAllCategoryToSouvenirs(souvenirsList);

    return souvenirsList;
  }

  void addAllCategoryToSouvenirs(List<Souvenir> souvenirsList) {
    souvenirsList.forEach((souvenir) {
      souvenir.categoriesId.add(0);
    });
  }

  // Future<List<Souvenir>> getCategorySouvenirs(int categoryId) async {
  //   final String url = "http://192.168.1.110:8000/api/souvenirs?categories=$categoryId";
  //   final List<Souvenir> souvenirsList = await getSouvenirs(url);
  //   return souvenirsList;
  // }

  Future<List<File>> getSouvenirFiles(Souvenir souvenir) async {
    int souvenirId = souvenir.id;

    final String url = "http://192.168.1.110:8000/api/files?souvenir=$souvenirId";
    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception;

    List data = json.decode(response.body)['hydra:member'];
    List<File> filesList = data.map((file) => File.fromJson(file)).toList();

    return filesList;
  }

}