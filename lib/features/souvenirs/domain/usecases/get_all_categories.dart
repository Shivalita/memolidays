import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class GetAllCategories {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();
  
  Future<List<Category>> call() async {
    List<Category> categoriesList = await repository.getCategoriesList();
    return categoriesList;
  }
  
}