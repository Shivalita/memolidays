import 'package:hive/hive.dart';

class LocalSource {

  var storageBox = Hive.box('storageBox');

  void storeUserIds(String googleId, int memolidaysId) {
    storageBox.put('googleId', googleId);
    storageBox.put('memolidaysId', memolidaysId);
  }

  Map<String, dynamic> getUserIds() {
    String gId = storageBox.get('googleId');
    int mId = storageBox.get('memolidaysId');

    Map<String, dynamic> idsMap = {'googleId' : gId, 'memolidaysId' : mId};
    return idsMap;
  }

}