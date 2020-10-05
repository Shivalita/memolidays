//! Gestion des datas de connexion

import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/features/login/data/repositories/login_repository.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/view/components/flush.dart';

class Login implements Usecase {

  final LoginRepository repository = LoginRepository();

  @override
  Future<User> call(context) async {

    try {
      
      User user = await repository.signInWithGoogle(context);
      return user;

    } 

    on Exception {

      final Flush flushbar = Flush();
      flushbar.displayFlushbar(context);

    }

  }
}