//! Souvenirs state
import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenirs.dart';

class SouvenirsState {

    init(BuildContext context) async {

      // List<Souvenir> categories = await GetSouvenirs()(context);
      List<Souvenir> souvenirs = await GetSouvenirs()(context);
      print(souvenirs);

    }

}

