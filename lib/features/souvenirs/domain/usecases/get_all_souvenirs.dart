import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetAllSouvenirs {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();

  Future<List<Souvenir>> call() async {
    List<Souvenir> souvenirsList = await repository.getAllSouvenirs();
    return souvenirsList;
  }
  
}