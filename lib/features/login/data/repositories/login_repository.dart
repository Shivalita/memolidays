//! Check connectivity and handle data
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/view/components/flush.dart';
import 'package:memolidays/features/login/data/sources/login_remote_source.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class LoginRepository {

 //! Instanciate remote source and snackbar to display on connectivity fail
  final LoginRemoteSource loginRemoteSource = LoginRemoteSource();
  

  //! Singleton repository
  LoginRepository._();

  static LoginRepository _cache;

  factory LoginRepository() => _cache ??= LoginRepository._();

  //! Handle sign in 
  Future<User> signInWithGoogle(context) async {

    //! Check of connectivity : if not connected return error snackbar, if connected return User from remote source
    bool hasConnection = await DataConnectionChecker().hasConnection;

    // if (!hasConnection == true) return flushbar.displayFlushbar(context);
    if (!hasConnection == true) throw Exception();

    return loginRemoteSource.signInWithGoogle();

    // return Get.to(MyHomePage());

    

  }

}