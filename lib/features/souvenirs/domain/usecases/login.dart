import 'package:memolidays/features/souvenirs/data/repositories/souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/user.dart';

class Login {

  final SouvenirsRepository repository = SouvenirsRepository();

  Future<User> call() async {
    final User user = await repository.login();
    return user;
  }
  
}