class Pin {

  int id;
  String icon;
  String color;

  Pin({int id, String icon, String color}) {
    this.id = id;
    this.icon = icon;
    this.color = color;
  }

  //! Pin constructor from map
  Pin.fromJson(Map<String, dynamic> data) : this(
    id : data['id'], 
    icon : data['icon'], 
    color : data['color'], 
  );

}