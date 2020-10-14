import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Memories extends StatefulWidget {
  @override
  _MemoriesState createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
//Liste en dur des photos qui se trouveront dans les memories.
  List<Post> memories = [
    Post(
        postImage:
            "https://images.pexels.com/photos/302769/pexels-photo-302769.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
        title: "Vacances Rome"),
    Post(
        postImage:
            "https://images.pexels.com/photos/884979/pexels-photo-884979.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
        title: "Vacances Rome"),
    Post(
        postImage:
            "https://images.pexels.com/photos/291762/pexels-photo-291762.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
        title: "Vacances Rome"),
    Post(
        postImage:
            "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
        title: "Vacances Rome"),
    Post(
        postImage:
            "https://images.pexels.com/photos/247298/pexels-photo-247298.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
        title: "Vacances Rome"),
    Post(
        postImage:
            "https://images.pexels.com/photos/169191/pexels-photo-169191.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
        title: "Vacances Rome"),
    Post(
        postImage:
            "https://images.pexels.com/photos/1252983/pexels-photo-1252983.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=150&w=150",
        title: "Vacances Rome"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: memories.length,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                  onTap: () {
                    Get.toNamed('/souvenir');
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image(
                                      image:
                                          NetworkImage(memories[i].postImage),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(memories[i].title),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }));
  }
}

class Post {
  final String postImage;
  final String title;

  Post({this.postImage, this.title});
}
