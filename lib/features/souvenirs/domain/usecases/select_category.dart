import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class SelectCategory {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();

  Future<List<Souvenir>> call(int categoryId, int userId) async {
    // List<Souvenir> souvenirs = await repository.getSouvenirsByCategory(categoryId, userId);
    // return souvenirs;
  }
  
}