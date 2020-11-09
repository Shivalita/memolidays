class User {

  int id;
  String googleId;
  String name;
  String mail;
  String avatar;
  DateTime createdAt;
  bool isPremium = false;

  User(int id, String googleId, String name, String mail, String avatar, DateTime createdAt) {
    this.id = id;
    this.googleId = googleId;
    this.name = name;
    this.mail = mail;
    this.avatar = avatar;
    this.createdAt = createdAt;
  }

}