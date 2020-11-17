import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';

class LoginRepository {

  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();
  final  LocalSource localSource = LocalSource();

  LoginRepository._();
  static LoginRepository _cache;
  factory LoginRepository() => _cache ??= LoginRepository._();

  // Sign in & store user data in local storage
  Future<User> signInWithGoogle() async {
    User user = await loginRemoteSource.signInWithGoogle();
    localSource.storeUserData(user.id, user.googleId, user.name, user.email, user.avatar);
    localSource.setPremiumStatus(user.isPremium);
    return user;
  }

  Future<String> signOutGoogle() async {
    String disconnectionMessage = await loginRemoteSource.signOutGoogle();
    return disconnectionMessage;
  }

  //!
  Future<User> getUser(userId) async {
    User user = await loginRemoteSource.getUser(userId);
    return user;
  }

}