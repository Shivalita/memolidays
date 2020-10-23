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
  String toto = "toto";

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

  Souvenir addSouvenir(data) {
    print('ok');
    print('data = $data');
    Map dataMap = Map<String, dynamic>.from(data);
    print('dataMap = $dataMap');

    // Souvenir newSouvenir = dataMap.map((data) => Souvenir.fromForm(data)).toList();
    Souvenir newSouvenir = Souvenir.fromForm(dataMap);
    print('newSouvenir = $newSouvenir');
    print(newSouvenir.title);
    print(newSouvenir.comment);
    return newSouvenir;
  }

  getTata() {
    print('TATAAAAA');
  }

}