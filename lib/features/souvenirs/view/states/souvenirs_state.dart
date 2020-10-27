import 'package:flutter/material.dart';
import 'package:memolidays/core/components/error_snackbar.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_souvenirs.dart';
class SouvenirsState {

  List<Category> allCategoriesList;
  Category selectedCategory;
  List<Souvenir> souvenirsList;
  Souvenir selectedSouvenir;

  Future<void> init(BuildContext context) async {
    allCategoriesList = await getCategoriesList(context);
    souvenirsList = await getSouvenirsList(context);
  }

  Future<List<Category>> getCategoriesList(BuildContext context) async {
    try {
      allCategoriesList = await GetAllCategories()();
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Server error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
    
    return allCategoriesList;
  }

  Future<List<Souvenir>> getSouvenirsList(BuildContext context) async {
    if ((selectedCategory != null) && (selectedCategory.id != 0)) {
      souvenirsList = selectedCategory.souvenirsList;
      return souvenirsList;
    }

    else {
      try {
        List<Souvenir> allSouvenirsList = await GetAllSouvenirs()(allCategoriesList);
        souvenirsList = allSouvenirsList;
      }

      on Exception {
        final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Server error : Please try again.');
        errorSnackbar.displayErrorSnackbar();
      }

      return souvenirsList;
    }
  }

   Future<Category> selectCategory(BuildContext context, Category category) async {
    if ((selectedCategory == null) || (selectedCategory.id != category.id)) {
      selectedCategory = category;
      souvenirsList = await getSouvenirsList(context);
    }
    return selectedCategory;
  }

  addSouvenir(data) {
    String date = data['date'].toString();
    String formattedDate = date.substring(0, 10);
    data['date'] = formattedDate;

    print('data = $data');

    bool isCategoryRegistered(String value) {
      var result = allCategoriesList.where((category) => (category.name.contains(value)));
      if (result.length >= 1) {
        return true;
      } else {
        return false;
      }
    } 

    

    List<dynamic> tagsList = data['tags'];
    tagsList.forEach((tag) {
      print('tag.name = ${tag.name}');
      bool isRegistered = isCategoryRegistered(tag.name);
      print(isRegistered);
    });

    Souvenir newSouvenir = Souvenir.fromForm(data);
    // souvenirsList.insert(0, newSouvenir);
    // return newSouvenir;
  }

}