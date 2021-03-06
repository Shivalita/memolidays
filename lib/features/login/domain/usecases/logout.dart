import 'package:memolidays/features/login/data/repositories/login_repository.dart';


class Logout {

  final LoginRepository repository = LoginRepository();

  Future<void> call() async {
    await repository.signOutGoogle();
  }

}