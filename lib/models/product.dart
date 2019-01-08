class Product {
  String title;
  String code;
  String pic;
  String size_type;

  Product(this.title, this.code, this.pic, this.size_type);

  Product.fromJson(Map<String, dynamic> paredJson) {
    title = paredJson['title'];
    code = paredJson['code'];
    pic = paredJson['picture'];
    size_type = paredJson['size_type'];
  }
}
