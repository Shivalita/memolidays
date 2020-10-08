//! Set and get user storage user data
import 'package:hive/hive.dart';

class LocalSource {

  var storageBox = Hive.box('storageBox');

  //! Store user ids on local storage
  void storeUserIds(googleId, memolidaysId) {
    storageBox.put('googleId', googleId);
    storageBox.put('memolidaysId', memolidaysId);
  }

  //! Get user ids from local storage
  Map<String, String> getUserIds() {

    String gId = storageBox.get('googleId');
    String mId = storageBox.get('memolidaysId');

    Map<String, String> idsMap = {'googleId' : gId, 'memolidaysId' : mId};
    return idsMap;

  }

}