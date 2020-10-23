import 'dart:async';
class ThumbnailLink {

  String getThumbnailLink(String fullSizeLink, int desiredSize) {
    final String size = desiredSize.toString();
    final String start = "id=";
    final int startIndex = (fullSizeLink.indexOf(start) +3);
    final String thumbnailId = fullSizeLink.substring(startIndex);

    String thumbnailLink = "https://drive.google.com/thumbnail?authuser=0&sz=s$size&id=$thumbnailId";

    return thumbnailLink;
  }

}