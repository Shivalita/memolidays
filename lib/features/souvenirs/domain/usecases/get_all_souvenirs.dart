import 'package:memolidays/features/souvenirs/data/repositories/souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetAllSouvenirs {

  final SouvenirsRepository repository = SouvenirsRepository();

  Future<List<Souvenir>> call() async {
    List<Souvenir> souvenirsList = await repository.getAllSouvenirs();
    return souvenirsList;
  }
  
}