import 'package:memolidays/features/login/data/repositories/login_repository.dart';
import 'package:memolidays/features/login/domain/models/user.dart';

class Login {

  final LoginRepository repository = LoginRepository();

  Future<User> call() async {
    final User user = await repository.login();
    return user;
  }
  
}