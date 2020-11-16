import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetAllSouvenirs {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();

  Future<List<Souvenir>> call() async {
    // List<List<Souvenir>> allSouvenirsList = [];

    // allCategoriesList.forEach((category) {
    //   List<Souvenir> categorySouvenirs = category.souvenirsList;
    //   allSouvenirsList.add(categorySouvenirs);
    // });

    // List<Souvenir> souvenirsList = allSouvenirsList.expand((element) => element).toList();

    List<Souvenir> souvenirsList = await repository.getAllSouvenirs();
    return souvenirsList;
  }
  
}