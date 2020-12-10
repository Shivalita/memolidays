class User {

  int id;
  String googleId;
  String name;
  String email;
  String avatar;
  bool isPremium;

  User(int id, String googleId, String name, String email, String avatar, bool isPremium) {
    this.id = id;
    this.googleId = googleId;
    this.name = name;
    this.email = email;
    this.avatar = avatar;
    this.isPremium = isPremium;
  }


  // Instanciate from json API response
  User.fromJson(Map<String, dynamic> data) {
    id = data['id']; 
    googleId = data['googleId']; 
    name = data['name']; 
    email = data['email'];
    avatar = data['avatar'];
    isPremium = data['isPremium'];
  }


  // Instanciate from local storage data
  User.fromLocal(Map<String, dynamic> data) {
    id = data['id']; 
    googleId = data['googleId']; 
    name = data['name']; 
    email = data['email'];
    avatar = data['avatar'];
    isPremium = data['isPremium'];
  }
  
}