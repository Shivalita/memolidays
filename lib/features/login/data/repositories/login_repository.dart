import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';

class LoginRepository {

  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();

  LoginRepository._();
  static LoginRepository _cache;
  factory LoginRepository() => _cache ??= LoginRepository._();

  Future<User> signInWithGoogle() async {
    User user = await loginRemoteSource.signInWithGoogle();
    LocalSource localSource = LocalSource();
    localSource.storeUserData(user.googleId, user.googleName, user.googlePicture, user.memolidaysId);
    localSource.setPremiumStatus(user.isPremium);
    print('isPremium = ${user.isPremium}');
    return user;
  }

  Future<String> signOutGoogle() async {
    String disconnectionMessage = await loginRemoteSource.signOutGoogle();
    return disconnectionMessage;
  }

}