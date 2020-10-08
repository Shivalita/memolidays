//! Category Entity
import 'package:flutter/cupertino.dart';

class Category {

  String id;
  String name;

  Category({@required String id, String name}) {
    this.id = id;
    this.name = name;
  }

  //! Category constructor from map
  Category.fromJson(Map<String, dynamic> data) : this(
    id : data['id'].toString(), 
    name : data['name']
  );

}