import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';

class SelectCategory {
  
  Category call(Category category) {
    Category selectedCategory = souvenirsState.state.selectedCategory;

    if ((selectedCategory == null) || (selectedCategory.id != category.id)) {
      selectedCategory = category;
    }

    return selectedCategory;
  }
}