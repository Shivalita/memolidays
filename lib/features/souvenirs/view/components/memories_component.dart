import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/thumbnail_link.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

// ignore: must_be_immutable
class MemoriesComponent extends StatelessWidget {
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child : CachedNetworkImage(
                          imageUrl: ThumbnailLink().getThumbnailLink(souvenirs[i].tempLink, 125),
                          progressIndicatorBuilder: (context, url, downloadProgress) => 
                            CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        // child: Image(
                        //   // image: NetworkImage(souvenirs[i].tempLink),
                        //   image: CachedNetworkImage(
                        //     imageUrl: ThumbnailLink().getThumbnailLink(souvenirs[i].tempLink, 400),
                        //     progressIndicatorBuilder: (context, url, downloadProgress) => 
                        //       CircularProgressIndicator(value: downloadProgress.progress),
                        //     errorWidget: (context, url, error) => Icon(Icons.error),
                        //   ),
                        //   width: 125,
                        //   height: 125,
                        //   fit: BoxFit.cover,
                        // ),
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