import 'package:memolidays/features/souvenirs/data/repositories/souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class GetAllCategories {

  final SouvenirsRepository repository = SouvenirsRepository();
  
  Future<List<Category>> call() async {
    List<Category> categoriesList = await repository.getAllCategories();
    return categoriesList;
  }
  
}