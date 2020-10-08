//! Handle login data
import 'package:memolidays/core/components/exceptions/google_auth_exception.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';

class LoginRepository {

  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();

  //! Singleton repository
  LoginRepository._();
  static LoginRepository _cache;
  factory LoginRepository() => _cache ??= LoginRepository._();

  //! Handle sign in 
  Future<User> signInWithGoogle(context) async {
    
    try {
      //! Return User and store user ids on local storage
      User user = await loginRemoteSource.signInWithGoogle(context);

      LocalSource localSource = LocalSource();
      localSource.storeUserIds(user.googleId, user.memolidaysId);

      return user;
    }

    //! If google authentication exception thrown, display google auth error snackbar
    on GoogleAuthException {
      print('ERROR : Google Authentication failed');
      final GoogleAuthException googleAuthException = GoogleAuthException(context);
      googleAuthException.displayError();
    }

  }

  //! Handle sign out
  Future<String> signOutGoogle(context) async {
    String disconnectionMessage = await loginRemoteSource.signOutGoogle(context);
    return disconnectionMessage;
  }

}