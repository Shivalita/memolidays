import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/models/file_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:path_provider/path_provider.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'dart:io';

class ListSouvenirsRemoteSource {
  // Singleton intialization
  ListSouvenirsRemoteSource._();
  static ListSouvenirsRemoteSource _cache;
  factory ListSouvenirsRemoteSource() =>
      _cache ??= ListSouvenirsRemoteSource._();

  // Get localhost from .env file
  final LOCALHOST = env['LOCALHOST'];

  // -------------------- GET --------------------

  // Get all user's categories & add an "All" category (for display all souvenirs)
  Future<List<Category>> getAllCategories(int userId) async {
    final String url = "http://" + LOCALHOST + "/api/categories?user=$userId";

    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      print("GET ALL CATEGORIES ERROR : status code ${response.statusCode}");
      throw Exception;
    }
    
    List data = json.decode(response.body)['hydra:member'];

    List<Category> categoriesList =
        data.map((category) => Category.fromJson(category)).toList();

    Category allCategory =
        Category.all({'id': 0, 'userId': userId, 'name': "All"});
    categoriesList.insert(0, allCategory);

    return categoriesList;
  }

  Future<File> file(filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName = dir.path + filename;
    return File(pathName);
  }

  // Get all user's souvenirs and call get files method for each one
  Future<List<Souvenir>> getAllSouvenirs(int userId) async {
    final String url = "http://" + LOCALHOST + "/api/souvenirs?user=$userId";
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      print("GET ALL SOUVENIRS ERROR : status code ${response.statusCode}");
      throw Exception;
    }

    List data = json.decode(response.body)['hydra:member'];
    print(data[0]);
    List<Souvenir> souvenirsList =
        data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    for (int i = 0; i < souvenirsList.length; i++) {
      List<Map<String, dynamic>> filesData =
          data[i]['files'].cast<Map<String, dynamic>>();

      List<FileData> filesDataList = [];
      await Future.forEach(filesData, (fileData) async {

        //Image link from google drive for tests
        //fileData['path'] ="https://drive.google.com/file/d/15LWkpR_PZ6Q67u4N2PdplIXfbI5Kgjxy";

        var myFile = await this.file(fileData['path'].split('/').last + "." + fileData['type']);
        fileData['file'] = myFile;

      souvenirsList[i].thumbnails.insert(0, coverFile);

      List<Map<String, dynamic>> categoriesData = data[i]['categories'].cast<Map<String, dynamic>>();

      List<Category> categoriesList = categoriesData.map(
        (categoriesData) => Category.fromJson(categoriesData)
      ).toList();
      
      souvenirsList[i].categories = categoriesList;

      souvenirsList[i].categoriesId = categoriesList.map((category) => category.id).toList();

      souvenirsList[i].categoriesId.add(0);
    }

        filesDataList.add(FileData.fromJson(fileData));
      });

      souvenirsList[i].thumbnails = filesDataList;
  
      /*File coverImgFile =
          await this.file('15LWkpR_PZ6Q67u4N2PdplIXfbI5Kgjxy.jpg');

      FileData coverFile = FileData.fromCover(
          souvenirsList[i].id, souvenirsList[i].cover, coverImgFile);
      //print(coverFile.file);
      souvenirsList[i].thumbnails.insert(0, coverFile);*/
    }
    return souvenirsList;
  }

  // -------------------- DELETE --------------------

  Future<void> deleteFile(int fileId) async {
    final String url = "http://" + LOCALHOST + "/api/files/$fileId";
    final response = await http.delete(url);

    if (response.statusCode != 204) {
      print("DELETE FILE ERROR : status code ${response.statusCode}");
      throw Exception;
    }
  }

  Future<void> deleteSouvenir(int souvenirId) async {
    final String url = "http://" + LOCALHOST + "/api/souvenirs/$souvenirId";
    final response = await http.delete(url);

    if (response.statusCode != 204) {
      print("DELETE SOUVENIR ERROR : status code ${response.statusCode}");
      throw Exception;
    }
  }

  // -------------------- UPDATE --------------------

  // Update souvenir and return new souvenir from updated data
  Future<Souvenir> updateSouvenir(
      int souvenirId, Souvenir newSouvenirData) async {
    String url = "http://" + LOCALHOST + "/api/souvenirs/$souvenirId";

    String data = json.encode(newSouvenirData.toJson());

    Map<String, String> headers = {
      'Content-type': 'application/merge-patch+json;charset=UTF-8',
    };

    final response = await http.patch(url, body: data, headers: headers);

    if (response.statusCode != 200) {
      print("UPDATE SOUVENIR ERROR : status code ${response.statusCode}");
      throw Exception;
    }

    final Map<String, dynamic> responseJson = json.decode(response.body);

    Souvenir updatedSouvenir = Souvenir.fromJson(responseJson);
    return updatedSouvenir;
  }

  // -------------------- CREATE --------------------
  Future<Souvenir> createSouvenir(Souvenir souvenir) async {
    String url = "http://" + LOCALHOST + "/api/souvenirs";

    String data = json.encode(souvenir.toJson());
    print(data);

    Map<String,String> headers = {
      "Content-Type": "application/ld+json", 
    };

    final response = await http.post(url, body: data, headers: headers);

    if (response.statusCode != 201) {
      print("CREATE SOUVENIR ERROR : status code ${response.statusCode}");
      print(response.body);
      throw Exception;
    }

    final Map<String, dynamic> responseJson = json.decode(response.body);

    Souvenir newSouvenir = Souvenir.fromJson(responseJson);
    return newSouvenir;
  }
}
