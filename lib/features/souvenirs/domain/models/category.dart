import 'package:flutter/cupertino.dart';

class Category {

  int id;
  String name;

  Category({@required int id, String name}) {
    this.id = id;
    this.name = name;
  }

  //! Category constructor from map
  Category.fromJson(Map<String, dynamic> data) : this(
    id : data['id'], 
    name : data['name']
  );

}