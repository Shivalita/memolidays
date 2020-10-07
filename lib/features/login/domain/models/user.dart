//! User Entity
class User {

  String googleId;
  String name;
  String mail;
  String memolidaysId;

  User(String googleId, String name, String mail, String memolidaysId) {
    this.googleId = googleId;
    this.name = name;
    this.mail = mail;
    this.memolidaysId = memolidaysId;
  }

}