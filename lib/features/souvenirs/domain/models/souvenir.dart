import 'package:memolidays/features/souvenirs/domain/models/thumbnail.dart';

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
  DateTime createdAt;
  // String storage;
  // String tempLink;
  //! List<Thumbnail> thumbnails;
  // String distance = "0 km";

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
    this.createdAt
    // this.storage,
    // this.tempLink,
  });

  //! Souvenir constructor from map
  Souvenir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    cover = json['cover'];
    eventDate = json['event_date'];
    email = json['email'];
    phone = json['phone'];
    comment = json['comment'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    place = json['place'];
    createdAt = json['created_at'];

    // storage = json['storage'];
    // tempLink = json['temp_link'];

    //! if (json['thumbnails'] != null) {
    //!   thumbnails = List<Thumbnail>();
    //!   json['thumbnails'].forEach((element) {
    //!     thumbnails.add(Thumbnail.fromJson(element));
    //!   });
    //! }

  }

  Souvenir.fromForm(Map<String, dynamic> map) {
    // id = map['id'];
    userId = map['user_id'];
    title = map['title'];
    // cover = map['cover'];
    eventDate = map['event_date'];
    email = map['email'];
    phone = map['phone'];
    comment = map['comment'];
    address = map['address'];
    createdAt = map['created_at'];
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