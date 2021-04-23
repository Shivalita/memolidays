import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:memolidays/core/thumbnail_link.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/view/pages/add_souvenir_page.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

// ignore: must_be_immutable
class MemoriesComponent extends StatelessWidget {
  MemoriesComponent(this.changeScreen, {Key key}) : super(key: key);
  final Function changeScreen;

  List<Souvenir> souvenirs;
  bool isAnySouvenir;
  bool isLocationServiceEnabled;

  @override
  Widget build(BuildContext context) {
    souvenirs = souvenirsState.state.souvenirsList;
    isLocationServiceEnabled = souvenirsState.state.isLocalizationEnabled;

    if (souvenirs.isEmpty) {
      isAnySouvenir = false;
    } else {
      isAnySouvenir = true;
    }

    // Displays souvenirs if there are any, else displays welcome text & invites to add souvenir
    return isAnySouvenir ? Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: souvenirs.length,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                // On tap store selected souvenir in state & redirect to souvenir page
                onTap: () {
                  souvenirsState.setState((state) => state.selectedSouvenir = souvenirs[i]);
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
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child : Container(
                              width: 125,
                              height: 125,
                              // Display sized thumbnail from cache if stored, else store it
                              child: CachedNetworkImage(
                                imageUrl: ThumbnailLink().getThumbnailLink(souvenirs[i].cover, 250),
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 2)),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            )
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: new Color.fromRGBO(0, 0, 0, 0.5)
                            ),
                          ]),
                      child: Row(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                      width: 125,
                                      height: 125,
                                      child: (Image(
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        // Display sized thumbnail from cache if stored, else store it
                                        image: NetworkToFileImage(
                                            scale: 1,
                                            url: souvenirs[i]
                                                .thumbnails[0]
                                                .getThumbnailUrl(250),
                                            file:
                                                souvenirs[i].thumbnails[0].file,
                                            debug: true),
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null) {
                                            return Center(child: child);
                                          }
                                          return Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2));
                                        },
                                      )))),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: new Color.fromRGBO(0, 0, 0, 0.5)),
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      // Displays souvenir's photos number
                                      Text(
                                          souvenirs[i]
                                              .thumbnails
                                              .length
                                              .toString(),
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.photo_library,
                                        color: Colors.white,
                                        size: 17,
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      souvenirs[i].title,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
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
                                      // If localization possible, display souvenir's distance
                                      isLocationServiceEnabled
                                          ? Row(
                                              children: [
                                                FaIcon(FontAwesomeIcons.carSide,
                                                    color: Colors.lightBlue,
                                                    size: 18),
                                                SizedBox(width: 3),
                                                Text(
                                                  souvenirs[i].distance,
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 13),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })

          // Content to display when there are no memories yet
          ) : Container(

            // Content to display when there are no memories yet
            )
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "Welcome to Memolidays",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 130),
                  child: Text(
                    "Create your first souvenir",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: new Color.fromRGBO(0, 0, 0, 0.5)),
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.only(top: 50),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(AddSouvenirsPage(changeScreen));
                    },
                    child: Container(
                        height: 125,
                        width: 125,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.orange,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 3),
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[Icon(Icons.add_a_photo)],
                        )),
                  ),
                ),
              ],
            ),
          );
  }
}
