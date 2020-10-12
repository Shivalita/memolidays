//! Souvenirs state
import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenirs.dart';

class SouvenirsState {

    init(BuildContext context) async {

      List<Category> categoriesList = await GetSouvenirs()(context);
      // List<List<Souvenir>> souvenirs = await GetSouvenirs()(context);
      // print(souvenirs);

      print(categoriesList);
      print(categoriesList[0].name);

      return categoriesList;

    }

}

