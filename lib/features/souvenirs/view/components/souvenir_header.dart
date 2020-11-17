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
    return Container(
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment.bottomLeft, 
        children: <Widget>[
        Container(
          child: ClipRRect(
            // Display sized thumbnail from cache if stored, else store it
            child : CachedNetworkImage(
              imageUrl: ThumbnailLink().getThumbnailLink(souvenir.cover, 600),
              progressIndicatorBuilder: (context, url, downloadProgress) => 
                Center(child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 2)),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/1.5,
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
            Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: new Color.fromRGBO(0, 0, 0, 0.5)
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    souvenir.thumbnails.length.toString(),
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                    )
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.photo_library, color: Colors.white, size: 25)
                ],
              )
            )
          ],
        ),
        ]
      ),
    );
  }

}