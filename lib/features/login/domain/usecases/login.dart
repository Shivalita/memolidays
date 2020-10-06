//! Handle Google connexion

import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/core/components/exceptions/connectivity_exception.dart';
import 'package:memolidays/features/login/data/repositories/login_repository.dart';
import 'package:memolidays/features/login/domain/models/user.dart';

class Login implements Usecase {

  final LoginRepository repository = LoginRepository();

  @override
  Future<User> call(context) async {

    //! If User received from remote source, return User
    try {
      
      User user = await repository.signInWithGoogle(context);
      return user;

    } 

    //! If connectivity exception thrown, display connectivity error snackbar
    on ConnectivityException {

      print('ERROR : No connectivity. Exception :');
      final ConnectivityException connectivityException = ConnectivityException(context);
      connectivityException.displayError();

    }

  }

}