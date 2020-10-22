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
            // borderRadius: BorderRadius.circular(12),
            child : CachedNetworkImage(
              imageUrl: ThumbnailLink().getThumbnailLink(souvenir.tempLink, 600),
              progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
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

}