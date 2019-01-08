class Page {
  String pic;
  int catId;
  String title;

  Page({this.pic, this.catId, this.title});

  Page.fromJson(Map<String, dynamic> paredJson) {
    pic = paredJson['pic'];
    catId = paredJson['catId'];
    title = paredJson['title'];
  }
}
