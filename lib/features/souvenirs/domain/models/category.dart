//! Category Entity
class Category {

  String id;
  String name;

  Category(String id, String name) {
    this.id = id;
    this.name = name;
  }

  Category.fromJson(Map<String, dynamic> data);

}