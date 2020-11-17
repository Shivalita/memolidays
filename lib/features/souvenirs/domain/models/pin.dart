class Pin {

  int id;
  String icon;
  String color;

  Pin({int id, String icon, String color}) {
    this.id = id;
    this.icon = icon;
    this.color = color;
  }

  // Instanciate from json API response 
  Pin.fromJson(Map<String, dynamic> data) {
    id = data['id']; 
    icon = data['icon']; 
    color = data['color']; 
  }

}