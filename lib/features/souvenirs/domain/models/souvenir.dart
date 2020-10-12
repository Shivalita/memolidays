import 'package:memolidays/features/souvenirs/domain/models/thumbnails.dart';

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
  List<Thumbnails> thumbnails;

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
      thumbnails = List<Thumbnails>();
      json['thumbnails'].forEach((element) {
        thumbnails.add(Thumbnails.fromJson(element));
      });
    }

  }

}