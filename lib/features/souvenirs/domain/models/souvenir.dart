import 'package:memolidays/features/souvenirs/domain/models/file_data.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class Souvenir {

  int id;
  int userId;
  List<int> categoriesId;
  List<Category> categories;
  List<String> categoriesIris;
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
  List<FileData> thumbnails;
  String distance = "0 km";

  // Souvenir({
  //   this.id,
  //   this.userId,
  //   this.title,
  //   this.cover,
  //   this.eventDate,
  //   this.email,
  //   this.phone,
  //   this.comment,
  //   this.address,
  //   this.latitude,
  //   this.longitude,
  //   this.place,
  //   this.createdAt,
  // });


  // Instanciate from json API response
  Souvenir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    userId = int.parse(json['user'].split('/').last);
    eventDate = json['eventDate'].split('T')[0];
    email = json['email'];
    phone = json['phone'];
    comment = json['comment'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    place = json['place'];
    createdAt = json['createdAt'];
  }


  // Convert to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = "/api/users/" + this.userId.toString();
    data['title'] = this.title;
    data['cover'] = "https://drive.google.com/file/d/1tzwvblfizjQgsMt5aaouH6KrooyFCB4B";
    data['eventDate'] = this.eventDate;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['comment'] = this.comment;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['place'] = this.place;
    data['createdAt'] = this.createdAt;


    List<Map<String, dynamic>> filesList = [
      {
        "path": "https://drive.google.com/file/d/1JKk-7UKpvz3TORsT5CUzbbo49dpAHHXh",
        "type": "jpg",
        "token": "string",
      },
      {
        "path": " https://drive.google.com/file/d/14wIzc2VUn1mZINlh2N6GHkEKxRnO5qgG",
        "type": "jpg",
        "token": "string",
      },
      {
        "path": "https://drive.google.com/file/d/1Y0kzalbwb2WxzrWCobapfQAzRWfmPw7-",
        "type": "jpg",
        "token": "string",
      }
    ];

    data['files'] = filesList;


    List<Map<String, dynamic>> categoriesList = [];

    categories.forEach((category) {
      if (category.id != null) {
        Map<String, dynamic> existingCategory =  {
          "@id": "/api/categories/" + category.id.toString()
        };

        categoriesList.add(existingCategory);
      } else {
        Map<String, dynamic> pin = {
          "icon": "attraction",
          "color": "red",
        };

        Map<String, dynamic> newCategory =  {
          // "user": "/api/users/13",
          "user": "/api/users/" + this.userId.toString(),
          "name": category.name[0].toUpperCase() + category.name.substring(1),
          "pin": pin
        };

        categoriesList.add(newCategory);
      }
    });

    data['categories'] = categoriesList;

    return data;
  }

  // Instanciate from form data
  Souvenir.fromForm(Map<String, dynamic> data) {
    userId = data['userId'];
    title = data['title'][0].toUpperCase() + data['title'].substring(1);
    eventDate = data['eventDate'].toString();
    email = data['email'];
    phone = data['phone'];
    comment = data['comment'];
    categories = data['categories'].cast<Category>();
    createdAt = data['createdAt'].toString();

    // List<String> categoriesNames = categories.cast<String>();
    // categoriesId = categoriesNames.map((category) => int.parse(category.split('/').last)).toList();
    // categoriesId = categories.map((category) => category.id).toList();
    // categoriesId.add(0);
    //
    // cover = data['cover'];
    if (data['location'] != null && data['location'].isNotEmpty) {
      place = data['location']['place'];
      address = data['location']['address'];
      longitude = data['location']['coordinates'][0];
      latitude = data['location']['coordinates'][1];
    }
  }

}