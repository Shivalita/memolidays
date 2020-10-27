import 'package:flutter/cupertino.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class Category {

  int id;
  String name;
  List<Souvenir> souvenirsList;

  Category({int id, String name}) {
    this.id = id;
    this.name = name;
  }

  //! Category constructor from map
  Category.fromJson(Map<String, dynamic> data) : this(
    id : data['id'], 
    name : data['name']
  );

   Category.fromForm(Map<String, dynamic> data) : this(
    name : data['name']
  );

}