import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/core/thumbnail_link.dart';

// ignore: must_be_immutable
class SouvenirHeader extends StatelessWidget {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;

  @override
  Widget build(BuildContext context) {
    // var thumbnailLink = ThumbnailLink();
    return Container(
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment.bottomLeft, 
        children: <Widget>[
        Container(
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(12),
            child : CachedNetworkImage(
              // imageUrl: getImageLink(souvenir.tempLink, 400),
              // imageUrl: await thumbnailLink.getThumbnailLink(souvenir.tempLink, 400),
              // imageUrl: ThumbnailLink() async => await getThumbnailLink(souvenir.tempLink, 400),
              imageUrl: ThumbnailLink().getThumbnailLink(souvenir.tempLink, 400),
              progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            souvenir.title,
            maxLines: 4,
            style: TextStyle(
              fontSize: 35,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 10.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        ]
      ),
    );
  }

  // Future<String> getImageLink(String fullSizeLink, int desiredSize) async {
  //   ThumbnailLink thumbnailLink = ThumbnailLink();
  //   String imageLink = await thumbnailLink.getThumbnailLink(fullSizeLink, desiredSize);
  //   return imageLink;
  // }
}