import 'package:flutter/material.dart';
import 'package:memolidays/core/components/error_snackbar.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_categories.dart';
class SouvenirsState {

  List<Category> allCategoriesList;
  Category selectedCategory;
  List<Souvenir> souvenirsList;
  Souvenir selectedSouvenir;

  int getMemolidaysId() {
  final LocalSource localSource = LocalSource();
  final Map<String, dynamic> idsMap = localSource.getUserIds();
  final int memolidaysId = idsMap['memolidaysId'];
  return memolidaysId;
  }

  Future<void> init(BuildContext context) async {
    allCategoriesList = await getCategoriesList(context);
  }

  Future<List<Category>> getCategoriesList(BuildContext context) async {
    try {
      allCategoriesList = await GetCategories()();
      return allCategoriesList;
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Server error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }

  Future<List<Souvenir>> getSouvenirsList() async {
    if (selectedCategory != null) {
      souvenirsList = selectedCategory.souvenirsList;
      return souvenirsList;
    }

    else {
      List<List<Souvenir>> allSouvenirsList = [];

      allCategoriesList.forEach((category) {
        List<Souvenir> categorySouvenirs = category.souvenirsList;
        allSouvenirsList.add(categorySouvenirs);
      });

      souvenirsList = allSouvenirsList.expand((element) => element).toList();
      return souvenirsList;
    }
  }

}