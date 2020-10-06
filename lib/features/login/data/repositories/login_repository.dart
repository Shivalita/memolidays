//! Check connectivity and handle data
import 'package:memolidays/core/components/exceptions/google_auth_exception.dart';
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

    // //! Check of connectivity
    // bool hasConnection = await DataConnectionChecker().hasConnection;

    // //! Handle connectivity error
    // if (!hasConnection == true) {
    //   print('ERROR : ');
    //   print(DataConnectionChecker().lastTryResults);
    //   throw ConnectivityException(context);
    // }
    
    try {

      //! Return User from remote source
      User user = await loginRemoteSource.signInWithGoogle(context);
      return user;

    }

    //! If google authentication exception thrown, display google auth error snackbar
    on GoogleAuthException {

      print('ERROR : Google Authentication failed');
      final GoogleAuthException googleAuthException = GoogleAuthException(context);
      googleAuthException.displayError();

    }

  }

  Future<String> signOutGoogle(context) async {
    String disconnectionMessage = await loginRemoteSource.signOutGoogle(context);
    return disconnectionMessage;
  }

}