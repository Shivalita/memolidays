import 'package:flutter/material.dart';
import 'package:memolidays/core/components/error_snackbar.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenirs.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/select_category.dart';
class SouvenirsState {

  List<Category> allCategoriesList;
  int selectedCategoryId = 0;
  List<List<Souvenir>> allSouvenirsList;
  int selectedSouvenirId = 0;
  List<Souvenir> selectedCategorySouvenirsList;

  Future<void> init(BuildContext context) async {
    allCategoriesList = await getCategoriesList(context);
    allSouvenirsList = await getSouvenirsList(context);
  }

  Future<List<Category>> getCategoriesList(BuildContext context) async {
    try {
      List<Category> categoriesList = await GetCategories()();
      return categoriesList;
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }

  Future<List<List<Souvenir>>> getSouvenirsList(BuildContext context) async {
    try {
      List<List<Souvenir>> allSouvenirsList = await GetSouvenirs()();
      return allSouvenirsList;
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }

    Future<List<Souvenir>> getSouvenirsByCategory(BuildContext context, int categoryId, int userId) async {
    try {
      List<Souvenir> souvenirsList = await SelectCategory()(categoryId, userId);
      return souvenirsList;
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }

}