//! Souvenir Entity
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['owner'] = this.owner;
  //   data['title'] = this.title;
  //   data['cover'] = this.cover;
  //   data['date'] = this.date;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['comment'] = this.comment;
  //   data['place'] = this.place;
  //   data['lat'] = this.lat;
  //   data['lon'] = this.lon;
  //   data['token'] = this.token;
  //   data['storage'] = this.storage;
  //   data['temp_link'] = this.tempLink;

  //   if (this.thumbnails != null) {
  //     data['thumbnails'] = this.thumbnails.map((element) => element.toJson()).toList();
  //   }
  //   return data;
  // }
}

// class Souvenir {

//   int id;
//   int ownerId;
//   String title;
//   String cover;
//   String date;
//   String email;
//   String phone;
//   String comment;
//   String place;
//   double latitude;
//   double longitude;
//   String token;
//   String storage;
//   String tempLink;
//   List<dynamic> thumbnails;


//   Souvenir({@required int id, int ownerId, String title, String cover, String date, 
//                       String email, String phone, String comment, String place, double latitude, 
//                       double longitude, String token, String storage, String tempLink, 
//                       List<dynamic> thumbnails, }) {
//     this.id = id;
//     this.ownerId = ownerId;
//     this.title = title;
//     this.cover = cover;
//     this.date = date;
//     this.email = email;
//     this.phone = phone;
//     this.comment = comment;
//     this.place = place;
//     this.latitude = latitude;
//     this.longitude = longitude;
//     this.token = token;
//     this.storage = storage;
//     this.tempLink = tempLink;
//     this.thumbnails = thumbnails;

//   }



  // //! Souvenir constructor from map
  // Souvenir.fromJson(Map<String, dynamic> data) : this(
  //   id : data['id'], 
  //   ownerId : data['owner'],
  //   title : data['title'],
  //   cover : data['cover'],
  //   date : data['date'],
  //   email : data['email'],
  //   phone : data['phone'],
  //   comment : data['comment'],
  //   place : data['place'],
  //   latitude : data['lat'],
  //   longitude : data['lon'],
  //   token : data['token'],
  //   storage : data['storage'],
  //   tempLink : data['temp_link'],
  //   thumbnails : data['thumbnails'],

  // );

// }

//! JSON received
// {
//   "id": 387, 
//   "owner": 799, 
//   "title": "Test2", 
//   "cover": "/1jf3qurswfClBU0RofQlTdZNw61XG0yEn/1J6naZ2g1rsHolxNDMbq828f3P2tyRPs1/90531116229583978520.png", 
//   "date": "2020-06-20", 
//   "email": "test@test.r", 
//   "phone": 061234567890, 
//   "comment": "Test test test", 
//   "place": "--", 
//   "lat": 46.046955, 
//   "lon": 3.8707712, 
//   "token": "ya29.a0AfH6SMC7Ru9XDvhtptNZrmblzg8kDAc_x1yZZpzlOYvgvvd54bFbxdEs5l8LFw61AxRrz4vl3ZBPPYA9_YvA9qPk2iTLI-B4p9sBCT1GFHAVydjizv762AE5JblZLM6xbw-eH2ntOOkg0o_x_LIovQcMGoFJH6InwhHWdw", 
//   "storage": "1jf3qurswfClBU0RofQlTdZNw61XG0yEn", 
//   "temp_link": "https://drive.google.com/uc?id=1J6naZ2g1rsHolxNDMbq828f3P2tyRPs1", 
//   "thumbnails": 
//   [
//     {
//       "path": "/1jf3qurswfClBU0RofQlTdZNw61XG0yEn/1bCgwrIOVe2UyJgvSKArwb1Pnxf7NkG6B/undefined", 
//       "type": "audio", 
//       "frame": "--", 
//       "status": 1, 
//       "flag1": 1, 
//       "flag2": 0, 
//       "id": 3811, 
//       "temp_link": "https://drive.google.com/uc?id=1bCgwrIOVe2UyJgvSKArwb1Pnxf7NkG6B"
//     }, 
//     {
//       "path": "/1jf3qurswfClBU0RofQlTdZNw61XG0yEn/1mpzHGWiTqkuT6slAW3A1wVSIrIeP4mUb/undefined", 
//       "type": "video", 
//       "frame": "--", 
//       "status": 1, 
//       "flag1": 1, 
//       "flag2": 0, 
//       "id": 3810, 
//       "temp_link": "https://drive.google.com/uc?id=1mpzHGWiTqkuT6slA"

//     }
//   ]
// }