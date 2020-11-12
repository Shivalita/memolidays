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
  Category.fromJson(Map<String, dynamic> data) : this(
    id : data['id'], 
    userId : data['user_id'], 
    pinId : data['pin_id'], 
    name : data['name']
  );

  Category.fromForm(Map<String, dynamic> data) {
    id = data['id']; 
    userId = data['user_id'];
    name = data['name'];
    // souvenirsList = data['souvenirs']
    if (data['pin_id'] != null) {
      pinId = data['pin_id'];
    }

  }

}