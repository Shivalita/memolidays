import 'package:hive/hive.dart';

class LocalSource {

  var storageBox = Hive.box('storageBox');

  void storeUserIds(String googleId, int memolidaysId) {
    storageBox.put('googleId', googleId);
    storageBox.put('memolidaysId', memolidaysId);
  }

  String getGoogleUserId() {
    String googleId = storageBox.get('googleId');
    return googleId;
  }

  int getMemolidaysUserId() {
    int memolidaysId = storageBox.get('memolidaysId');
    return memolidaysId;
  }

}