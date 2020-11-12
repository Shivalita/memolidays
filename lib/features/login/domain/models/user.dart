class User {

  int id;
  String googleId;
  String name;
  String email;
  String avatar;
  bool isPremium = false;

  User(int id, String googleId, String name, String email, String avatar) {
    this.id = id;
    this.googleId = googleId;
    this.name = name;
    this.email = email;
    this.avatar = avatar;
  }

}