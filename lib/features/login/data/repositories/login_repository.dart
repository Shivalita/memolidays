//! Gestion de la connexion/vérification de la connectivité de l'appareil

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

    //! Récupération des données et instanciation d'un User
    final userData = await loginRemoteSource.signInWithGoogle();
    final User user = new User(userData.uid, userData.displayName, userData.email);

    //! Vérification de la connectivité
    

    // return user;
    return Get.to(MyHomePage());

  }

}