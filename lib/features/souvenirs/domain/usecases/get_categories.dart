import 'package:flutter/material.dart';
import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class GetCategories implements Usecase {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();
  @override
  
  Future<List<Category>> call(BuildContext context) async {
    List<Category> categoriesList = await repository.getCategoriesList(context);
    return categoriesList;
  }
  
}