import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenirs.dart';

import 'package:http/http.dart' as http;

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
    final String api = "http://94.23.11.60:8081/memoservices/api/v2/";

    List<List<Souvenir>> allSouvenirsList = await GetSouvenirs()(context);
    // print(allSouvenirsList);
    // print(allSouvenirsList[1]);
    // print(allSouvenirsList[1][0].title);
    var img = allSouvenirsList[1][0].cover;

    final String link = '${api}memories/view/799/387';
    final http.Response request = await http.get(link);
    
    if (request.statusCode != 200) throw Exception;

    var data = json.decode(request.body)['data'];
    print(data);


    return allSouvenirsList;
  }

}