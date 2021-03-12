import 'dart:io';

class FileData {
  int id;
  int souvenirId;
  String path;
  String type;
  String token;
  File file;

  FileData({int id, int souvenirId, String path, String type, String token}) {
    this.id = id;
    this.souvenirId = souvenirId;
    this.path = path;
    this.type = type;
    this.token = token;
  }

  // ! A FAIRE
  get thumbnailUrl => path + 'blabla';

  // Instanciate from json API response
  FileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    souvenirId = int.parse(json['souvenir'].split('/').last);
    path = json['path'];
    type = json['type'];
    token = json['token'];
  }

  // Instanciate from souvenir cover
  FileData.fromCover(int souvenirId, String coverLink) {
    id = 0;
    souvenirId = souvenirId;
    path = coverLink;
  }
}
