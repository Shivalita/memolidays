import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

final ListSouvenirsRepository repository = ListSouvenirsRepository();

class CreateSouvenir {

  Future<Souvenir>  call(Souvenir souvenir) async {
    await repository.createSouvenir(souvenir);
  }

}