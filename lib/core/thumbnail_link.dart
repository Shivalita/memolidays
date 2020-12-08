class ThumbnailLink {

  // Get sized thumbnail url from file url
  String getThumbnailLink(String fullSizeLink, int desiredSize) {
    final String size = desiredSize.toString();
    final String thumbnailId = fullSizeLink.substring(fullSizeLink.length - 33);

    String thumbnailLink = "https://drive.google.com/thumbnail?authuser=0&sz=s$size&id=$thumbnailId";
    return thumbnailLink;
  }

}