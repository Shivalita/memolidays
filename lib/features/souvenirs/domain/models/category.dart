import 'package:memolidays/features/souvenirs/domain/models/pin.dart';

class Category {

  int id;
  int userId;
  Pin pin;
  String name;

  Category({int id, int userId, Pin pin, String name}) {
    this.id = id;
    this.userId = userId;
    this.pin = pin;
    this.name = name;
  }

  // Instanciate from json API response 
  Category.fromJson(Map<String, dynamic> data) {
    id = data['id']; 
    userId = int.parse(data['user'].split('/').last); 
    pin = Pin.fromJson(data['pin']); 
    name = data['name'];
  }

  // Instanciate "All" category
  Category.all(Map<String, dynamic> data) {
    id = data['id']; 
    userId = data['userId']; 
    name = data['name'];
  }

  // Instanciate from addSouvenir form
  Category.fromForm(Map<String, dynamic> data) {
    id = data['id']; 
    userId = data['userId'];
    name = data['name'];
    
    if (data['pin'] != null) {
      pin = data['pin'];
    }

  }

}