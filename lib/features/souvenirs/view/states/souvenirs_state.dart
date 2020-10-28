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

  void addSouvenir(data) {
    String date = data['date'].toString();
    String formattedDate = date.substring(0, 10);
    data['date'] = formattedDate;

    print('data = $data');
    Souvenir newSouvenir = Souvenir.fromForm(data);

    registerCategories(data, newSouvenir);
  }

  registerCategories(Map data, Souvenir newSouvenir) {
    List<Category> existingCategories = [];
    List<Category> result;

    List<dynamic> tagsList = data['tags'];
    tagsList.forEach((tag) {
      result = allCategoriesList.where((category) => (category.name.contains(tag.name))).toList();
      if (result.length >= 1) {
        existingCategories.add(result[0]);
      }
    });

    // print('existingCategories = $existingCategories');
    // print('existingCategories[0].souvenirsList.length = ${existingCategories[0].souvenirsList.length}');
    // print('existingCategories[0].souvenirsList[0].title = ${existingCategories[0].souvenirsList[0].title}');

    if (existingCategories.isNotEmpty) {
      existingCategories.forEach((category) {
        // print('category.name = ${category.name}');
        // print('category.souvenirsList.length = ${category.souvenirsList.length}');
        // print('category.souvenirsList[0].title = ${category.souvenirsList[0].title}');
        category.souvenirsList.insert(0, newSouvenir);
        // print('category.name = ${category.name}');
        // print('category.souvenirsList.length = ${category.souvenirsList.length}');
        // print('category.souvenirsList[0].title = ${category.souvenirsList[0].title}');
      });
    } else {
      print('allCategoriesList.length = ${allCategoriesList.length}');
      print('allCategoriesList[0].name = ${allCategoriesList[0].name}');
      tagsList.forEach((tag) {
        allCategoriesList.insert(0, tag);
        // print('allCategoriesList = ${allCategoriesList}');
    });
      print('allCategoriesList.length = ${allCategoriesList.length}');
      print('allCategoriesList[0].name = ${allCategoriesList[0].name}');
    }


  }

}