import 'package:hive/hive.dart';

class LocalSource {

  var storageBox = Hive.box('storageBox');

  void storeUserData(int id, String googleId, String name, String mail, String avatar) {
    storageBox.put('id', id);
    storageBox.put('googleId', googleId);
    storageBox.put('name', name);
    storageBox.put('mail', mail);
    storageBox.put('avatar', avatar);
    // storageBox.put('isConnected', true);
  }

  void setPremiumStatus(bool isPremium) {
    storageBox.put('isPremium', isPremium);
  }

  void setIsConnected() {
    storageBox.put('isConnected', true);
  }

  bool getIsConnected() {
    bool isConnected = storageBox.get('isConnected');
    return isConnected;
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

  String getMail() {
    String mail = storageBox.get('mail');
    return mail;
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