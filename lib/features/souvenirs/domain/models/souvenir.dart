import 'package:memolidays/features/souvenirs/domain/models/file.dart';

class Souvenir {

  int id;
  int userId;
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
  // String storage;
  // String tempLink;
  // List<String> filesListUrls;
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
    // this.filesListUrls,
    // this.storage,
    // this.tempLink,
  });

  //! Souvenir constructor from map
  Souvenir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    cover = json['cover'];
    eventDate = json['eventDate'];
    email = json['email'];
    phone = json['phone'];
    comment = json['comment'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    place = json['place'];
    createdAt = json['createdAt'];

    // storage = json['storage'];
    // tempLink = json['temp_link'];

    // if (json['files'] != null) {
    //   thumbnails = List<File>();
    //   json['files'].forEach((element) {
    //     thumbnails.add(File.fromJson(element));
    //   });
    // }

  }

  Souvenir.fromForm(Map<String, dynamic> map) {
    // id = map['id'];
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