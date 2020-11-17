import 'package:memolidays/features/login/data/repositories/login_repository.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';

class GetUser {
  final LoginRepository repository = LoginRepository();
  final LocalSource localSource = LocalSource();
  
  //!
  Future<User> call() async {
    int userId = localSource.getUserId();
    User user = await repository.getUser(userId);
    return user;
  }
}