import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetSouvenirCategories {

  // Get all souvenir's categories ids & add "All" category
  void call(Souvenir souvenir, List<Souvenir> souvenirsList) {
    List<int> categoriesIdsList = [];
    List<dynamic> categoriesList = souvenir.categoriesList;

    categoriesList.forEach((categoryString) {
      int categoryId = int.parse(categoryString.substring(categoryString.length -1));
      categoriesIdsList.add(categoryId);
    });

    List<int> cleanCategoriesIdsList = categoriesIdsList.toSet().toList();

    souvenir.categoriesId = cleanCategoriesIdsList;
    souvenir.categoriesId.add(0);

  }

}