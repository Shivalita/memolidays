import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ThumbnailLink {

  String orientation;

  String getThumbnailLink(String fullSizeLink, int desiredSize) {
    final String size = desiredSize.toString();
    final String start = "id=";
    final int startIndex = (fullSizeLink.indexOf(start) +3);
    final String thumbnailId = fullSizeLink.substring(startIndex);
    String thumbnailLink;

    // final file = File(fullSizeLink);
    // final fileSize = ImageSizeGetter.getSize(FileInput(file));
    // print(fileSize);

    // Image image = new Image.network('https://pixabay.com/fr/photos/cat-animal-de-compagnie-licking-114782/');
    // Completer<ui.Image> completer = new Completer<ui.Image>();
    // image.image
    // .resolve(new ImageConfiguration())
    // .addListener(ImageStreamListener(ImageInfo info, bool _) { 
    //   completer.complete(info.image);
    // });

    // var orientation = getImageOrientation(fullSizeLink);
    // print(orientation);

    String orientation = getImageOrientation();
    print(orientation);
    // getImageOrientation().then((orientation) => print('orientation = $orientation'));
    
    // //! Condition
    // if (orientation == 'landscape') {
    //   thumbnailLink = "https://drive.google.com/thumbnail?authuser=0&sz=w$size&id=$thumbnailId";
    // } else if (orientation == 'portrait') {
    //   thumbnailLink = "https://drive.google.com/thumbnail?authuser=0&sz=h$size&id=$thumbnailId";
    // }

    thumbnailLink = "https://drive.google.com/thumbnail?authuser=0&sz=s$size&id=$thumbnailId";

    return thumbnailLink;
  }

  // final _key = GlobalKey();
  // String getImageOrientation(fullSizeLink) {
  //   Image(image: NetworkImage('https://pixabay.com/fr/photos/chat-animal-de-compagnie-int%C3%A9rieur-4977436/'), key: _key,);
  //   // Size size = _key.currentContext.size;
  //   double height = _key.currentContext.size.height;
  //   double width = _key.currentContext.size.width;
  //   double aspectRatio = _key.currentContext.size.aspectRatio;
  //   print('height = $height');
  //   print('width = $width');
  //   print('aspectRatio = $aspectRatio');
  //   return 'OK';
  // }

  // dynamic getImageOrientation(fullSizeLink) {
  //   print('toto');
  //   final Completer completer = Completer();
  //   final String url = fullSizeLink;
  //   final image = NetworkImage(url);

  //   image.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool isSync) {
  //     var hashCode = info.image.hashCode;
  //     int width = info.image.width;
  //     int height = info.image.height;
  //     // if ((width != null) && (height != null)) {
  //       print("hashCode = $hashCode");
  //       print("width = $width");
  //       print("height = $height");
  //     // }
  //     completer.complete(info.image);
  //   }));

  //   return completer.future;
  // }

  String getImageOrientation() {
    Image image = Image.network("https://cdn.pixabay.com/photo/2013/05/30/18/21/cat-114782_1280.jpg");
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          double width = myImage.width.toDouble();
          double height = myImage.height.toDouble();
          print('width = $width');
          print('height = $height');

          if (width > height) {
            orientation = 'landscape';
            // print('orientation = $orientation');
            // return orientation;
          } else {
            orientation = 'portrait';
            // print('orientation = $orientation');
            // return orientation;
          }
        },
      ),
    );

    return orientation;
  }

}