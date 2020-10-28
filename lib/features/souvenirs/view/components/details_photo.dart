import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:memolidays/core/thumbnail_link.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/thumbnail.dart';

class DetailsPhoto extends StatefulWidget {
  final int index;

  DetailsPhoto({this.index});

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

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: widget.index);
    List<Thumbnail> thumbnails = souvenirsState.state.selectedSouvenir.thumbnails;

    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          pageSnapping: true,
          itemCount: thumbnails.length,
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
                  child : CachedNetworkImage(
                    imageUrl: ThumbnailLink().getThumbnailLink(thumbnails[index].tempLink, 600),
                    progressIndicatorBuilder: (context, url, downloadProgress) => 
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 2)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  )

                ),
              ),
            );
          }),
    );
  }
}