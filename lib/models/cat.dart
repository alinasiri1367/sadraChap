class Cat {
  int id;
  String title;
  String pic;

  Cat({this.id, this.title, this.pic});

  Cat.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    pic = parsedJson['picture'];
  }
}
