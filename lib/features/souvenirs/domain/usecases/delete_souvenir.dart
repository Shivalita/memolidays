import 'package:memolidays/features/souvenirs/data/repositories/souvenirs_repository.dart';

final SouvenirsRepository repository = SouvenirsRepository();

class DeleteSouvenir {

  Future<void> call(int souvenirId) async {
    await repository.deleteSouvenir(souvenirId);
  }

}