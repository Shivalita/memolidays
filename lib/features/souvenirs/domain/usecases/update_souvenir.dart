import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

final ListSouvenirsRepository repository = ListSouvenirsRepository();

class UpdateSouvenir {

  Future<Souvenir> call(int souvenirId, Souvenir newSouvenirData) async {
    Souvenir updatedSouvenir = await repository.updateSouvenir(souvenirId, newSouvenirData);
    return updatedSouvenir;
  }

}
