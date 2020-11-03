class User {

  String googleId;
  String googleName;
  String mail;
  String googlePicture;
  int memolidaysId;
  bool isPremium = false;

  User(String googleId, String googleName, String mail, String googlePicture, int memolidaysId) {
    this.googleId = googleId;
    this.googleName = googleName;
    this.mail = mail;
    this.googlePicture = googlePicture;
    this.memolidaysId = memolidaysId;
  }

}