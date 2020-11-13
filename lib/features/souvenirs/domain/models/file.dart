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

  //! File constructor from map
  File.fromJson(Map<String, dynamic> data) : this(
    id : data['id'], 
    souvenirId : data['souvenirId'],
    path : data['path'],
    type : data['type'],
    token : data['token'],
  );

}