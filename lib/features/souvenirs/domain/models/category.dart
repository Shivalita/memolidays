class Category {

  int id;
  int userId;
  int pinId;
  String name;

  Category({int id, int userId, int pinId, String name}) {
    this.id = id;
    this.userId = userId;
    this.pinId = pinId;
    this.name = name;
  }

  // Instanciate from json API response 
  Category.fromJson(Map<String, dynamic> data) {
    id = data['id']; 
    userId = int.parse(data['user'].split('/').last); 
    pinId = data['pinId']; 
    name = data['name'];
  }

  // Instanciate "All" category
  Category.all(Map<String, dynamic> data) {
    id = data['id']; 
    userId = data['userId']; 
    name = data['name'];
  }

  // Instanciate from addSouvenir form
  Category.fromForm(Map<String, dynamic> data) {
    id = data['id']; 
    userId = data['userId'];
    name = data['name'];
    
    if (data['pinId'] != null) {
      pinId = data['pinId'];
    }

  }

}