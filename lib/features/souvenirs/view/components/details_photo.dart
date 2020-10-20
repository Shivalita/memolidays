import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsPhoto extends StatefulWidget {
  final String imagePath;
  final String title;
  final String date;
  final String location;
  final String comment;
  final int index;
  DetailsPhoto(
      {this.imagePath,
      this.title,
      this.date,
      this.location,
      this.comment,
      this.index});

  @override
  _DetailsPhotoState createState() => _DetailsPhotoState();
}

class _DetailsPhotoState extends State<DetailsPhoto> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  List<ImageDetails> _images = [
    ImageDetails(
        imagePath: "https://source.unsplash.com/VFRTXGw1VjU",
        title: "Photo1",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome1!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/7ybKmhDTcz0",
        title: "Photo2",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome2!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/S0hS0HfH_B8",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae justo eget magna fermentum iaculis eu."),
    ImageDetails(
        imagePath: "https://source.unsplash.com/8CGT0Kq6K3k",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/BchXuilibLA",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/2N-kwvSeU5U",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/tHXX4fl3-ms",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/cjBLfrjE-XU",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/RH0QUHYPeW4",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome!"),
    ImageDetails(
        imagePath: "https://source.unsplash.com/kaEhf0eZme8",
        title: "Toto",
        date: "14 Octobre 2020",
        location: "Roanne",
        comment: "Super Week-end à Rome!"),
  ];

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: widget.index);
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          pageSnapping: true,
          itemCount: _images.length,
          itemBuilder: (context, int index) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    }),
                actions: [
                  IconButton(
                    icon: Icon(Icons.share),
                    color: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              // height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        "Share it with the world !",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.envelope,
                                          size: 30,
                                          color: HexColor("#000000"),
                                        ),
                                        onPressed: () {}
                                      ),
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.facebook,
                                          size: 30,
                                          color: HexColor("#0674E7"),
                                        ),
                                        onPressed: () {}
                                      ),
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.instagram,
                                          size: 30,
                                          color: HexColor("#C13584"),
                                        ),
                                        onPressed: () {}
                                      ),
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.twitter,
                                          size: 30,
                                          color: HexColor("#1da1f2"),
                                        ),
                                        onPressed: () {}
                                      ),
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.userCircle,
                                          size: 30,
                                          color: Colors.orange,
                                        ),
                                        onPressed: () {}
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          );
                        }
                      );
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    color: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                // height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "Are you sure you want to delete this photo ?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text("No"),
                                          color: Colors.red,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        RaisedButton(
                                          child: Text("Yes"),
                                          color: Colors.green,
                                          onPressed: () {
                                            //Delete This Image
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
              body: Container(
                child: Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: _images[index].imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ImageDetails {
  final String imagePath;
  final String title;
  final String date;
  final String location;
  final String comment;
  ImageDetails(
      {this.imagePath, this.title, this.date, this.location, this.comment});
}
