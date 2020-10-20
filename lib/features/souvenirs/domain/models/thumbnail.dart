class Thumbnail {
  String path;
  String type;
  String frame;
  int status;
  int flag1;
  int flag2;
  int id;
  String tempLink;

  Thumbnail(
    {this.path,
    this.type,
    this.frame,
    this.status,
    this.flag1,
    this.flag2,
    this.id,
    this.tempLink}
  );

  //! Souvenir constructor from map
  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
    frame = json['frame'];
    status = json['status'];
    flag1 = json['flag1'];
    flag2 = json['flag2'];
    id = json['id'];
    tempLink = json['temp_link'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['path'] = this.path;
  //   data['type'] = this.type;
  //   data['frame'] = this.frame;
  //   data['status'] = this.status;
  //   data['flag1'] = this.flag1;
  //   data['flag2'] = this.flag2;
  //   data['id'] = this.id;
  //   data['temp_link'] = this.tempLink;
  //   return data;
  // }
}