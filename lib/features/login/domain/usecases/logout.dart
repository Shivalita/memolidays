import 'package:memolidays/features/login/data/repositories/login_repository.dart';

class Logout {

  final LoginRepository repository = LoginRepository();

  Future<String> call() async {
    String disconnectionMessage = await repository.signOutGoogle();
    return disconnectionMessage;
  }

}