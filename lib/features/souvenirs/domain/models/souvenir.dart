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

  // Instanciate from addSouvenir form
  Souvenir.fromForm(Map<String, dynamic> map) {
    userId = map['userId'];
    title = map['title'];
    // cover = map['cover'];
    eventDate = map['eventDate'];
    email = map['email'];
    phone = map['phone'];
    comment = map['comment'];
    address = map['address'];
    createdAt = map['createdAt'];
    // place = map['place'];
    // latitude = map['latitude'];
    // longitude = map['longitude'];
    // storage = map['storage'];
    // tempLink = map['temp_link'];

    // if (map['thumbnails'] != null) {
    //   thumbnails = List<Thumbnail>();
    //   map['thumbnails'].forEach((element) {
    //     thumbnails.add(Thumbnail.fromJson(element));
    //   });
    // }

  }

}