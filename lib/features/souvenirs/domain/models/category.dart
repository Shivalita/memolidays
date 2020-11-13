class Category {

  int id;
  int userId;
  int pinId;
  String name;
  // List<Souvenir> souvenirsList;

  Category({int id, int userId, int pinId, String name}) {
    this.id = id;
    this.userId = userId;
    this.pinId = pinId;
    this.name = name;
    // this.souvenirsList = souvenirsList;
  }

  //! Category constructor from map
  Category.fromJson(Map<String, dynamic> data) {
    id = data['id']; 
    userId = data['userId']; 
    pinId = data['pinId']; 
    name = data['name'];
  }

  Category.fromForm(Map<String, dynamic> data) {
    id = data['id']; 
    userId = data['userId'];
    name = data['name'];
    // souvenirsList = data['souvenirs']
    if (data['pinId'] != null) {
      pinId = data['pinId'];
    }

  }

}