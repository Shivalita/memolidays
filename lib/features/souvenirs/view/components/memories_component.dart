import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

// ignore: must_be_immutable
class MemoriesComponent extends StatelessWidget {
//Liste en dur des photos qui se trouveront dans les memories.
  // List<Post> memories = [
  //   Post(
  //       postImage: "https://source.unsplash.com/nnzkZNYWHaU",
  //       title: "Visite Tour Eiffel",
  //       location: "Paris,France",
  //       distance: "400 km"
  //   ),
  //   Post(
  //       postImage: "https://source.unsplash.com/VFRTXGw1VjU",
  //       title: "Vacances à Rome",
  //       location: "Rome, Italie",
  //       distance: "800 km"
  //   ),
  //   Post(
  //       postImage: "https://source.unsplash.com/2N3zNl0rQEI",
  //       title: "Chateau Loire",
  //       location: "Loire, France",
  //       distance: "62 km"
  //   ),
  //   Post(
  //       postImage: "https://source.unsplash.com/nnzkZNYWHaU",
  //       title: "Vacances Rome",
  //       location: "Loire, France",
  //       distance: "62 km"
  //   ),
  //   Post(
  //       postImage: "https://source.unsplash.com/nnzkZNYWHaU",
  //       title: "Vacances Rome",
  //       location: "Loire, France",
  //       distance: "62 km"
  //   ),
  //   Post(
  //       postImage: "https://source.unsplash.com/nnzkZNYWHaU",
  //       title: "Vacances Rome",
  //       location: "Loire, France",
  //       distance: "62 km"
  //   ),
  //   Post(
  //       postImage: "https://source.unsplash.com/nnzkZNYWHaU",
  //       title: "Vacances Rome",
  //       location: "Loire, France",
  //       distance: "62 km"
  //   ),
  // ];

  List<Souvenir> souvenirs;

  @override
  Widget build(BuildContext context) {
    souvenirs = souvenirsState.state.souvenirsList;

    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: souvenirs.length,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/souvenir');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: NetworkImage(souvenirs[i].cover),
                          width: 125,
                          height: 125,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  souvenirs[i].title,
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.red, size: 25),
                                      Text(
                                        souvenirs[i].place,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.carSide,
                                          color: Colors.lightBlue, size: 18),
                                      SizedBox(width: 3),
                                      Text(
                                        // souvenirs[i].distance,
                                        "62 km",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

//class Post {
  //final String postImage;
  //final String title;
  //final String location;
  //final String distance;

  //Post({this.postImage, this.title, this.location, this.distance});
//}
