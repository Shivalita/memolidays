import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenirs.dart';

class SouvenirsState {

  List<Category> allCategoriesList;
  Category currentCategory;
  List<List<Souvenir>> allSouvenirsList;
  List<Souvenir> currentCategorySouvenirsList;
  Souvenir currentSouvenir;

  Future<void> init(BuildContext context) async {
    allCategoriesList = await getCategoriesList(context);
    allSouvenirsList = await getSouvenirsList(context);
  }

  Future<List<Category>> getCategoriesList(BuildContext context) async {
    List<Category> categoriesList = await GetCategories()(context);
    return categoriesList;
  }

  Future<List<List<Souvenir>>> getSouvenirsList(BuildContext context) async {
    List<List<Souvenir>> souvenirsList = await GetSouvenirs()(context);
    return souvenirsList;
  }

}