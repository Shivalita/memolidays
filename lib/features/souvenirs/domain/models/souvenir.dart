import 'package:memolidays/features/souvenirs/domain/models/thumbnail.dart';

class Souvenir {

  int id;
  int owner;
  String title;
  String cover;
  String date;
  String email;
  String phone;
  String comment;
  String place;
  double lat;
  double lon;
  String token;
  String storage;
  String tempLink;
  List<Thumbnail> thumbnails;
  String distance = "0 km";

  Souvenir(
    {this.id,
    this.owner,
    this.title,
    this.cover,
    this.date,
    this.email,
    this.phone,
    this.comment,
    this.place,
    this.lat,
    this.lon,
    this.token,
    this.storage,
    this.tempLink,
    this.thumbnails}
  );

  //! Souvenir constructor from map
  Souvenir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    title = json['title'];
    cover = json['cover'];
    date = json['date'];
    email = json['email'];
    phone = json['phone'];
    comment = json['comment'];
    place = json['place'];
    lat = json['lat'];
    lon = json['lon'];
    token = json['token'];
    storage = json['storage'];
    tempLink = json['temp_link'];

    if (json['thumbnails'] != null) {
      thumbnails = List<Thumbnail>();
      json['thumbnails'].forEach((element) {
        thumbnails.add(Thumbnail.fromJson(element));
      });
    }

  }

  Souvenir.fromForm(Map<String, dynamic> map) {
    // id = map['id'];
    // owner = map['owner'];
    title = map['title'];
    // cover = map['cover'];
    date = map['date'];
    email = map['email'];
    phone = map['phone'];
    comment = map['comment'];
    place = map['location'];
    // lat = map['lat'];
    // lon = map['lon'];
    // token = map['token'];
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