import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

class LocalSource {

  var storageBox = Hive.box('storageBox');

  void storeUserData(String googleId, String googleName, String googlePicture, int memolidaysId) {
    storageBox.put('googleId', googleId);
    storageBox.put('googleName', googleName);
    storageBox.put('googlePicture', googlePicture);
    storageBox.put('memolidaysId', memolidaysId);
    storageBox.put('isConnected', true);
  }

  void setPremiumStatus(bool isPremium) {
    storageBox.put('isPremium', isPremium);
  }

  bool getIsConnected() {
    bool isConnected = storageBox.get('isConnected');
    return isConnected;
  }

  String getGoogleUserId() {
    String googleId = storageBox.get('googleId');
    return googleId;
  }

    String getgoogleName() {
    String googleName = storageBox.get('googleName');
    return googleName;
  }

    String getgooglePicture() {
    String googlePicture = storageBox.get('googlePicture');
    return googlePicture;
  }

  int getMemolidaysUserId() {
    int memolidaysId = storageBox.get('memolidaysId');
    return memolidaysId;
  }

  bool getIsPremium() {
    bool isPremium = storageBox.get('isPremium');
    return isPremium;
  }

}