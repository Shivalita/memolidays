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
    localSource.storeUserData(user.id, user.googleId, user.name, user.mail, user.avatar, user.createdAt);
    localSource.setPremiumStatus(user.isPremium);
    return user;
  }

  Future<String> signOutGoogle() async {
    String disconnectionMessage = await loginRemoteSource.signOutGoogle();
    return disconnectionMessage;
  }

}