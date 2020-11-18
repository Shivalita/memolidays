import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';


class LoginRepository {

  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();
  final  LocalSource localSource = LocalSource();

  // Singleton initialization
  LoginRepository._();
  static LoginRepository _cache;
  factory LoginRepository() => _cache ??= LoginRepository._();

  User user;


  // If connected get user from local storage, else call login method & set isConnected to true
  Future<User> login() async {
    bool isConnected = localSource.getIsConnected();

    if (isConnected != null && isConnected == true) {
      user = getUserFromLocalStorage();

    } else {
      user = await loginRemoteSource.login();
      localSource.storeUserData(user.id, user.googleId, user.name, user.email, user.avatar, user.isPremium);
    }

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