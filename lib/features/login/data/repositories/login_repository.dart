import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/core/google_drive_remote_source.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class LoginRepository {

  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();
  final GoogleDriveRemoteSource googleDriveRemoteSource = GoogleDriveRemoteSource();
  final  LocalSource localSource = LocalSource();
  User user;

  // Singleton initialization
  LoginRepository._();
  static LoginRepository _cache;
  factory LoginRepository() => _cache ??= LoginRepository._();

  // If connected get user from local storage, else call login method & set isConnected to true
  Future<User> login() async {
    bool isConnected = localSource.getIsConnected();

    if (isConnected != null && isConnected == true) {
      user = getUserFromLocalStorage();
    } else {
      user = await loginRemoteSource.login();
      localSource.storeUserData(user.id, user.googleId, user.name, user.email, user.avatar, user.isPremium);
    }

    await googleDriveRemoteSource.authenticateDriveApi();
    localSource.setIsConnected(true);
    return user;
  }


  // Instanciate user from data stored in local storage
  User getUserFromLocalStorage() {
    Map<String, dynamic> userData = localSource.getUserData();
    user = User.fromLocal(userData);
    return user;
  }


  // Call Google logout method, set isConnected to false & clear state categories list 
  Future<void> signOutGoogle() async {
    await loginRemoteSource.signOutGoogle();
    localSource.setIsConnected(false);
    souvenirsState.setState((state) => state.allCategoriesList = null); 
  }

}