class File {

  int id;
  int souvenirId;
  String path;
  String type;
  String token;

  File({int id, int souvenirId, String path, String type, String token}) {
    this.id = id;
    this.souvenirId = souvenirId;
    this.path = path;
    this.type = type;
    this.token = token;
  }

  // Instanciate from json API response 
  File.fromJson(Map<String, dynamic> json) {
    id = json['id']; 
    souvenirId = int.parse(json['souvenir'].substring(json['souvenir'].length - 1));
    path = json['path'];
    type = json['type'];
    token = json['token'];
  }

  // Instanciate from souvenir cover
  File.fromCover(int souvenirId, String coverLink) {
    id = 0;
    souvenirId = souvenirId;
    path = coverLink; 
  }

}