import 'package:hive/hive.dart';

class LocalSource {
  // Get instanciated local storage box
  var storageBox = Hive.box('storageBox');

  // Local storage setters
  void storeUserData(int id, String googleId, String name, String email, String avatar, bool isPremium) {
    storageBox.put('id', id);
    storageBox.put('googleId', googleId);
    storageBox.put('name', name);
    storageBox.put('email', email);
    storageBox.put('avatar', avatar);
    storageBox.put('isPremium', isPremium);
  }

  void setPremiumStatus(bool isPremium) {
    storageBox.put('isPremium', isPremium);
  }

  void setIsConnected(bool isConnected) {
    storageBox.put('isConnected', isConnected);
  }

  // Local storage getters
  bool getIsConnected() {
    bool isConnected = storageBox.get('isConnected');
    return isConnected;
  }

  Map<String, dynamic> getUserData() {
    int id = storageBox.get('id');
    String googleId = storageBox.get('googleId');
    String name = storageBox.get('name');
    String email = storageBox.get('email');
    String avatar = storageBox.get('avatar');
    bool isPremium = storageBox.get('isPremium');

    Map<String, dynamic> userData = {
      'id': id,
      'googleId': googleId,
      'name': name,
      'email': email,
      'avatar': avatar,
      'isPremium': isPremium,
    };

    return userData;
  }

  int getUserId() {
    int id = storageBox.get('id');
    return id;
  }

  String getGoogleUserId() {
    String googleId = storageBox.get('googleId');
    return googleId;
  }

  String getName() {
    String name = storageBox.get('name');
    return name;
  }

  String geteMail() {
    String email = storageBox.get('email');
    return email;
  }

  String getAvatar() {
    String avatar = storageBox.get('avatar');
    return avatar;
  }

  bool getIsPremium() {
    bool isPremium = storageBox.get('isPremium');
    return isPremium;
  }

}