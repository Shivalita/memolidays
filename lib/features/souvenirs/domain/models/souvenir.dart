import 'package:memolidays/features/souvenirs/domain/models/file.dart';

class Souvenir {

  int id;
  int userId;
  List<dynamic> categoriesList;
  List<int> categoriesId;
  String title;
  String cover;
  String eventDate;
  String email;
  String phone;
  String comment;
  String address;
  double latitude;
  double longitude;
  String place;
  String createdAt;
  List<File> thumbnails;
  String distance = "0 km";

  Souvenir({
    this.id,
    this.userId,
    this.title,
    this.cover,
    this.eventDate,
    this.email,
    this.phone,
    this.comment,
    this.address,
    this.latitude,
    this.longitude,
    this.place,
    this.createdAt, 
  });


  // Instanciate from json API response 
  Souvenir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    cover = json['cover'];
    eventDate = json['eventDate'].substring(0, 10);
    email = json['email'];
    phone = json['phone'];
    comment = json['comment'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    place = json['place'];
    createdAt = json['createdAt'];
    categoriesList = json['categories'];
  }


  // Convert to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['place'] = this.place;
    data['categories'] = this.categoriesList;
    data['eventDate'] = this.eventDate;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['comment'] = this.comment;
    return data;
  }


  // Instanciate from form data
  Souvenir.fromForm(Map<String, dynamic> data) {
    userId = data['userId'];
    title = data['title'];
    place = data['place'];
    eventDate = data['eventDate'].toString();
    email = data['email'];
    phone = data['phone'];
    comment = data['comment'];
    categoriesList = data['categories'];
    // cover = data['cover'];
    // address = data['address'];
    // latitude = map['latitude'];
    // longitude = map['longitude'];
    // createdAt = data['createdAt'];
  }

}