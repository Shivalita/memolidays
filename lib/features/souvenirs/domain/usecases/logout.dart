

import 'package:memolidays/features/souvenirs/data/repositories/souvenirs_repository.dart';

class Logout {

  final SouvenirsRepository repository = SouvenirsRepository();

  Future<void> call() async {
    await repository.signOutGoogle();
  }

}