import 'package:flutter/cupertino.dart';
import 'package:memolidays/core/components/exceptions/google_auth_exception.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';

class LoginRepository {

  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();

  LoginRepository._();
  static LoginRepository _cache;
  factory LoginRepository() => _cache ??= LoginRepository._();

  Future<User> signInWithGoogle(BuildContext context) async {
    
    try {
      User user = await loginRemoteSource.signInWithGoogle(context);

      LocalSource localSource = LocalSource();
      localSource.storeUserIds(user.googleId, user.memolidaysId);

      return user;
    }

    on GoogleAuthException {
      print('ERROR : Google Authentication failed');
      final GoogleAuthException googleAuthException = GoogleAuthException(context);
      googleAuthException.displayError();
    }

  }

  Future<String> signOutGoogle(BuildContext context) async {
    String disconnectionMessage = await loginRemoteSource.signOutGoogle(context);
    return disconnectionMessage;
  }

}