import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/models/file.dart';

class ListSouvenirsRemoteSource {

  // Singleton intialization
  ListSouvenirsRemoteSource._();
  static ListSouvenirsRemoteSource _cache;
  factory ListSouvenirsRemoteSource() => _cache ??= ListSouvenirsRemoteSource._();


  // -------------------- GET --------------------

  // Get all user's categories & add an "All" category (for display all souvenirs)
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


  // Get all user's souvenirs and call get files method for each one
  Future<List<Souvenir>> getAllSouvenirs(int userId) async {
    final String url = "http://192.168.1.110:8000/api/souvenirs?user=$userId";
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];

    List<Souvenir> souvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    for (int i = 0; i < souvenirsList.length; i++) {
      Souvenir souvenir = souvenirsList[i];
      await getSouvenirFiles(souvenir);
    }

    return souvenirsList;
  }


  // Get all souvenir's files and add cover to files list
  Future<List<File>> getSouvenirFiles(Souvenir souvenir) async {
    int souvenirId = souvenir.id;

    final String url = "http://192.168.1.110:8000/api/files?souvenir=$souvenirId";
    final response = await http.get(url);

    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];
    
    List<File> filesList = data.map((file) => File.fromJson(file)).toList();

    souvenir.thumbnails = filesList;

    File coverFile = File.fromCover(souvenir.id, souvenir.cover);
    souvenir.thumbnails.insert(0, coverFile);

    return filesList;
  }


  // -------------------- DELETE --------------------

  Future<void> deleteFile(int fileId) async {
    final String url = "http://192.168.1.110:8000/api/files/$fileId";
    final response = await http.delete(url);
    if (response.statusCode != 204) throw Exception;
  }


  Future<void> deleteSouvenir(int souvenirId) async {
    final String url = "http://192.168.1.110:8000/api/souvenirs/$souvenirId";
    final response = await http.delete(url);
    if (response.statusCode != 204) throw Exception;
  }


  // -------------------- UPDATE --------------------

  // Update souvenir and return new souvenir from updated data
  Future<Souvenir> updateSouvenir(int souvenirId, Souvenir newSouvenirData) async {
    String url = "http://192.168.1.110:8000/api/souvenirs/$souvenirId";

    String data = json.encode(newSouvenirData.toJson());

    Map<String,String> headers = {
      'Content-type' : 'application/merge-patch+json;charset=UTF-8', 
    };

    final response = await http.patch(url, body: data, headers: headers);

    if (response.statusCode != 200) throw Exception;

    final Map<String, dynamic> responseJson = json.decode(response.body);

    Souvenir updatedSouvenir = Souvenir.fromJson(responseJson);
    return updatedSouvenir;
  }


}