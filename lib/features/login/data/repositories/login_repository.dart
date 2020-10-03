//! Gestion de la connexion au compte Google

import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';

class LoginRepository {

  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();

  LoginRepository._();

  static LoginRepository _cache;

  factory LoginRepository() => _cache ??= LoginRepository._();

  Future<User> signInWithGoogle() async {

    final userData = await loginRemoteSource.signInWithGoogle();
    final User user = new User(userData.uid, userData.displayName, userData.email);

    // return user;
    return Get.to(MyHomePage());

  }

}