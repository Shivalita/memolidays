import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetSouvenirs {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();

  Future<List<List<Souvenir>>> call() async {
    List<List<Souvenir>> souvenirs = await repository.getAllSouvenirsList();
    return souvenirs;
  }
  
}