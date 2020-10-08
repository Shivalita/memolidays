//! Handle authentication

import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/features/login/data/repositories/login_repository.dart';
import 'package:memolidays/features/login/domain/models/user.dart';

class Login implements Usecase {

  final LoginRepository repository = LoginRepository();

  @override
  Future<User> call(context) async {

    //! Return User
    final User user = await repository.signInWithGoogle(context);
    return user;
  }
  
}