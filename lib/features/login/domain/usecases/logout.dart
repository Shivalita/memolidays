//! Handle Google connexion

import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/features/login/data/repositories/login_repository.dart';

class Logout implements Usecase {

  final LoginRepository repository = LoginRepository();

  @override
  Future<String> call(context) async {

    //! 
    String disconnectionMessage = await repository.signOutGoogle(context);
    return disconnectionMessage;

    // //! If connectivity exception thrown, display connectivity error snackbar
    // on ConnectivityException {

    //   print('ERROR : No connectivity. Exception :');
    //   final ConnectivityException connectivityException = ConnectivityException(context);
    //   connectivityException.displayError();

    // }

  }

}