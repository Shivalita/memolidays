import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<UserCategory> _category = [
    //Liste en dur des photos qui se trouveront dans les categories.
    UserCategory(
        "https://source.unsplash.com/r9RW20TrQ0Y/250x141",
        "Landscapes"),
    UserCategory(
        "https://source.unsplash.com/tEMvvWXqAFw/250x141",
        "Oceans"),
    UserCategory(
        "https://source.unsplash.com/3mWxKnqET3E/250x141",
        "Gaming"),
    UserCategory(
        "https://source.unsplash.com/zNRITe8NPqY/250x141",
        "Work"),
    UserCategory(
        "https://source.unsplash.com/4_jhDO54BYg/250x141",
        "Food")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10),
      height: 171,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: _category.map((usercategory) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Get.toNamed('/'); //! Ici mettre le lien vers la photo en question.
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image: NetworkImage(usercategory.image),
                        width: 250,
                        height: 141,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(usercategory.name),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class UserCategory {
  final String image;
  final String name;
  UserCategory(this.image, this.name);
}
