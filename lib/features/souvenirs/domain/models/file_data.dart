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

  String getThumbnailUrl(int desiredSize) {
    final String size = desiredSize.toString();
    final String thumbnailId = this.path.split('/').last;

    String thumbnailUrl = 

    //link working with Olivier's account
      "https://drive.google.com/thumbnail?&sz=w$size&id=$thumbnailId";

    //link working with Perle's account
     // "https://drive.google.com/thumbnail?authuser=0&sz=s$size&id=$thumbnailId";
    return thumbnailUrl;
  }

  // Instanciate from json API response
  FileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    souvenirId = int.parse(json['souvenir'].split('/').last);
    path = json['path'];
    type = json['type'];
    token = json['token'];
    file = json['file'];
  }

  // Instanciate from souvenir cover
  FileData.fromCover(int souvenirId, String coverLink, File coverImgFile) {
    id = 0;
    souvenirId = souvenirId;
    path = coverLink;
    file = coverImgFile;
  }
}
