import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';

final ListSouvenirsRepository repository = ListSouvenirsRepository();

class RemoveSouvenir {

  Future<void> call(int souvenirId) async {
    await repository.removeSouvenir(souvenirId);
  }

}