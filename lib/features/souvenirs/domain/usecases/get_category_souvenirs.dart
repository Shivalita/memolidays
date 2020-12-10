import 'package:memolidays/features/souvenirs/data/repositories/souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetCategorySouvenirs {

  final SouvenirsRepository repository = SouvenirsRepository();
  List<Souvenir> currentsouvenirsList = [];

  // Get all souvenirs that contain category's id in categoriesIds list
  List<Souvenir> call(int categoryId, List<Souvenir> allSouvenirsList) {
    allSouvenirsList.forEach((souvenir) {
      bool isCategorySouvenir = souvenir.categoriesId.contains(categoryId);
      if (isCategorySouvenir) {
        currentsouvenirsList.add(souvenir);
      }
    });

    return currentsouvenirsList;
  }
  
}